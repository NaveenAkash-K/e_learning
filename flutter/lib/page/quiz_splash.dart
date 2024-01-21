import 'package:e_learning/data/module_data.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class QuizSplash extends StatefulWidget {
  const QuizSplash({super.key});
  @override
  State<QuizSplash> createState() {
    return _QuizSplashState();
  }
}

class _QuizSplashState extends State<QuizSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 150),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_rounded),
              style:
                  IconButton.styleFrom(padding: const EdgeInsets.only(top: 40)),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
        const Text(
          'Final Quiz Module',
          style: TextStyle(
              color: Color.fromARGB(255, 192, 192, 192), fontSize: 16),
          textAlign: TextAlign.start,
        ),
        const Text(
          'Basics of Sales and Marketing',
          style: TextStyle(
              color: Color.fromARGB(255, 151, 151, 151), fontSize: 20),
          // textAlign: TextAlign.right,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width - 40,
          color: const Color.fromARGB(255, 200, 223, 196),
        ),
        const SizedBox(
          height: 32,
        ),
        const Text(
          'Instructions',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 24,
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1.',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 106, 106, 106),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              child: Text(
                'You can attempt this quiz a maximum of three times',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 106, 106, 106),
                ),
              ),
            ),
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2.',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 106, 106, 106),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              child: Text(
                'You need to score atleast 60% on this quiz to get the certification.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 106, 106, 106),
                ),
              ),
            ),
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3.',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 106, 106, 106),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              child: Text(
                'Each right answer carries a maximum of 10 points and reduces based on the number of attempts.Refer to the score grid below',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 106, 106, 106),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        const Text(
          'Score Grid',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(
          height: 28,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 245, 245, 247),
          ),
          child: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 245, 245, 247),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Attempts',
                        style:
                            TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Answered',
                        style: TextStyle(
                          color: Color.fromARGB(255, 66, 66, 66),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Multiplier',
                        style:
                            TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Final Points',
                        style:
                            TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 245, 245, 247),
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: const Row(
                  children: [
                    Expanded(
                        child: Text(
                      '1',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '10',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '10',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '100',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 245, 245, 247),
                child: const Row(
                  children: [
                    Expanded(
                        child: Text(
                      '2',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '10',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '8.5',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '85',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 245, 245, 247),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Text(
                      '3',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '10',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '7.5',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      '75',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              onPressed: () {
                // loadQuiz(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 139, 0, 232), width: 2)),
              ),
              child: const Text(
                'Take Quiz',
                style: TextStyle(color: Color.fromARGB(255, 139, 0, 232)),
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
