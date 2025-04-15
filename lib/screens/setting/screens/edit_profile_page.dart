import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../const/config.dart';
import '../../../const/database.dart';
import '../../dashboard/bottom_bar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _mobilecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  File? _profileImage;
  String logo='';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _uploadImage();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileFetch();
  }

  Future<void> _uploadImage() async {

    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select images")),
      );
      return;
    }

    // setState(() {
    //   isLoading = true;
    // });

    final userId = await UID;

    final uri = Uri.parse(BASEURL + "upload_logo.php");
    var request = http.MultipartRequest('POST', uri);

    // Add the image file
    request.files.add(await http.MultipartFile.fromPath('img', _profileImage!.path));

    // Add the video file
    // request.files.add(await http.MultipartFile.fromPath('video', _video!.path)); // New video field

    // Add the user ID
    request.fields['u_id'] = userId.toString();


    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print("Response: $responseBody");

        var jsondata = jsonDecode(responseBody.toString());
        if (jsondata[0]['message'] == "1") {
          userProfileFetch();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile Image Uploaded")),
          );
          // Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBar(), // Replace with your home screen
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed !")),
          );
        }

        // Get.back();
      } else {
        print("Upload failed with status: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred")),
      );
    }

    // setState(() {
    //   isLoading = false;
    // });

  }


  Future<String> updateAccount(Map<String, dynamic> data) async {
    try {
      final userId = await UID; // Replace with actual user ID logic
      var response = await http.post(
        Uri.parse(BASEURL + "user_profile_update.php?u_id=$userId"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body.toString());

        if (jsondata[0]['message'] == "1") {
          // Fluttertoast.showToast(msg: "Update Successfully");
          Navigator.of(context).pop();
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BottomContainer(), // Replace with your home screen
          //   ),
          // );

          return "success";
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
            _namecontroller.text=data[0]['name'];
            _emailcontroller.text=data[0]['email'];
            logo=data[0]['shop_logo'];
            _mobilecontroller.text=data[0]['mobile'];
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
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(

                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: logo.isNotEmpty?Image.network(ImageURL+logo,fit: BoxFit.fill,  height: 100,
                    width: 100,) : Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundColor: Colors.grey[800],
                //   backgroundImage:
                //       _profileImage != null ? FileImage(_profileImage!) : null,
                //   child: _profileImage == null
                //       ? const Icon(
                //           Icons.person,
                //           size: 50,
                //           color: Colors.white,
                //         )
                //       : null,
                // ),
                GestureDetector(
                  onTap: _pickImage,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: themeColor,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _namecontroller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.person, color: themeColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: themeColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailcontroller,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-Mail",
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon:
                    const Icon(Icons.alternate_email, color: themeColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: themeColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mobilecontroller,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                counterText: "",
                labelText: "Phone No",
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.call, color: themeColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: themeColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                if (_namecontroller.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please Enter Valid Name");

                } else if (_mobilecontroller.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please Enter Valid Mobile");
                } else if (_emailcontroller.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please Enter Valid Email");
                  // } else if (_collegecontroller.text.isEmpty) {
                  //   alertmsg(
                  //       context, "Invalid College", "Please Enter College");
                } else {
                  Map<String, dynamic> data = {
                    'mobile': _mobilecontroller.text,
                    'name': _namecontroller.text,
                    'email': _emailcontroller.text,

                  };
                  String response = await updateAccount(data);

                  if (response == "success") {
                    savestring(USER_NAME, _namecontroller.text);
                    savestring(USER_NUMBER, _mobilecontroller.text);
                    savestring(USER_EMAIL, _emailcontroller.text);
                    Fluttertoast.showToast(msg: "Update Successfully");
                  } else {
                    Fluttertoast.showToast(msg: "Failed ! Please try again...");
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
