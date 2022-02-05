import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_cash/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ui_cash/screens/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  void register(String name, email, mobile, password, confirmPassword) async {


   var response = await http.post(Uri.parse("https://projects.aamoditsolutions.com/uicash/api/v1/register"),
    body: {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'confirm_password': confirmPassword,
    },
     headers: {
     'accept': 'application/json'
     }
    );

   if(response.statusCode == 200) {
     var responseData = jsonDecode(response.body);
     print(responseData.toString());
     if(responseData['status'].toString() == 'false') {
       Fluttertoast.showToast(msg: 'Registration failed');
       print('Registration failed');
     } else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OtpScreen())).then((value){
         Fluttertoast.showToast(msg: 'Registration Successfully');
       });
     }
   } else {
     Fluttertoast.showToast(msg: 'Error while registration');
     print("Error code: "+response.statusCode.toString());
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.grey),
          elevation: 0,
          backgroundColor: const Color(0xffe5e5e5),
        ),
      ),
      body: Container(
        color: const Color(0xffe5e5e5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                height: 680,
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
                      "WELCOME ONBOARD",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Let's get started",
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
                              height: 20,
                            ),
                            //Name
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffffffff).withOpacity(0.9),
                              ),
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                                keyboardType: TextInputType.name,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: "Enter your name",
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
                              height: 20,
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
                                controller: emailController,
                                validator: (value) => value!.isEmpty ? "Please enter your emial address": null,
                                keyboardType: TextInputType.emailAddress,
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
                              height: 20,
                            ),
                            //Mobile Number
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffffffff).withOpacity(0.9),
                              ),
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: mobileController,
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: "Enter your mobile number",
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
                              height: 20,
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
                                controller: passwordController,
                                validator: (value) => value!.isEmpty ? "Please enter password" : null,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
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
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffffffff).withOpacity(0.9),
                              ),
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                validator: (value) => value!.isEmpty ? "Please enter confirm password" : null,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
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
                            const SizedBox(height: 20,),
                            //Proceed Button
                            Container(
                              color: Colors.transparent,
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff7e7e7e),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {
                                    register(nameController.text,
                                        emailController.text,
                                       mobileController.text,
                                        passwordController.text,
                                        confirmPasswordController.text);
                                  },
                                  child: const Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have account.",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                                              (route) => false);
                                    },
                                    child: const Text(
                                      "SIGN IN",
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
                                const SizedBox(width: 20,),
                                RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        const TextSpan(text: "By proceeding, you agree to our "),
                                        TextSpan(
                                            text: 'T&C ',
                                            style: const TextStyle(color: Color(0xff6f71ef),),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print('T&C');
                                              }
                                        ),
                                        const TextSpan(text: "and "),
                                        TextSpan(
                                            text: 'Privacy Policy',
                                            style: const TextStyle(color: Color(0xff6f71ef),),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print('Privacy Policy');
                                              }
                                        ),
                                      ]
                                  ),
                                )
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
