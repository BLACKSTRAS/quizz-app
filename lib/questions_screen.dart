import 'package:flutter/material.dart';
import 'package:myapp/answer_button.dart';
import 'package:myapp/data/quizz.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0; // ตำแหน่งของคำถามปัจจุบัน
  int score = 0; // ตัวแปรเก็บคะแนน

  void answerQuestion(String selectedAnswer) {
    // ตรวจสอบคำตอบและเพิ่มคะแนน
    if (selectedAnswer == questions[currentQuestionIndex].answers[0]) {
      setState(() {
        score++; // เพิ่มคะแนนถ้าตอบถูก
      });
    }

    // เปลี่ยนคำถามถัดไป
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++; // ไปยังคำถามถัดไป
      } else {
        // จบการสอบเมื่อถึงคำถามสุดท้าย
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Quiz Finished!'),
              content: Text('Your score is: $score/${questions.length}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // รีเซ็ตหน้าจอและคะแนนเมื่อกด "Restart"
                    Navigator.of(ctx).pop();
                    setState(() {
                      score = 0;
                      currentQuestionIndex = 0;
                    });
                  },
                  child: const Text('Restart'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestion.question,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ...currentQuestion.answers.map((answer) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: AnswerButton(
                      answer,
                      () => answerQuestion(answer), // ส่งคำตอบไปยังฟังก์ชัน
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
