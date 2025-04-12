import 'dart:convert';

import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/config.dart';

class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({
    super.key,
  });

  @override
  State<ContactDetailsScreen> createState() => _OtpSigninStateas();
}


class _OtpSigninStateas extends State<ContactDetailsScreen> {

  String email='';
  String call='';
  String insta='';
  String youtube='';
  String whatsapp='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData(){
    try{
      userProfileFetch();
    }catch(e){

    }
  }

  Future<void> launchEmail(String? email) async {
    if (email == null || email.isEmpty) {
      print('Invalid email address');
      return;
    }

    final Uri emailUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email client');
    }
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

          call=data[0]['call'];
          email=data[0]['email'];
          insta=data[0]['insta'];
          youtube=data[0]['youtube'];
          whatsapp=data[0]['whatsapp'];

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Contact Us",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildContactOption(
              context,
              title: "Mail to CollegeFriend",
              onTap: () {
                final phoneNumber = email.toString();
                if (phoneNumber != null && phoneNumber.isNotEmpty) {
                  launchUrlString("mailto:$phoneNumber");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("Phone number not available.")),
                  );
                }
                // launchEmail(email);
              },
            ),
            const SizedBox(height: 10),
            _buildContactOption(
              context,
              title: "Call Us",
              onTap: () {
                final phoneNumber = call.toString();
                if (phoneNumber != null && phoneNumber.isNotEmpty) {
                  launchUrlString("tel:$phoneNumber");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("Phone number not available.")),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            _buildContactOption(
              context,
              title: "Follow on Instagram",
              onTap: () {
                launchUrlString("$insta");
              },
            ),
            const SizedBox(height: 10),
            _buildContactOption(
              context,
              title: "Youtube Link",
              onTap: () {
                launchUrlString("$youtube");
              },
            ),  const SizedBox(height: 10),
            _buildContactOption(
              context,
              title: "WhatsApp",
              onTap: () {
                final phoneNumber = whatsapp.toString();
                if (phoneNumber != null && phoneNumber.isNotEmpty) {
                  // Ensure number format is correct for WA link (e.g., no +)
                  launchUrlString(
                      "https://wa.me/91$phoneNumber"); // Assuming +91 country code
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("WhatsApp number not available.")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
