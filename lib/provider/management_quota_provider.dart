import 'dart:convert';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../const/config.dart';
import '../const/custom_text_field.dart';
import '../const/navigator.dart';
import '../screens/dashboard/bottom_bar.dart';
import '../screens/dashboard/payment_gateway.dart';

class ManagementQuotaProvider extends ChangeNotifier {
  late TextEditingController email;
  late TextEditingController preferred_college;
  late TextEditingController course_name;
  late TextEditingController name;
  late TextEditingController mobile;
  late TextEditingController dob;
  late TextEditingController marks;
  late TextEditingController student_signature;
  late TextEditingController address;
  late TextEditingController passing_year;
  late TextEditingController brand;

  ManagementQuotaProvider() {
    name = TextEditingController();
    mobile = TextEditingController();
    dob = TextEditingController();
    course_name = TextEditingController();
    preferred_college = TextEditingController();
    email = TextEditingController();
    marks = TextEditingController();
    student_signature = TextEditingController();
    address = TextEditingController();
    passing_year = TextEditingController();
    brand = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    mobile.dispose();
    dob.dispose();
    marks.dispose();
    course_name.dispose();
    preferred_college.dispose();
    student_signature.dispose();
    address.dispose();
    passing_year.dispose();
    brand.dispose();
    super.dispose();
  }

  final PageController pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  set selectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  String? _selectedExam;
  String? _selectedStream;

  String? get selectedExam => _selectedExam;

  set selectedExam(String? value) {
    _selectedExam = value;
    notifyListeners();
  }

  String? _selectedCourse;

  String? get selectedCourse => _selectedCourse;

  set selectedCourse(String? value) {
    _selectedCourse = value;
    notifyListeners();
  }

  String? _selectedCountry;

  String? get selectedCountry => _selectedCountry;

  set selectedCountry(String? value) {
    _selectedCountry = value;
    notifyListeners();
  }

  String? _selectedBudget;

  String? get selectedBudget => _selectedBudget;

  set selectedBudget(String? value) {
    _selectedBudget = value;
    notifyListeners();
  }

  String? get selectedStream => _selectedStream;

  set selectedStream(String? value) {
    _selectedStream = value;
    notifyListeners();
  }

  DateTime? _selectedDate;

  String get selectedDateString => _selectedDate != null
      ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
      : "Select Date";

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
      notifyListeners();
    }
  }

  DateTime? _selectedDateForm;

  String get selectedDateStringForm => _selectedDateForm != null
      ? "${_selectedDateForm!.day}/${_selectedDateForm!.month}/${_selectedDateForm!.year}"
      : "Select Date";

  Future<void> pickDateForm(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _selectedDateForm = pickedDate;
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Full Name");
      return;
    }
    if (selectedDateString.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Date of Birth");
      return;
    }
    if (_selectedGender!.isEmpty) {
      Fluttertoast.showToast(msg: "Select Gender");
      return;
    }
    if (mobile.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Mobile");
      return;
    }
    if (email.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter email");
      return;
    }
    if (_selectedCourse!.isEmpty) {
      Fluttertoast.showToast(msg: "Select Course");
      return;
    }
    if (course_name.text.isEmpty) {
      Fluttertoast.showToast(msg: "Select Course Name");
      return;
    }
    if (_selectedExam!.isEmpty) {
      Fluttertoast.showToast(msg: "Select Exam");
      return;
    }
    if (marks.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Marks");
      return;
    }
   if (student_signature.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter student signature");
      return;
    } if (address.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter  address");
      return;
    }
