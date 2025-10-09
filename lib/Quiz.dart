import 'package:flutter/material.dart';
import 'dart:async';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  int _hitung = 0;
  Timer? _timer; // pakai nullable supaya bisa dicek null
  bool _isRunning = false; // status timer

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _hitung++;
      });
    });
    _isRunning = true;
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  @override
  void dispose() {
    _timer?.cancel(); // aman walau null
    _hitung = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _hitung.toString(),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_isRunning) {
                    stopTimer();
                  } else {
                    startTimer();
                  }
                });
              },
              child: Text(_isRunning ? "Stop" : "Start"),
            ),
          ],
        ),
      ),
    );
  }
}
