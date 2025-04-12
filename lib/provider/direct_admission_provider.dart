import 'dart:convert';
import 'dart:io';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const/color.dart';
import '../const/config.dart';
import '../const/custom_text_field.dart';
import '../const/navigator.dart';
import '../screens/dashboard/bottom_bar.dart';
import '../screens/dashboard/payment_gateway.dart';

class DirectAdmissionProvider extends ChangeNotifier {
  late TextEditingController email;
  late TextEditingController preferred_college;

  late TextEditingController course_name;

  late TextEditingController name;
  late TextEditingController mobile;
  late TextEditingController dob;
  late TextEditingController marks;

  DirectAdmissionProvider() {
    name = TextEditingController();
    mobile = TextEditingController();
    dob = TextEditingController();
    course_name = TextEditingController();
    preferred_college = TextEditingController();
    email = TextEditingController();
    marks = TextEditingController();
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
    super.dispose();
  }

  List<File> selectedImages = [];
  final picker = ImagePicker();

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        limit: 5, imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
        notifyListeners();
      }
    }
    notifyListeners();
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Nothing is selected')));
    // }
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
 if (selectedImages.isEmpty) {
      Fluttertoast.showToast(msg: "Select Images");
      return;
    }

    final userId = await UID;

    final uri = Uri.parse(BASEURL + "college_admission.php");
    var request = http.MultipartRequest('POST', uri);

    // Add selected images to the request dynamically
    for (int i = 0; i < selectedImages.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          'img${i + 1}', selectedImages[i].path));
    }

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

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print("Response: $responseBody");

        var jsondata = jsonDecode(responseBody);
        if (jsondata[0]['message'] == "1") {
          Fluttertoast.showToast(msg: "Uploaded successfully .");
          changeScreen(context, PaymentGateway(id: "1"));
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
            "Personal Information",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: name,
            hintText: "Full Name",
            label: "Enter your full legal name",
          ),
          const SizedBox(height: 15),
          Consumer<DirectAdmissionProvider>(
            builder: (context, provider, child) {
              return CustomTextField(
                hintText: "Date of Birth",
                label:selectedDateString,
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
            child: Consumer<DirectAdmissionProvider>(
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
            label: "Enter your phone number",
            maxLength: 10,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: email,
            hintText: "Email",
            label: "Enter a valid email",
            input: TextInputType.emailAddress,
          ),
        ],
      ),
      SingleChildScrollView(
        child: Consumer<DirectAdmissionProvider>(
            builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Academic Information",
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
                  'Preferred College:',
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
                hintText: "Top 3 Colleges",
                label: "Top 3 Colleges",
                input: TextInputType.multiline,
                maxLines: 3,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Text(
                        'Academics Qualification:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: [
                              Row(
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Postgraduate',
                                          groupValue: provider.selectedExam,
                                          onChanged: (value) {
                                            provider.selectedExam = value;
                                          },
                                          activeColor: Colors.blue,
                                        ),
                                        const Text(
                                          'Postgraduate',
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
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Undergraduate',
                                groupValue: provider.selectedExam,
                                onChanged: (value) {
                                  provider.selectedExam = value;
                                },
                                activeColor: Colors.blue,
                              ),
                              const Text(
                                'Undergraduate',
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
                label: 'Enter your marks or percentage',
              ),
            ],
          );
        }),
      ),
      Consumer<DirectAdmissionProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Verification",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            const Text(
              "Please Uploads the following documents for verification",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            const SizedBox(height: 15),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(text: '⦿ '),
                  TextSpan(
                    text: 'Academic Transcript (Marksheet)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(text: '⦿ '),
                  TextSpan(
                    text: 'Identity Proof (Aadhar/PAN)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(text: '⦿ '),
                  TextSpan(
                    text: 'Recent Photograph',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                provider.getImages();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(7)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                  child: Text(
                    "Upload Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            provider.selectedImages.isEmpty
                ? SizedBox.shrink()
                : ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          provider.selectedImages.take(3).toList().length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                              child: Image.file(
                            provider.selectedImages[index],
                            fit: BoxFit.fill,
                          )),
                        );
                      },
                    ),
                  ),
          ],
        );
      }),
      Consumer<DirectAdmissionProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Terms and Conditions",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
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
                      text:
                          '⦿ By submitting your application, you agree to provide accurate information '),
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
                          "⦿ Direct Admission is subject to the college's approval. We act as an intermediary between you and the college. "),
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
                        '⦿ The Registration fee is non-refundable. Additional college charges may apply. ',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Checkbox(
                    value: true,
                    onChanged: (bool? newValue) {},
                    activeColor: Colors.white,
                    checkColor: themeColor,
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I agree to the terms and conditions ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "By submitting this form, you agree to the college's admission policies. ",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
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
                  'Confirm and Register',
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
