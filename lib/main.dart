import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

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

  int correctAnswers = 0;

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Completed",
          desc: "You scored $correctAnswers out of ${scoreKeeper.length}.",
          buttons: [
            DialogButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => {
                setState(() {
                  quizBrain.reset();
                  scoreKeeper = [];
                  correctAnswers = 0;
                }),
                Navigator.pop(context),
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.red,
            ),
          ],
        ).show();

        return;
      }

      if (correctAnswer == userAnswer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        correctAnswers++;
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
      quizBrain.nextQuestion();
    });
  }

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
                quizBrain.getQuestionText(),
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
                checkAnswer(true);
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
                checkAnswer(false);
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
