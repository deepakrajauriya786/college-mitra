import 'dart:convert';
import 'dart:developer';
import 'package:college_dost/const/color.dart';
import 'package:college_dost/screens/setting/screens/report_bug_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../const/config.dart';
import '../../const/database.dart';
import '../../const/navigator.dart';
import '../onboard/onboard_screen.dart';
import '../setting/screens/contact_details_screen.dart';
import '../setting/screens/edit_profile_page.dart';
import '../setting/screens/setting_changes_screen.dart';
import '../splash.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _OtpSigninStateas();
}


class _OtpSigninStateas extends State<ProfileScreen> {


  String name='';
  String email='';
  String logo='';

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
      await http.get(Uri.parse("${BASEURL}vendor_Profile_fetch.php?u_id=$userId"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        if (data[0]['message'] == '1') {


          setState(() {
            name=data[0]['name'];
            email=data[0]['email'];
            logo=data[0]['shop_logo'];
          });
          return data;
        } else {
          return [];
        }
      } else {
        throw Exception("Server Error!");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Profile",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.black,
            child: Row(
              children: [

                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[200],
                  child: logo.isNotEmpty?Image.network(ImageURL+logo,fit: BoxFit.fill, height: 50,
                    width: 50,) : Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: themeColor),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "$email",
                      style: TextStyle(fontSize: 14, color: themeColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.black,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ));
              },
              child: const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(Icons.settings, "Settings", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingChangesScreen(),
                      ));
                }),
                _buildMenuItem(Icons.contact_page, "Contact Details", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDetailsScreen(),
                      ));
                }),
                _buildMenuItem(Icons.bug_report, "Bug Report", () {
                  log("hih");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportBugScreen(),
                      ));
                }),
                // _buildMenuItem(Icons.info, "AI Assistant", () {}),
                _buildMenuItem(Icons.logout, "Logout", () {
                  showLogoutDialog(context);
                }, isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showLogoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {


                SharedPreferences prefs = await SharedPreferences.getInstance();

                savebool(IS_LOGIN, false);
                savebool(IS_SECOND_TIME, false);
                await prefs.remove(USER_NAME);
                await prefs.remove(USER_NUMBER);
                final success = await prefs.remove('u_id');

                print(success);
                if (success) {
                  removePreviousRoutes(context, Splash(),
                      direction: SlideDirection.right);

                }
                // Navigator.of(context).pop();

              },
              child: const Text(
                "Yes",
                style: TextStyle(color: themeColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback callback,
      {bool isLogout = false}) {
    return ListTile(
      focusColor: Colors.black,
      leading: CircleAvatar(
        backgroundColor: Colors.blue[50],
        child: Icon(icon, color: isLogout ? Colors.red : themeColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isLogout ? Colors.red : Colors.white,
          fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing:
          isLogout ? null : const Icon(Icons.settings, color: Colors.white),
      onTap: callback,
    );
  }
}
