import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

// class Question untuk menyimpan data pertanyaan
class Question {
  String narration;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String answer;

  Question(this.narration, this.optionA, this.optionB, this.optionC,
      this.optionD, this.answer);
}

class _QuizState extends State<Quiz> {
  int _hitung = 30;
  late Timer _timer;
  bool _isRunning = false;
  final int _initValue = 30;
  List<Question> _questions = [];
  int _question_no = 0;
  int _point = 0;

  @override
  void initState() {
    super.initState();

    
    _questions = [
      Question("Not a member of Avenger", 'Ironman', 'Spiderman', 'Thor',
          'Hulk Hogan', 'Hulk Hogan'),
      Question("Not a member of Teletubbies", 'Dipsy', 'Patrick', 'Laalaa',
          'Poo', 'Patrick'),
      Question("Not a member of Justice League", 'Batman', 'Aquades',
          'Superman', 'Flash', 'Aquades'),
      Question("Not a member of BTS", 'Jungkook', 'Jimin', 'Gong Yoo', 'Suga',
          'Gong Yoo'),
    ];
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_hitung == 0) {
          _timer.cancel();
          _isRunning = false;
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Quiz'),
              content: Text('Quiz Ended!\nYour Score: $_point'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    resetQuiz();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          _hitung--;
        }
      });
    });
    _isRunning = true;
  }

  void stopTimer() {
    _timer.cancel();
    _isRunning = false;
  }

  void resetQuiz() {
    setState(() {
      _hitung = _initValue;
      _question_no = 0;
      _point = 0;
      _isRunning = false;
    });
  }

  

  void checkAnswer(String selectedOption) {
    String correctAnswer = _questions[_question_no].answer;
    if (selectedOption == correctAnswer) {
      _point += 10;
    }

    if (_question_no < _questions.length - 1) {
      setState(() {
        _question_no++;
      });
    } else {
      _timer.cancel();
      _isRunning = false;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Quiz Finished'),
          content: Text('Your Score: $_point'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                resetQuiz();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    if (_isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percent =
        _initValue == 0 ? 0 : (1 - (_hitung / _initValue).clamp(0, 1));

    // Cegah error saat belum ada pertanyaan
    final question = _questions.isNotEmpty
        ? _questions[_question_no]
        : Question("", "", "", "", "", "");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 20.0,
                percent: percent,
                center: Text(
                  formatTime(_hitung),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.red,
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 30),
              Text(
                "Q${_question_no + 1}: ${question.narration}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
             
              TextButton(
                  onPressed: () =>
                      checkAnswer(_questions[_question_no].optionA),
                  child: Text("A. ${_questions[_question_no].optionA}")),
              TextButton(
                  onPressed: () =>
                      checkAnswer(_questions[_question_no].optionB),
                  child: Text("B. ${_questions[_question_no].optionB}")),
              TextButton(
                  onPressed: () =>
                      checkAnswer(_questions[_question_no].optionC),
                  child: Text("C. ${_questions[_question_no].optionC}")),
              TextButton(
                  onPressed: () =>
                      checkAnswer(_questions[_question_no].optionD),
                  child: Text("D. ${_questions[_question_no].optionD}")),
                
              const SizedBox(height: 30),
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
      ),
    );
  }
}
