import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/color.dart';
import '../../const/config.dart';
import '../../const/custom_text_field.dart';
import '../../const/database.dart';
import '../../const/navigator.dart';
import '../dashboard/bottom_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<LoginScreen> {
  bool isLoading = false; // Track loading state

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<String> login(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(BASEURL + "login_password.php"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body.toString());
        print(jsondata);
        if (jsondata[0]['message'] == "1") {
          savestring(USER_NAME, jsondata[0]['name'].toString());
          savestring(USER_EMAIL, jsondata[0]['email'].toString());
          addStringToPref(
              jsondata[0]['u_id'].toString(), jsondata[0]['mobile'].toString());



          return "success";
        } else if (jsondata[0]['message'] == "2") {
          // addStringToPref(
          //     jsondata[0]['u_id'].toString(), data['mobile'].toString());

          return "already";
        } else {
          return "Failed";
        }
      } else {
        print(response.body);
        // server error
        print("Failed !");
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      print("Failed !");
      return "err";
    }
  }

  Future<void> addStringToPref(String u_id, String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('u_id', u_id);
    prefs.setString('mobile', mobile);
    String mobileq = await getstring('mobile');
    print("mobileq $mobile");
    // user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              Image.asset(
                'assets/images/cap.png',
                fit: BoxFit.fill,
                height: 100,
              ),

              const Text(
                'Enter your details to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 30),

              CustomTextField(
                controller: email,
                hintText: 'E-Mail',
                input: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              const SizedBox(height: 20),

              CustomTextField(
                controller: password,
                hintText: 'Password',
                icon: Icons.fingerprint,
                obscureText: true,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // Combine the entered digits

                  setState(() {
                    isLoading = true;
                  });

                  Map<String, dynamic> data = {
                    'email': email.text,
                    'password': password.text,
                  };

                  String response = await login(data);

                  setState(() {
                    isLoading = false;
                  });
                  if (response == "success") {
                    savebool(IS_LOGIN, true);
                    // savestring(USER_NAME, _namecontroller.text);
                    // savestring(USER_NUMBER, mobile.text);

                    removePreviousRoutes(context, BottomBar(),
                        direction: SlideDirection.right);

                    Fluttertoast.showToast(msg: "Login Successfully");
                  } else if (response == "already") {
                    Fluttertoast.showToast(msg: "Wrong Login Details !");

                    removePreviousRoutes(context, LoginScreen(),
                        direction: SlideDirection.right);
                  } else {
                    Fluttertoast.showToast(msg: "Wrong Login Details !");

                    // Fluttertoast.showToast(msg: "Failed ! Please try again");
                    //
                    // removePreviousRoutes(context, LoginScreen(),
                    // direction: SlideDirection.right);
                  }

                  // Handle OTP verification
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Don't Have an account?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "  Signup",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
                    style: TextStyle(
                        color: themeColor, fontWeight: FontWeight.bold))
              ]))
              // const Text(
              //   'OR',
              //   style: TextStyle(color: Colors.grey),
              // ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
