import 'dart:convert';

import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../const/config.dart';
import '../../../const/navigator.dart';
import '../../dashboard/payment_gateway.dart';

class RankPredictorPage extends StatefulWidget {
  @override
  State<RankPredictorPage> createState() => _RankPredictorPageState();
}

class _RankPredictorPageState extends State<RankPredictorPage> {
  String? jeeRank;

  TextEditingController rank = TextEditingController();

  String? selectedExamdate;

  String? selectedShifts;

  final List<String> dates = ['22 Jan 2025', '23 Jan 2025', '24 Jan 2025'];

  final List<String> shifts = ['1st Shift', '2nd Shift'];

  Future<void> uploadImage(BuildContext context) async {
    if (selectedExamdate.toString().isEmpty) {
      Fluttertoast.showToast(msg: "Select Domicile State");
      return;
    }

    final userId = await UID;

    final uri = Uri.parse(BASEURL + "rank.php");
    var request = http.MultipartRequest('POST', uri);

    // // Add selected images to the request dynamically
    // for (int i = 0; i < selectedImages.length; i++) {
    //   request.files.add(await http.MultipartFile.fromPath(
    //       'img${i + 1}', selectedImages[i].path));
    // }

    // Add the other form fields
    request.fields['u_id'] = userId.toString();
    request.fields['rank'] = rank.text;
    request.fields['selectedExamdate'] = selectedExamdate.toString();

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print("Response: $responseBody");

        var jsondata = jsonDecode(responseBody);
        if (jsondata[0]['message'] == "1") {
          Fluttertoast.showToast(msg: " Get Rank .");
          showResultBottomSheet(
              context, jsondata[0]['rank'], jsondata[0]['percent']);
        } else {
          Fluttertoast.showToast(msg: "Uploaded Failed");
        }
      } else {
        print("Upload failed with status: ${response.statusCode}");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Failed")),
        // );
      }
    } catch (e) {
      print("Error: $e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("An error occurred")),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rank Predictor',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/rank_banner.jpg"),
            // Container(
            //   padding: EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.grey[800],
            //     shape: BoxShape.circle,
            //   ),
            //   child: const Icon(
            //     Icons.error_outline,
            //     color: Colors.white,
            //     size: 48,
            //   ),
            // ),
            // const SizedBox(height: 16),
            // const Text(
            //   'Yet to Happen!',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
            // SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //   child: Text(
            //     'JEE Mains 2025 Exam is yet to occur and you will be able to access rank predictor after the 1st day of exam.',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: Colors.grey[300],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rank Predictor',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Jee Mains',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                  const Text(
                    'College Friend Provides Free JEE Rank Prediction to predict percentile and rank by the by the expected marks entered by the student',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 26),
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.black,
                          decoration: InputDecoration(
                          
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Select Your Exam Date',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                          ),
                          style: TextStyle(color: Colors.white),
                          value: selectedExamdate,
                          items: dates
                              .map((state) => DropdownMenuItem(
                                    value: state,
                                    child: Text(state,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedExamdate = value;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Select Your Shift',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                          ),
                          style: TextStyle(color: Colors.white),
                          value: selectedShifts,
                          items: shifts
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category,
                                        style: TextStyle(color: Colors.white)),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedShifts = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: rank,
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Expected Marks",
                            filled: true,
                            fillColor: Colors.black,
                            labelStyle: const TextStyle(color: Colors.white70),
                            prefixIcon:
                                const Icon(Icons.tag, color: themeColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white70),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: themeColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: GestureDetector(
          onTap: () {
            uploadImage(context);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: themeColor, borderRadius: BorderRadius.circular(12)),
            child: const Center(
              child: Text(
                "Predict Rank",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showResultBottomSheet(
      BuildContext context, String jeerank, String percent) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Icon(Icons.school, size: 60, color: Colors.blue),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text("Expected Rank ",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(height: 8),
                          Text(jeerank,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text("Expected Percentile",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(height: 8),
                          Text(percent,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
