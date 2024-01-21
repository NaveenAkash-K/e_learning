import 'dart:convert';

import 'package:e_learning/page/home.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/utils/validators.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _authFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  bool _isSignup = true;
  late SharedPreferences prefs;

  void login() async {
    prefs = await SharedPreferences.getInstance();

    if (!_authFormKey.currentState!.validate()) {
      return;
    }

    try {
      var response = await http.post(
        Uri.parse("http://${dotenv.env["MY_IP"]}:3000/v1/api/user/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "email": _emailController.text,
            "password": _passwordController.text,
          },
        ),
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode > 399) {
        throw responseData["message"];
      }

      await prefs.setString("token", responseData["token"]);

      if (!mounted) {
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

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

  void signup() async {
    if (!_authFormKey.currentState!.validate()) {
      return;
    }

    try {
      var response = await http.post(
        Uri.parse("http://${dotenv.env["MY_IP"]}:3000/v1/api/user/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "email": _emailController.text,
            "password": _passwordController.text,
            "phno": _phoneNumberController.text,
            "college": _collegeController.text,
            "branch": _branchController.text
          },
        ),
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode > 399) {
        throw responseData["message"];
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Regsitration Successful. Please Login"),
          ),
        );
        _isSignup = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isSignup ? "Create an \naccount!" : "Welcome\nBack!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _authFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          validator: (email) {
                            if (email == null) {
                              return "The email should not be empty";
                            }
                            if (!isEmail(email.trim())) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Visibility(
                          visible: _isSignup,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Phone Number",
                                  prefixIcon: const Icon(Icons.phone),
                                ),
                                validator: (number) {
                                  if (number == null) {
                                    return "The Phone number should not be empty";
                                  }
                                  if (!isPhoneNumber(number.trim())) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                          ),
                          validator: (password) {
                            if (password == null) {
                              return "The password should not be empty";
                            }
                            if (!isPassword(password.trim())) {
                              return "The password must have at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Visibility(
                          visible: _isSignup,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Confirm Password",
                                  prefixIcon: const Icon(Icons.lock_outline),
                                ),
                                validator: (password) {
                                  if (password == null) {
                                    return "The password should not be empty";
                                  }
                                  if (!isPassword(password.trim())) {
                                    return "The password must have at least 6 characters";
                                  }
                                  if (_passwordController.text != password) {
                                    return "The passwords do not match";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                controller: _collegeController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "College",
                                  prefixIcon: const Icon(Icons.school_outlined),
                                ),
                                validator: (college) {
                                  if (college == null ||
                                      college.trim().isEmpty) {
                                    return "Please enter your college name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                controller: _branchController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Branch",
                                  prefixIcon: const Icon(Icons.book_outlined),
                                ),
                                validator: (branch) {
                                  if (branch == null || branch.trim().isEmpty) {
                                    return "Please enter your branch";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: _isSignup ? signup : login,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(58, 142, 66, 255),
                            ),
                            width: MediaQuery.of(context).size.width - 225,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: Center(
                              child: Text(
                                _isSignup ? "Signup" : "Login",
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isSignup = !_isSignup;
                            });
                          },
                          child: Text(
                            _isSignup
                                ? "Already a User?   Login!"
                                : "New to E Learning?   Signup!",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text('Home'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
