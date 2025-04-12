import 'dart:convert';

import 'package:college_dost/const/navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/color.dart';
import '../../const/config.dart';
import '../../const/custom_text_field.dart';
import '../../const/database.dart';
import '../dashboard/bottom_bar.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<SignupScreen> {

  bool isLoading = false; // Track loading state
  TextEditingController mobile = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<String> loginAccount(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(BASEURL + "registration.php"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        print("data ${data['mobile']}");
        var jsondata = jsonDecode(response.body.toString());
        print(jsondata);

        if (jsondata[0]['message'] == "1") {
          addStringToPref(
              jsondata[0]['u_id'].toString(), data['mobile'].toString());

          return "success";
        } else if (jsondata[0]['message'] == "2") {
          // addStringToPref(
          //     jsondata[0]['u_id'].toString(), data['mobile'].toString());

          return "already";
        } else {
          return "Failed";
        }
        return "Failed";
      } else {
        // server error
        print("Server Error !");
        return Future.error("Server Error !");
      }
    } catch (SocketException) {
      // fetching error
      print("Error Fetching Data !");
      return Future.error("Error Fetching Data !");
    }
  }

  Future<void> addStringToPref(String u_id, String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('u_id', u_id);
    prefs.setString('mobile', mobile);
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
              const SizedBox(height: 100), // Space for the top margin
              // Image Icon (replace with your actual image asset)
              Image.asset(
                'assets/images/cap.png',
                fit: BoxFit.fill, // Ensure to add your asset in pubspec.yaml
                height: 100,
              ),

              const Text(
                'Create your profile to start your Journey.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 30),
              // Input Fields
              CustomTextField(
                controller: name,
                hintText: 'Full Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: email,
                hintText: 'E-Mail',
                input: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: mobile,
                hintText: 'Phone No',
                maxLength: 10,
                input: TextInputType.number,
                icon: Icons.phone,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: password,
                hintText: 'Password',
                icon: Icons.fingerprint,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              // Signup Button
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
                    'mobile': mobile.text,
                    'name': name.text,
                    'email': email.text,
                    'password': password.text,
                  };

                  String response = await loginAccount(data);

                  setState(() {
                    isLoading = false;
                  });
                  if (response == "success") {
                    savebool(IS_LOGIN, true);
                    // savestring(USER_NAME, _namecontroller.text);
                    savestring(USER_NUMBER, mobile.text);
                    savestring(USER_EMAIL, email.text);

                    removePreviousRoutes(context, BottomBar(),
                        direction: SlideDirection.right);

                    Fluttertoast.showToast(msg: "Account Created Successfully");
                  } else if (response == "already")  {
                    Fluttertoast.showToast(msg: "Email Id Already Registered !");

                    removePreviousRoutes(context, LoginScreen(),
                        direction: SlideDirection.right);
                  }
                  else {
                    Fluttertoast.showToast(msg: "Failed ! Please try again");
                  //
                  // removePreviousRoutes(context, LoginScreen(),
                  // direction: SlideDirection.right);
                  }

                  // Handle OTP verification
                },
                child: const Text(
                  'SIGNUP',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Already Have an account?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "  Login",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        changeScreen(context, LoginScreen());
                      },
                    style: TextStyle(
                        color: themeColor, fontWeight: FontWeight.bold))
              ]))
              // const Text(
              //   'OR',
              //   style: TextStyle(color: Colors.grey),
              // ),
              // const SizedBox(height: 20),
              // Add other options (like Google/Facebook login) below if needed
            ],
          ),
        ),
      ),
    );
  }
}
