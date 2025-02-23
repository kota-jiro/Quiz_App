import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback restartQuiz;

  const ResultDialog({super.key, required this.score, required this.total, required this.restartQuiz});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quiz Completed!'),
      content: Text('Your Score: $score / $total'),
      actions: [
        TextButton(
          onPressed: restartQuiz,
          child: const Text('Restart'),
        ),
        TextButton(
          onPressed: () => Navigator.popUntil(
              context,
              (route) => route.isFirst,
            ),
          child: const Text('Close'),
        ),
      ],
    );
  }
}