import 'package:college_dost/const/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../const/color.dart';
import '../../../const/dummy_data.dart';

class CollegeListForm extends StatefulWidget {
  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<CollegeListForm> {
  String? jeeRank;
  String? selectedDomicileState;
  String? selectedCategory;
  String? selectedsubCategory;
  String? selectedGender;
  List<String> selectedCounseling = [];
  int totalAmount = 0;
  TextEditingController rank = TextEditingController();

  final List<String> states = ['State 1', 'State 2', 'State 3'];
  final List<String> categories = ['EWS', 'General', 'OBC-NCL', 'SC', 'ST'];
  final List<String> subcategories = ['Creamy', 'Non-Creamy'];
  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> counselingOptions = [
    'JCECE',
    'MHTCET',
    'UGEAC',
    'OJEE',
    'UTU',
    'WBJEE',
    'JAC Delhi',
    'HSTES',
    'UPTU',
    'REAP',
    'JAC Chandigarh',
    'GGSIPU Delhi',
    'JOSAA',
    'MPDTE'
  ];

  void updateAmount() {
    setState(() {
      totalAmount = selectedCounseling.length * 500;
    });
  }

  void showMyDialogHired(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("About College"),
          content:
              const Text("We will send your email of selected college list."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // changeScreen(context, CreateEmployerProfileScreen(false));
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void openJeeRankDialog() {
    TextEditingController rankController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text('Enter JEE Rank', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: rankController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter your JEE rank',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                jeeRank = rankController.text;
              });
              Navigator.pop(context);
            },
            child: Text('OK', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void openCounselingDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Select Counseling',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          content: SizedBox(
            height: 300,
            child: ListView(
              children: counselingOptions
                  .map(
                    (option) => CheckboxListTile(
                      checkColor: Colors.black,
                      activeColor: Colors.blue,
                      title: Text(option,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      value: selectedCounseling.contains(option),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedCounseling.add(option);
                          } else {
                            selectedCounseling.remove(option);
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Done', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Colleges List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenheight(context) * 0.12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'College List',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Josaa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "College Dost provides free PDF of Engineering colleges from 11 state and central counsellings across India. Avail this amazing opportunity and get the PDF in a second",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 26),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Select Domicile State',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    value: selectedDomicileState,
                    items: allStates
                        .map((state) => DropdownMenuItem(
                              value: state,
                              child: Text(state,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDomicileState = value;
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
                      labelText: 'Select Your Category',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    value: selectedCategory,
                    items: categories
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
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
                      labelText: 'Select Your Sub Category',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    value: selectedsubCategory,
                    items: subcategories
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedsubCategory = value;
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
                      labelText: 'Select Your Gender',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    value: selectedGender,
                    items: genders
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // GestureDetector(
                  //   onTap: openCounselingDialog,
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[850],
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Select Counseling',
                  //           style: TextStyle( color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                  //         ),
                  //         Icon(Icons.arrow_drop_down, color: Colors.white),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  TextField(
                    controller: rank,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter JEE Mains Percentile",
                      filled: true,
                      fillColor: Colors.black,
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.tag, color: themeColor),
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
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                if (rank.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Enter Rank');
                  return;
                }

                showMyDialogHired(context);
              },
              child: Container(
                width: screenwidth(context),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Get College List",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
