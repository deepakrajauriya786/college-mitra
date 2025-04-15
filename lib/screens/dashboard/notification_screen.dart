import 'dart:convert';

import 'package:college_dost/screens/dashboard/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../const/color.dart';
import '../../const/config.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<NotificationScreen> {

  String telegram="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileFetch();
  }
  Future<List<dynamic>> userProfileFetch() async {
    try {
      final userId = await UID; // Replace with actual user ID logic
      final response =
      await http.get(Uri.parse("${BASEURL}contact_detail.php?u_id=$userId"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {

          telegram=data[0]['telegram'];

        });
        return jsonDecode(response.body);

      } else {
        throw Exception("Server Error!");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<void> openTelegramChannel() async {
    final url = Uri.parse(telegram);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch Telegram channel';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 3,
              width: 140,
              decoration: BoxDecoration(
                  color: themeColor, borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return NotificationTile();
                  }),
            ),
            // Icon(
            //   Icons.notifications_off,
            //   size: 80,
            //   color: Colors.white,
            // ),
            // SizedBox(height: 10),
            // Text(
            //   "Looks Clean...",
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
            // SizedBox(height: 5),
            // Text(
            //   "No New Notifications.",
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.white70,
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openTelegramChannel();
          // Handle Telegram button press
        },
        backgroundColor: themeColor,
        child: Icon(Icons.send, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
