import 'dart:convert';

import 'package:e_learning/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ScorePage extends StatelessWidget {
  ScorePage({
    required this.score,
    required this.totalQuestions,
    this.isFinal = false,
    super.key,
  });

  bool isFinal;
  final int score;
  final int totalQuestions;

  String getImage(double score) {
    if (score >= 80 && score <= 100) {
      return 'assets/images/score/excellent.webp';
    } else if (score >= 60 && score <= 70) {
      return 'assets/images/score/goodjob.webp';
    } else if (score >= 50 && score <= 40) {
      return 'assets/images/score/welldone.webp';
    } else if (score >= 30 && score <= 20) {
      return 'assets/images/score/average.webp';
    } else {
      return 'assets/images/score/needsimprovement.webp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 12, 80),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.center,
            child: Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100.0),
              color: Colors.white,
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.8, // Adjust the height as needed
                child: Stack(
                  children: [
                    // Background Image
                    Image.asset(
                      'assets/images/poppers.png', // Replace with your image path
                      height: MediaQuery.of(context).size.height *
                          0.3, // 20% of card height
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Content Overlay
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 80),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Top Text
                          const Text(
                            'Result',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Hurray Naveen! \n You have completed the module successfully',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                getImage(((score / totalQuestions) * 100)),
                                height: 100,
                                width: 100,
                              )),
                          // Congratulatory Text
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ' $score / $totalQuestions ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Text(
                            ' Points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          // Your Score Text
                          const SizedBox(height: 25),
                          // Thumbs Up Image
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 80),
              width: MediaQuery.of(context).size.width *
                  0.7, // Adjust the width as needed
              child: ElevatedButton(
                onPressed: isFinal
                    ? () async {
                        try {
                          var response = await http.get(Uri.parse(
                              "http://${dotenv.env["MY_IP"]}:3000/v1/api/certificate/Naveen Akash/SVCE/naveen.akash0904@gmail.com"));

                          var responseData = jsonDecode(response.body);

                          if (response.statusCode > 399) {
                            throw responseData["message"];
                          }

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(responseData["message"]),
                            ),
                          );
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => const HomePage(),
                          //   ),
                          // );
                        } catch (e) {
                          print(e);
                        }
                      }
                    : () {
                        // Handle the button press
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 68, 67, 67),
                  backgroundColor: const Color.fromARGB(255, 255, 105, 0),
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  isFinal ? "Generate Certificate" : 'Next Module',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