if (passing_year.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter passing year");
      return;
    }if (brand.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter brand");
      return;
    }

    final userId = await UID;

    final uri = Uri.parse(BASEURL + "management_quota.php");
    var request = http.MultipartRequest('POST', uri);

    // // Add selected images to the request dynamically
    // for (int i = 0; i < selectedImages.length; i++) {
    //   request.files.add(await http.MultipartFile.fromPath(
    //       'img${i + 1}', selectedImages[i].path));
    // }

    // Add the other form fields
    request.fields['u_id'] = userId.toString();
    request.fields['name'] = name.text;
    request.fields['dob'] = selectedDateString;
    request.fields['gender'] = _selectedGender!;
    request.fields['mobile'] = mobile.text;
    request.fields['email'] = email.text;
    request.fields['preferred_couse'] = _selectedCourse!;
    request.fields['course_name'] = course_name.text;
    request.fields['preffered_course'] = preferred_college.text;
    request.fields['qualification'] = _selectedExam!;
    request.fields['marks'] = marks.text;
    request.fields['student_signature'] = student_signature.text;
    request.fields['address'] = address.text;
    request.fields['passing_year'] = passing_year.text;
    request.fields['brand'] = brand.text;
    request.fields['selectedDateStringForm'] = selectedDateStringForm;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print("Response: $responseBody");

        var jsondata = jsonDecode(responseBody);
        if (jsondata[0]['message'] == "1") {
          Fluttertoast.showToast(msg: "Uploaded successfully .");
          changeScreen(context, PaymentGateway(id: "3"));
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

  List<Widget> get pages {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Details",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          const SizedBox(height: 15),
          CustomTextField(controller: name, hintText: "Full Name"),
          const SizedBox(height: 15),
          Consumer<ManagementQuotaProvider>(
            builder: (context, provider, child) {
              return CustomTextField(
                label: selectedDateString,
                hintText: "Date of Birth",
                isReadonly: true,
                callback: () {
                  provider.pickDate(context);
                },
              );
            },
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade700, width: 1),
            ),
            child: Consumer<ManagementQuotaProvider>(
              builder: (context, provider, child) {
                return Row(
                  children: <Widget>[
                    const Text(
                      'Gender:',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: provider.selectedGender,
                          onChanged: (value) {
                            provider.selectedGender = value;
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          'Male',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Female',
                          groupValue: provider.selectedGender,
                          onChanged: (value) {
                            provider.selectedGender = value;
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          'Female',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: mobile,
            hintText: "Phone number",
            input: TextInputType.number,
            maxLength: 10,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: email,
            hintText: "Email",
            input: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: address,
            hintText: "Address",
            maxLines: 3,
          ),
        ],
      ),
      Consumer<ManagementQuotaProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Academics Details",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade700, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Exam Passed:',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: '12 Board',
                              groupValue: provider.selectedExam,
                              onChanged: (value) {
                                provider.selectedExam = value;
                              },
                              activeColor: Colors.blue,
                            ),
                            const Text(
                              '12 Board',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Diploma',
                              groupValue: provider.selectedExam,
                              onChanged: (value) {
                                provider.selectedExam = value;
                              },
                              activeColor: Colors.blue,
                            ),
                            const Text(
                              'Diploma',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Graduate',
                              groupValue: provider.selectedExam,
                              onChanged: (value) {
                                provider.selectedExam = value;
                              },
                              activeColor: Colors.blue,
                            ),
                            const Text(
                              'Graduate',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade700, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Stream:',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Science',
                              groupValue: provider.selectedStream,
                              onChanged: (value) {
                                provider.selectedStream = value;
                              },
                              activeColor: Colors.blue,
                            ),
                            const Text(
                              'Science',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Commerce',
                            groupValue: provider.selectedStream,
                            onChanged: (value) {
                              provider.selectedStream = value;
                            },
                            activeColor: Colors.blue,
                          ),
                          const Text(
                            'Commerce',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Arts',
                              groupValue: provider.selectedStream,
                              onChanged: (value) {
                                provider.selectedStream = value;
                              },
                              activeColor: Colors.blue,
                            ),
                            const Text(
                              'Arts',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: marks,
              hintText: "Marks/Percentage",
              input: TextInputType.number,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: brand,
              hintText: "Board Name",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: passing_year,
              hintText: "Year of Passing",
              input: TextInputType.number,
            ),
          ],
        );
      }),
      SingleChildScrollView(
        child: Consumer<ManagementQuotaProvider>(
            builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Course/College/Country Preferences",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Preferred Course:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'Engineering',
                                    groupValue: provider.selectedCourse,
                                    onChanged: (value) {
                                      provider.selectedCourse = value;
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    'Engineering',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'Medical',
                                    groupValue: provider.selectedCourse,
                                    onChanged: (value) {
                                      provider.selectedCourse = value;
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    'Medical',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'Law',
                                    groupValue: provider.selectedCourse,
                                    onChanged: (value) {
                                      provider.selectedCourse = value;
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    'Law',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'Management',
                                    groupValue: provider.selectedCourse,
                                    onChanged: (value) {
                                      provider.selectedCourse = value;
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    'Management',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: course_name,
                hintText: "Course Name",
                input: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Preferred College (Top 5 College):',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: preferred_college,
                hintText: "Colleges",
                input: TextInputType.text,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Budget for Admission:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: '₹2-3 Lakh',
                                    groupValue: provider.selectedBudget,
                                    onChanged: (value) {
                                      provider.selectedBudget = value;
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    '₹2-3 Lakh',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: '₹3-4 Lakh',
                                    groupValue: provider.selectedBudget,
                                    onChanged: (value) {
                                      provider.selectedBudget = value;
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    '₹3-4 Lakh',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: '₹5+ Lakh',
                                    groupValue: provider.selectedBudget,
                                    onChanged: (value) {
                                      provider.selectedBudget = value;
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    '₹5+ Lakh',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Preferred Country:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'India',
                                groupValue: provider.selectedCountry,
                                onChanged: (value) {
                                  provider.selectedCountry = value;
                                },
                                activeColor: Colors.blue,
                              ),
                              const Text(
                                'India',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Abroad',
                                groupValue: provider.selectedCountry,
                                onChanged: (value) {
                                  provider.selectedCountry = value;
                                },
                                activeColor: Colors.blue,
                              ),
                              const Text(
                                'Abroad',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      Consumer<ManagementQuotaProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Declaration",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            const SizedBox(height: 10),
            const Text(
              "I hereby declare that:",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '⦿ Any donation or processing fee will be paid '),
                  TextSpan(
                    text: 'in cash only',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' after admission confirmation.'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(text: '⦿ In case the admission is not secured, '),
                  TextSpan(text: 'any payment made will be refunded '),
                  TextSpan(
                    text: 'fully without delay.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '⦿ Ensuring complete transparency and trust in the process ',
                  ),
                  TextSpan(
                    text: 'during admission.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '⦿ I agree with the rules and regulations of the management quota process for ',
                  ),
                  TextSpan(
                    text: 'Indian or international admissions.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            CustomTextField(
              controller: student_signature,
              hintText: "Student Signature",
              input: TextInputType.text,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              label: selectedDateStringForm,
              hintText: "Date",
              isReadonly: true,
              callback: () {
                provider.pickDateForm(context);
              },
            ),
            const SizedBox(height: 25),
            Center(
              child: ActionSlider.standard(
                width: 300,
                height: 60,
                toggleColor: Colors.blue,
                foregroundBorderRadius: BorderRadius.circular(12),
                backgroundBorderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.white,
                actionThresholdType: ThresholdType.release,
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                action: (controller) async {
                  controller.loading();
                  await Future.delayed(const Duration(seconds: 1));
                  controller.success();
                  await Future.delayed(const Duration(seconds: 1));

                  uploadImage(context);

                  controller.reset();
                },
                child: const Text(
                  'Submit Application',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        );
      })
    ];
  }
}
