import 'package:college_dost/screens/dashboard/widgets/notification_tile.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';

class NotificationScreen extends StatelessWidget {
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
