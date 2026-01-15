import 'package:flutter/material.dart';
import 'package:quiz_app/question.dart';

void main() {
  runApp(Quiz());
}

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  List<Icon> scoreKeeper = [];

  List<Question> questionsList = [
    Question(
      questionText: 'You can lead a cow down stairs but not up stairs',
      answers: false,
    ),
    Question(
      questionText: 'Approximately one quarter of human bones are in the fee',
      answers: true,
    ),
    Question(questionText: 'A slug\'s blood is green', answers: true),
  ];

  int questionNumber = 0;

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionsList[questionNumber].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                bool correctAnswer = questionsList[questionNumber].answers;

                if (correctAnswer) {
                  print('User was correct');
                } else {
                  print('User was wrong');
                }
                setState(() {
                  questionNumber++;
                });
              },
              child: Text('True'),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                bool correctAnswer = questionsList[questionNumber].answers;

                if (!correctAnswer) {
                  print('User was correct');
                } else {
                  print('User was wrong');
                }

                setState(() {
                  questionNumber++;
                });
              },
              child: Text('False'),
            ),
          ),
        ),

        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: scoreKeeper),
          ),
        ),

        // TODO: Create a new display to show users answers
      ],
    );
  }
}
