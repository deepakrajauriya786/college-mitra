import 'package:college_dost/const/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../const/color.dart';
import '../../../const/dummy_data.dart';
import '../../../const/navigator.dart';
import 'college_list_predict.dart';

class BranchPredict extends StatefulWidget {
  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<BranchPredict> {
  String? jeeRank;
  String? selectedDomicileState;
  String? selectedCategory;
  String? selectedsubCategory;
  String? selectedGender;
  String? selectedExams;
  List<String> selectedCounseling = [];
  int totalAmount = 0;
  TextEditingController rank = TextEditingController();

  final List<String> states = ['State 1', 'State 2', 'State 3'];
  final List<String> categories = ['EWS', 'General', 'OBC-NCL', 'SC', 'ST'];
  final List<String> subcategories = ['Creamy', 'Non-Creamy'];
  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> exams = ['MBA', 'BBA', 'BCA', "BTECH", "BPHARMA"];
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

  void openCounselingDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.black,
          title:
              Text('Select Counseling', style: TextStyle(color: Colors.white)),
          content: SizedBox(
            height: 300,
            child: ListView(
              children: counselingOptions
                  .map(
                    (option) => CheckboxListTile(
                      checkColor: Colors.black,
                      activeColor: Colors.blue,
                      title:
                          Text(option, style: TextStyle(color: Colors.white)),
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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Branch Predictor",
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
                        text: 'Branch Predictor',
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
                  "College Dost provides free Branch Predictor Tool for Students to predict the Colleges or Branches they can get based on respective ranks",
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
                      labelStyle: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    value: selectedDomicileState,
                    items: allStates
                        .map((state) => DropdownMenuItem(
                              value: state,
                              child: Text(state,
                                  style: TextStyle(color: Colors.white,
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
                      labelStyle: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    value: selectedCategory,
                    items: categories
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category,
                                  style: TextStyle(color: Colors.white,
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
                      labelText: 'Select Your Exams',
                      labelStyle: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    value: selectedExams,
                    items: exams
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender,
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedExams = value;
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
                  //           style: TextStyle(fontSize: 16, color: Colors.white),
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
                      labelText: "Enter JEE Mains Category Rank",
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
                changeScreen(context, CollegeListPredict(rank:rank.text,
                    selectedCategory: selectedDomicileState.toString(),selectedDomicileState:  selectedCategory.toString(),
                    selectedExams:  selectedExams.toString()));

              },
              child: Container(
                width: screenwidth(context),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Get College",
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
