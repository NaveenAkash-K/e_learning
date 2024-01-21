import 'package:flutter/material.dart';

class QuizOptions extends StatefulWidget {
  const QuizOptions({
    required this.selectedValue,
    required this.options,
    required this.selectedValueHandler,
    super.key,
  });

  final Function(int) selectedValueHandler;
  final int? selectedValue;
  final List<String> options;

  @override
  State<StatefulWidget> createState() => _QuizOptionsState();
}

class _QuizOptionsState extends State<QuizOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            widget.selectedValueHandler(0);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 221, 210),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 236, 185, 169),
                  offset: Offset(0, 5),
                  blurRadius: 1,
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 258,
                  child: Text(
                    widget.options[0],
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                const Spacer(),
                Radio(
                  value: 0,
                  groupValue: widget.selectedValue,
                  onChanged: ((value) {
                    if (value == null) {
                      return;
                    }
                    widget.selectedValueHandler(value);
                  }),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: (() {
            widget.selectedValueHandler(1);
          }),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 235, 221, 244),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 205, 182, 219),
                    offset: Offset(0, 5),
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 258,
                  child: Text(
                    widget.options[1],
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                const Spacer(),
                Radio(
                  value: 1,
                  groupValue: widget.selectedValue,
                  onChanged: ((value) {
                    if (value == null) {
                      return;
                    }
                    widget.selectedValueHandler(value);
                  }),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            widget.selectedValueHandler(2);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 217, 240, 192),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 176, 202, 148),
                    offset: Offset(0, 5),
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 258,
                  child: Text(
                    widget.options[2],
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                const Spacer(),
                Radio(
                  value: 2,
                  groupValue: widget.selectedValue,
                  onChanged: ((value) {
                    if (value == null) {
                      return;
                    }
                    widget.selectedValueHandler(value);
                  }),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            widget.selectedValueHandler(3);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 237, 246, 255),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 170, 195, 220),
                    offset: Offset(0, 5),
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 258,
                  child: Text(
                    widget.options[3],
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                const Spacer(),
                Radio(
                  value: 3,
                  groupValue: widget.selectedValue,
                  onChanged: ((value) {
                    if (value == null) {
                      return;
                    }
                    widget.selectedValueHandler(value);
                  }),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
