import 'dart:convert';

import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../const/config.dart';
import '../../dashboard/bottom_bar.dart';

class ReportBugScreen extends StatefulWidget {
  const ReportBugScreen({super.key});

  @override
  State<ReportBugScreen> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ReportBugScreen> {

  TextEditingController _emailcontroller = TextEditingController();


  Future<String> updateAccount(Map<String, dynamic> data) async {
    try {
      final userId = await UID; // Replace with actual user ID logic
      var response = await http.post(
        Uri.parse(BASEURL + "bug_fix.php?u_id=$userId"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body.toString());

        if (jsondata[0]['message'] == "1") {
          Fluttertoast.showToast(msg: "Submit Successfully");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBar(), // Replace with your home screen
            ),
          );

          return "success";
        } else {
          Fluttertoast.showToast(msg: "Submit Successfully");

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Leave a Note",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: themeColor, fontWeight: FontWeight.bold, fontSize: 26),
            ),
            const Text(
              "Please let us know what is going on below",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),

            TextField(
              controller: _emailcontroller,
              maxLines: 5,
              cursorColor: themeColor,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: themeColor, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: themeColor, width: 2)),
                hintText: 'Leave Note here',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final userId = await UID;
                Map<String, dynamic> data = {

                  'u_id': userId.toString(),
                  'message': _emailcontroller.text,

                };
                String response = await updateAccount(data);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeColor,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: const Center(
                  child: Text(
                    'Leave Note',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
