import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_cash/screens/currency_requirement_screen.dart';
import 'package:ui_cash/screens/register_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? emailString;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  GlobalKey<FormState> formKey = GlobalKey();


  void login(String email, password) async {

    Map data = {
      'email_mobile': email,
      'password': password
    };

    var response = await http.post(
        Uri.parse("https://projects.aamoditsolutions.com/uicash/api/v1/login"),
        body: data,
      headers: {
          'accept': 'application/json'
      }
    );
    if(response.statusCode == 200) {
      var dataResponse = jsonDecode(response.body);
      print("Message: "+dataResponse.toString());

      print('Access Token: '+dataResponse['access_token'].toString());

      SharedPreferences accessTokenPrefs = await SharedPreferences.getInstance();
      accessTokenPrefs.setString('accessToken', dataResponse['access_token'].toString());

      print('Name: '+dataResponse['user']['name'].toString());

      SharedPreferences namePrefs = await SharedPreferences.getInstance();
      namePrefs.setString('name', dataResponse['user']['name'].toString());

      print('Email: '+dataResponse['user']['email'].toString());
      print('Mobile: '+dataResponse['user']['mobile'].toString());

      if(dataResponse['status'].toString() == 'false') {
        Fluttertoast.showToast(msg: 'Login failed, invalid email and password');
        print("Login failed, invalid email and password");
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CurrencyRequirementScreen())).then((value) {
              Fluttertoast.showToast(msg: 'Login Successfully');
        });
      }
    } else {
      Fluttertoast.showToast(msg: 'Error while login');
      print("Error code: "+ response.statusCode.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffe5e5e5),
        ),
      ),
      body: Container(
        color: const Color(0xffe5e5e5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: Container(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: MediaQuery.of(context).size.width,
                    height: 590,
                    color: const Color(0xffeeeeee).withOpacity(0.9),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Image.asset(
                                      "images/uicash.png",
                                      width: 130,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.person,
                              size: 100,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "WELCOME BACK",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                        Form(
                          key: formKey,
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            //Email
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffffffff).withOpacity(0.9),
                              ),
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.white)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            //Password
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffffffff).withOpacity(0.9),
                              ),
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.white)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              color: Colors.transparent,
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff7e7e7e),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () async {
                                    login(emailController.text,passwordController.text);

                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    setState(() {
                                      emailString = emailController.text.toString();
                                    });
                                    prefs.setString('email', emailString!);
                                  },
                                  child: const Text(
                                    "Proceed",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account.",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterScreen()));
                                    },
                                    child: const Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                          color: Color(0xff5d5fef),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        const TextSpan(
                                            text:
                                                "By proceeding, you agree to our "),
                                        TextSpan(
                                            text: 'T&C ',
                                            style: const TextStyle(
                                              color: Color(0xff6f71ef),
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print('T&C');
                                              }),
                                        const TextSpan(text: "and "),
                                        TextSpan(
                                            text: 'Privacy Policy',
                                            style: const TextStyle(
                                              color: Color(0xff6f71ef),
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print('Privacy Policy');
                                              }),
                                      ]),
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
