import 'package:e_learning/data/module_data.dart';
import 'package:e_learning/data/quiz_data.dart';
import 'package:e_learning/page/quiz.dart';
import 'package:e_learning/widgets/course_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({
    required this.moduleData,
    required this.heroTag,
    required this.appBarTitle,
    required this.title,
    super.key,
  });

  final List moduleData;
  final String heroTag;
  final String appBarTitle;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ModulePageState();
  }
}

class _ModulePageState extends State<ModulePage> {
  final headingStyle = GoogleFonts.merriweather().copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 48, 48, 48),
    // wordSpacing: 5,
  );

  final subHeadingStyle = GoogleFonts.merriweather().copyWith(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 48, 48, 48),
    // wordSpacing: 5,
  );

  final bodyStyle = GoogleFonts.merriweather().copyWith(
    fontSize: 14,
    // color: Color.fromARGB(255, 64, 64, 64),
    // fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 48, 48, 48),
    // wordSpacing: 3,
  );
  int index = 0;
  int sectionindex = 0;
  @override
  Widget build(BuildContext context) {
    return Hero(
      // tag: "courseTile${index+1}",
      tag: widget.heroTag,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            widget.appBarTitle,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 64, 64, 64),
                ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: LinearProgressIndicator(value: 0.5),
          ),
        ),
        bottomSheet: Container(
          color: Theme.of(context).colorScheme.background,
          height: 60,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  // Check if the section index is greater than 0 to avoid going below 0
                  if (sectionindex > 0) {
                    // Decrement the section index

                    --sectionindex;
                    print(sectionindex);

                    // Navigate to the previous section
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((BuildContext context) => ModulePage(
                            title: module[index]['title'],
                            appBarTitle: 'Module ${index + 2}',
                            moduleData: module[index]['content'][sectionindex],
                            heroTag: "courseTile$index",
                          )),
                    ));
                    print('Back button clicked');
                  }
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Spacer(),
              Text("1/2"),
              Spacer(),
              IconButton(
                onPressed: sectionindex < module[index]['content'].length
                    ? () {
                        // Update the section index

                        ++sectionindex;
                        print(sectionindex);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: ((BuildContext context) => ModulePage(
                                title: module[index]['title'],
                                appBarTitle: 'Module ${index + 2}',
                                moduleData: module[index]['content']
                                    [sectionindex],
                                heroTag: "courseTile$index",
                              )),
                        ));
                        print('clicked');
                      }
                    : null, // Set onPressed to null to disable the button
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 300) {
                print('Strong swipe right');
              } else if (details.primaryVelocity! < -300) {
                print('Strong swipe left');
              }
            },
            child: Column(
              children: widget.moduleData.map((e) {
                if (e is ImageContent) {
                  return e.build(context);
                } else if (e is Heading) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        30, e.topPadding, 30, e.bottomPadding),
                    child: Text(
                      widget.title,
                      style: headingStyle,
                    ),
                  );
                } else if (e is SubHeading) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        30, e.topPadding, 30, e.bottomPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.text,
                            style: subHeadingStyle,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (e is BulletPoint) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        30, e.topPadding, 30, e.bottomPadding),
                    child: Text(
                      '◉    ' + e.text,
                      // textAlign: TextAlign.start,
                      style: bodyStyle,
                      textAlign: TextAlign.justify,
                    ),
                  );
                } else if (e is Body) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        30, e.topPadding, 30, e.bottomPadding),
                    child: Text(
                      e.text,
                      style: bodyStyle,
                      textAlign: TextAlign.justify,
                    ),
                  );
                } else if (e is TabularColumn) {
                  return e.build(context);
                }
                return const SizedBox(height: 60);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
