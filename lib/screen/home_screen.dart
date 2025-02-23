import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void startQuiz(BuildContext context, String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(subject: subject),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select a Subject")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Choose a subject to start the quiz:",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ..._buildSubjectButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSubjectButtons(BuildContext context) {
    final subjects = ["Mathematics", "Science", "Philippine History", "Technology"];
    return subjects.map((subject) {
      return Column(
        children: [
          _createSubjectButton(context, subject),
          const SizedBox(height: 20),
        ],
      );
    }).toList();
  }

  Widget _createSubjectButton(BuildContext context, String subject) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => startQuiz(context, subject),
        child: Text(
          subject,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}