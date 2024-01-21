import 'package:e_learning/model/quiz_data.dart';
import 'package:e_learning/widgets/quiz_options.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/model/quiz_state.dart';
import 'package:e_learning/page/score.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    required this.quizDataList,
    super.key,
  });

  final List<QuizData> quizDataList;

  @override
  State<StatefulWidget> createState() {
    return _QuizPageState();
  }
}

class _QuizPageState extends State<QuizPage> {
  // ignore: avoid_init_to_null
  var _selectedQuizValue = null;
  var _quizIndex = 0;

  List<QuizState> quizState = [];

  int score = 0;
  void selectedValueHandler(int value) {
    setState(() {
      _selectedQuizValue = value;
    });
  }

  void quizIndexHandler(value) {
    if (value == 1) {
      if (_selectedQuizValue == null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select an answer"),
          ),
        );
        return;
      }

      for (var element in quizState) {
        if (_quizIndex == element.questionIndex) {
          if (widget.quizDataList[_quizIndex].options
                  .indexOf(element.selectedAnswer) !=
              _selectedQuizValue) {
            setState(() {
              element.selectedAnswer =
                  widget.quizDataList[_quizIndex].options[_selectedQuizValue];
            });
          }
        }
      }

      if (_quizIndex == widget.quizDataList.length - 1) {
        quizState.add(
          QuizState(
            correctAnswer: widget.quizDataList[_quizIndex].answer,
            questionIndex: _quizIndex,
            selectedAnswer:
                widget.quizDataList[_quizIndex].options[_selectedQuizValue],
          ),
        );

        for (var element in quizState) {
          if (element.selectedAnswer ==
              widget.quizDataList[element.questionIndex].answer) {
            ++score;
          }
        }
        print("$score/${widget.quizDataList.length}");
        // print("QuizState after all questions:");
        // for (var element in quizState) {
        //   print(
        //       "QuestionIndex: ${element.questionIndex}, CorrectAnswer: ${element.correctAnswer}, SelectedAnswer: ${element.selectedAnswer}");
        // }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScorePage(
                score: score, totalQuestions: widget.quizDataList.length),
          ),
        );
        return;
      }

      for (var element in quizState) {
        if (_quizIndex + 1 == element.questionIndex) {
          setState(() {
            _selectedQuizValue = widget.quizDataList[_quizIndex + 1].options
                .indexOf(element.selectedAnswer);
            _quizIndex++;
          });
          return;
        }
      }

      quizState.add(
        QuizState(
          correctAnswer: widget.quizDataList[_quizIndex].answer,
          questionIndex: _quizIndex,
          selectedAnswer:
              widget.quizDataList[_quizIndex].options[_selectedQuizValue],
        ),
      );
      setState(() {
        _selectedQuizValue = null;
        _quizIndex++;
      });
    } else if (value == -1) {
      for (var element in quizState) {
        if (_quizIndex == element.questionIndex) {
          if (widget.quizDataList[_quizIndex].options
                  .indexOf(element.selectedAnswer) !=
              _selectedQuizValue) {
            setState(() {
              element.selectedAnswer =
                  widget.quizDataList[_quizIndex].options[_selectedQuizValue];
            });
          }
        }
      }

      if (_quizIndex == 0) {
        // Navigator.pop(context);
      }

      for (var element in quizState) {
        if (_quizIndex - 1 == element.questionIndex) {
          setState(() {
            _selectedQuizValue = widget.quizDataList[_quizIndex - 1].options
                .indexOf(element.selectedAnswer);
            --_quizIndex;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 156, 27, 255),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 20),
                  InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Ink(
                      width: 45,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${_quizIndex + 1} of ${widget.quizDataList.length}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 65)
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width - 150,
                height: 5,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: LinearProgressIndicator(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(108, 187, 148, 255),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    value: (_quizIndex + 1) / widget.quizDataList.length,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 200,
                margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 196, 118, 255),
                      blurRadius: 1,
                      offset: Offset(5, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select right answer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 106, 106, 106),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 440,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              widget.quizDataList[_quizIndex].question,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            QuizOptions(
                              selectedValue: _selectedQuizValue,
                              options: widget.quizDataList[_quizIndex].options,
                              selectedValueHandler: selectedValueHandler,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            quizIndexHandler(-1);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Text(
                              "Back",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            quizIndexHandler(1);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 118, 32),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 230, 88, 0),
                                  offset: Offset(0, 5),
                                )
                              ],
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Text(
                              _quizIndex == widget.quizDataList.length - 1
                                  ? "Complete"
                                  : "Next",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
