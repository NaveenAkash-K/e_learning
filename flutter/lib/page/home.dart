import 'dart:convert';

import 'package:e_learning/data/quiz_data.dart';
import 'package:e_learning/page/intro.dart';
import 'package:e_learning/page/module.dart';
import 'package:e_learning/page/quiz_splash.dart';
import 'package:e_learning/utils/shared_preferences_manager.dart';
import 'package:e_learning/widgets/image_progress.dart';
import 'package:e_learning/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/data/module_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.isFirstlogin});
  final bool isFirstlogin;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? prefs = SharedPreferencesManager.preferences;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();
  final GlobalKey _five = GlobalKey();
  final GlobalKey _six = GlobalKey();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> listOfPrefKeys = [
    "isIntroFinished",
    "isModuleFinished",
    "isInstructionFinished",
    "isImageUploadFinished",
    "isCaseStudyFinished",
  ];

  final List<Color> mainColors = [
    const Color.fromARGB(255, 147, 232, 146),
    const Color.fromARGB(255, 255, 182, 199),
    const Color.fromARGB(255, 255, 242, 146),
    const Color.fromARGB(255, 193, 193, 255),
    const Color.fromARGB(255, 201, 248, 254),
    const Color.fromARGB(255, 255, 237, 237),
    const Color.fromARGB(255, 254, 241, 222),
    const Color.fromARGB(255, 186, 239, 229),
  ];

  final List<Color> boxColors = [
    const Color.fromARGB(255, 139, 216, 137),
    const Color.fromARGB(255, 255, 167, 188),
    const Color.fromARGB(255, 254, 238, 97),
    const Color.fromARGB(255, 178, 175, 254),
    const Color.fromARGB(255, 164, 241, 251),
    const Color.fromARGB(255, 255, 211, 212),
    const Color.fromARGB(255, 255, 225, 184),
    const Color.fromARGB(255, 109, 214, 198),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.isFirstlogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context)
            .startShowCase([_one, _two, _three, _four, _five, _six]);
      });
    }
  }

  late double nop;
  late bool isCaseStudyOpen;

  @override
  Widget build(BuildContext context) {
    final String? username = prefs?.getString("username");

    setState(() {
      nop = prefs!.getInt("nop")!.toDouble();
      isCaseStudyOpen = nop >= 40;
    });

    int progress = 0;
    int credits = 0;

    void introTap() async {
      if ((prefs!.getBool("isIntroFinished")!)) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IntroPage(),
          ),
        );
        return;
      }

      try {
        http.post(
          Uri.parse("${dotenv.env["BACKEND_API_BASE_URL"]}/module/complete"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
            {
              "email": prefs!.getString("email"),
              "module": 0,
            },
          ),
        );

        if (!(prefs!.getBool("isIntroFinished")!)) {
          await prefs!.setBool("isIntroFinished", true);

          setState(() {
            ++progress;
            credits += 200;
          });
        }

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IntroPage(),
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.toString(),
            ),
          ),
        );
      }
    }

    void contentTap() async {
      void progressIncrementer() {
        setState(() {
          progress++;
          credits += 200;
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => ModulePage(
              moduleData: module[0],
              appBarTitle: "Learning Module",
              title: "Hello",
              // isFinal: false,
              // quizData: quizDataList1,
              progressHandler: progressIncrementer,
              moduleIndex: 1)),
        ),
      );
    }

    void instructionTap() async {
      print(prefs!.getBool("isInstructionFinished")!);
      if ((prefs!.getBool("isInstructionFinished")!)) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ModulePage(
                moduleData: instruction,
                appBarTitle: "Instructions for Live Project",
                title: "Hello",
                isInstruction: true,
                // isFinal: false,
                // quizData: quizDataList1,
                moduleIndex: 1),
          ),
        );
        return;
      }

      try {
        http.post(
          Uri.parse("${dotenv.env["BACKEND_API_BASE_URL"]}/module/complete"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
            {
              "email": prefs!.getString("email"),
              "module": 2,
            },
          ),
        );

        await prefs!.setBool("isInstructionFinished", true);

        setState(() {
          ++progress;
          credits += 200;
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ModulePage(
                moduleData: instruction,
                appBarTitle: "Instructions for Live Project",
                title: "Hello",
                isInstruction: true,
                // isFinal: false,
                // quizData: quizDataList1,
                moduleIndex: 1),
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.toString(),
            ),
          ),
        );
      }
    }

    void caseStudyTap() async {
      if (!(prefs!.getBool("isCaseStudyFinished")!)) {
        await prefs!.setBool("isCaseStudyFinished", true);

        setState(() {
          ++progress;
          credits += 200;
        });

        try {
          http.post(
            Uri.parse("${dotenv.env["BACKEND_API_BASE_URL"]}/module/complete"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(
              {
                "email": prefs!.getString("email"),
                "module": 4,
              },
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => ModulePage(
                  moduleData: caseStudy,
                  appBarTitle: "Test Your Knowledge",
                  title: "Hello",
                  // isFinal: false,
                  // quizData: quizDataList1,
                  moduleIndex: 1)),
            ),
          );
          return;
        } catch (error) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.toString(),
              ),
            ),
          );
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => ModulePage(
              moduleData: caseStudy,
              appBarTitle: "Test Your Knowledge",
              title: "Hello",
              // isFinal: false,
              // quizData: quizDataList1,
              moduleIndex: 1)),
        ),
      );
    }

    for (var element in listOfPrefKeys) {
      if (prefs!.getBool(element)!) {
        progress++;
        credits += 200;
      }
    }

    print(progress);

    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        leading: Showcase(
          title: 'Drawer',
          description: 'Navigate across screens over here',
          key: _one,
          child: IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu)),
        ),
        backgroundColor: const Color.fromARGB(255, 153, 0, 255),
        foregroundColor: Colors.white,
        title: Text(
          "Hi $username!",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        actions: [
          Showcase(
            title: 'Credits',
            description: 'Complete quizzes and modules to gain credits',
            key: _three,
            child: Container(
              margin: const EdgeInsets.only(top: 0, right: 15),
              padding: const EdgeInsets.fromLTRB(15, 8, 5, 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    credits.toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    'assets/images/appbar_icon.png',
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Your Progress',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 5,
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                child: Showcase(
                  title: "Progress",
                  description: "Keep track of your progress here",
                  key: _two,
                  child: ClipRRect(
                    child: LinearProgressIndicator(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          // Theme.of(context).colorScheme.onPrimaryContainer,
                          Color.fromARGB(210, 45, 208, 17)),
                      value: progress / 5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: introTap,
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: mainColors[0],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 50, 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                          ),
                          color: boxColors[0],
                        ),
                        child: Text(
                          "01",
                          style: GoogleFonts.playfairDisplay().copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 37, 37, 37),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          color: Colors.white,
                        ),
                        child: Text(
                          "Introduction",
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: contentTap,
                      child: Showcase(
                        title: 'Learning Module',
                        description: 'Learn about Shelf Analytics here',
                        key: _four,
                        child: Hero(
                          tag: "heroTag",
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: mainColors[1],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 50, 5),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    ),
                                    color: boxColors[1],
                                  ),
                                  child: Text(
                                    "02",
                                    style:
                                        GoogleFonts.playfairDisplay().copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 37, 37, 37),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    "Learning Module",
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: instructionTap,
                      // onTap: () {
                      //   ScaffoldMessenger.of(context).clearSnackBars();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text("Module not accessible yet"),
                      //     ),
                      //   );
                      // },
                      child: Showcase(
                        title: 'Instructions for Live Project ',
                        description:
                            'Learn how to upload images in the other app',
                        key: _five,
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 5,
                              ),
                            ],
                            color: mainColors[2],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 50, 5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                  ),
                                  color: boxColors[2],
                                ),
                                child: Text(
                                  "03",
                                  style: GoogleFonts.playfairDisplay().copyWith(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 37, 37, 37),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 60,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "Instructions for Live Project ",
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Showcase(
                child: ImageProgress(
                  total: 100,
                  completed: nop,
                ),
                title: 'Upload Progress',
                description: 'Keep Track of your image upload progress here',
                key: _six,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: isCaseStudyOpen
                          ? caseStudyTap
                          : () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Module not accessible yet"),
                                ),
                              );
                            },
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 5,
                            ),
                          ],
                          color: mainColors[4],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 50, 5),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                ),
                                color: boxColors[4],
                              ),
                              child: Text(
                                "05",
                                style: GoogleFonts.playfairDisplay().copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 37, 37, 37),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 60,
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Colors.white,
                              ),
                              child: Text(
                                "Test your Knowledge",
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
