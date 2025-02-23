import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/questions.dart';
import '../data/quiz_data.dart';
import '../widget/result_dialog.dart';

class QuizScreen extends StatefulWidget {
  final String subject;
  const QuizScreen({super.key, required this.subject});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = [];
  int currentIndex = 0;
  int totalScore = 0;
  bool quizCompleted = false;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  void fetchQuestions() {
    final String? data = quizDataBySubject[widget.subject];

    if (data != null) {
      final parsedData = json.decode(data);
      setState(() {
        questionList = (parsedData['questions'] as List)
            .map((q) => Question.fromJson({
              'question': q['question'],
              'options': List<String>.from(q['options']),
              'answer': q['answer'],
            }))
            .toList();
      });
    } else {
      setState(() {
        questionList = [];
      });
    }
  }

  void evaluateAnswer(String chosenAnswer) {
    if (quizCompleted) return;

    if (chosenAnswer == questionList[currentIndex].answer) totalScore++;

    if (currentIndex < questionList.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      setState(() {
        quizCompleted = true;
      });
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => ResultDialog(
        score: totalScore,
        total: questionList.length,
        restartQuiz: resetQuiz,
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      currentIndex = 0;
      totalScore = 0;
      quizCompleted = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: questionList.isEmpty
            ? const Center(child: Text("No questions available for this subject."))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${currentIndex + 1}/${questionList.length}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.teal),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    questionList[currentIndex].question,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: questionList[currentIndex].options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () => evaluateAnswer(option),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            child: Text(option),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}