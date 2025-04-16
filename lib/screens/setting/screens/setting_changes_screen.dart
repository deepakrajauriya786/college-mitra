import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';

class SettingChangesScreen extends StatefulWidget {
  const SettingChangesScreen({super.key});

  @override
  State<SettingChangesScreen> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingChangesScreen> {
  bool pushNotifications = true;
  // bool emailNotifications = true;
  // bool locationServices = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Settings Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SwitchListTile(
              value: pushNotifications,
              onChanged: (value) {
                setState(() {
                  pushNotifications = value;
                });
              },
              title: const Text(
                "Push Notifications",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                "Receive Push notifications from our application on a semi regular basis.",
                style: TextStyle(color: Colors.white70),
              ),
              activeColor: themeColor,
            ),
            // const SizedBox(height: 10),
            // SwitchListTile(
            //   value: emailNotifications,
            //   onChanged: (value) {
            //     setState(() {
            //       emailNotifications = value;
            //     });
            //   },
            //   title: const Text(
            //     "Email Notifications",
            //     style:
            //         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            //   subtitle: const Text(
            //     "Receive email notifications from our marketing team about new features.",
            //     style: TextStyle(color: Colors.white70),
            //   ),
            //   activeColor: themeColor,
            // ),
            // const SizedBox(height: 10),
            // SwitchListTile(
            //   value: locationServices,
            //   onChanged: (value) {
            //     setState(() {
            //       locationServices = value;
            //     });
            //   },
            //   title: const Text(
            //     "Location Services",
            //     style:
            //         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            //   subtitle: const Text(
            //     "Allow us to track your location, this helps keep track of spending and keeps you safe.",
            //     style: TextStyle(color: Colors.white70),
            //   ),
            //   activeColor: themeColor,
            // ),
            const Spacer(),
            // GestureDetector(
            //   onTap: () {
            //     // Handle Save Changes action
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       color: themeColor,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: const Center(
            //       child: Text(
            //         "Save Changes",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
