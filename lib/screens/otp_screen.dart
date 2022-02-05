import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ui_cash/screens/currency_requirement_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  void otpPost(String email, otp) async {
    var response = await http.post(Uri.parse("https://projects.aamoditsolutions.com/uicash/api/v1/register/otp-verify"),
        body: {
          'email': email,
          'otp': otp
        }
    );

    if(response.statusCode == 200) {
      var dataResponse = jsonDecode(response.body);
      print("Response: "+dataResponse.toString());
      if(dataResponse['status'].toString() == 'false') {
        Fluttertoast.showToast(msg: 'Inavlid otp');
        print('Invalid otp');
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CurrencyRequirementScreen()));
      }
    } else {
      Fluttertoast.showToast(msg: 'Error');
      print("Error code: "+response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffe5e5e5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                                keyboardType: TextInputType.number,
                                controller: otpController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: "Enter your otp",
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
                                  onPressed: () {
                                    otpPost(emailController.text,otpController.text);
                                  },
                                  child: const Text(
                                    "Verify OTP",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
