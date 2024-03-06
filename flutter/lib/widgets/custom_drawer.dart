import 'package:e_learning/page/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:e_learning/page/profile.dart';
import 'package:e_learning/page/home.dart';
import 'package:e_learning/utils/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  SharedPreferences? prefs = SharedPreferencesManager.preferences;
  @override
  Widget build(BuildContext context) {
    Future<void> _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void logout() async {
      await prefs?.clear();

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Image.asset("assets/images/splash.png"),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowCaseWidget(
                      builder: Builder(
                    builder: (context) => const HomePage(
                      isFirstlogin: false,
                    ),
                  )),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text("Mail us"),
            onTap: () async {
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: 'subashvelusamy10@gmail.com',
                query: encodeQueryParameters(<String, String>{
                  'subject': '',
                  'body': 'Please post your queries here'
                }),
              );
              if (await canLaunchUrl(emailUri)) {
                launchUrl(emailUri);
              } else {
                throw Exception('Could not launch the email Uri');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.get_app),
            title: const Text("Get App"),
            onTap: () {
              _launchURL(
                  "https://install.appcenter.ms/orgs/citpl-internal-apps/apps/ck-survey-app/distribution_groups/ck%20survey%20app");
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: logout,
                        child: const Text("Logout"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.errorContainer,
                            foregroundColor:
                                Theme.of(context).colorScheme.onErrorContainer),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
