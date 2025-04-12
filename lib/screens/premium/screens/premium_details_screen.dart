import 'dart:convert';

import 'package:action_slider/action_slider.dart';
import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../const/color.dart';
import '../../../const/config.dart';
import '../../../const/custom_text_field.dart';
import '../../../const/navigator.dart';
import '../../dashboard/payment_gateway.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  String? jeeRank;
  String? selectedDomicileState;
  String? selectedCategory;
  String? selectedGender;
  List<String> selectedCounseling = [];
  int totalAmount = 0;
  TextEditingController rankController = TextEditingController();
  List<Map<String, dynamic>> counselingOptions = [
    {"name": "GGSIPU Delhi", "price": 500, "selected": false},
    {"name": "REAP", "price": 400, "selected": false},
    {"name": "WBJEE", "price": 600, "selected": false},
    {"name": "UTU", "price": 300, "selected": false},
    {"name": "JCECE", "price": 450, "selected": false},
    {"name": "MHTCET", "price": 550, "selected": false},
    {"name": "JAC Delhi", "price": 700, "selected": false},
    {"name": "HSTES", "price": 350, "selected": false},
    {"name": "UPTU", "price": 480, "selected": false},
    {"name": "UGEAC", "price": 620, "selected": false},
    {"name": "JOSAA", "price": 750, "selected": false},
    {"name": "MPDTE", "price": 380, "selected": false},
    {"name": "JAC Chandigarh", "price": 500, "selected": false},
    {"name": "OJEE", "price": 530, "selected": false},
  ];

  String name='';
  String email='';
  String logo='';






  @override
  void initState() {
    super.initState();


    userProfileFetch();

  }

  Future<void> uploadImage(BuildContext context) async {

    if (jeeRank.toString().isEmpty) {
      Fluttertoast.showToast(msg: "Enter Rank");
      return;
    }
    if (selectedDomicileState.toString().isEmpty) {
      Fluttertoast.showToast(msg: "Select Domicile State");
      return;
    }
    if (selectedCategory.toString().isEmpty) {
      Fluttertoast.showToast(msg: "Select Category");
      return;
    }

    if (selectedGender.toString().isEmpty) {
      Fluttertoast.showToast(msg: "Select Gender");
      return;
    }
    if (totalAmount==0) {
      Fluttertoast.showToast(msg: "Select Counselling");
      return;
    }

    final userId = await UID;

    final uri = Uri.parse(BASEURL + "premium.php");
    var request = http.MultipartRequest('POST', uri);

    // // Add selected images to the request dynamically
    // for (int i = 0; i < selectedImages.length; i++) {
    //   request.files.add(await http.MultipartFile.fromPath(
    //       'img${i + 1}', selectedImages[i].path));
    // }

    // Add the other form fields
    request.fields['u_id'] = userId.toString();
    request.fields['jeeRank'] = jeeRank.toString();
    request.fields['selectedDomicileState'] = selectedDomicileState.toString();
    request.fields['selectedCategory'] = selectedCategory.toString();
    request.fields['selectedGender'] = selectedGender.toString();
    request.fields['totalAmount'] = totalAmount.toString();
    request.fields['selectedCounseling'] = selectedCounseling.toString();


    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print("Response: $responseBody");

        var jsondata = jsonDecode(responseBody);
        if (jsondata[0]['message'] == "1") {
          Fluttertoast.showToast(msg: "Uploaded successfully .");
          changeScreen(context, PaymentGateway(id: "4"));
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
          // userProfileFetch();
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


  void _showCounselingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Counseling",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: counselingOptions.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(counselingOptions[index]['name']),
                          subtitle:
                          Text("₹${counselingOptions[index]['price']}"),
                          value: counselingOptions[index]['selected'],
                          onChanged: (bool? value) {
                            setState(() {
                              counselingOptions[index]['selected'] = value!;
                              _updateTotalAmount();
                            });
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {}); // Refresh UI
                    },
                    child: Text("Done"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updateTotalAmount() {

    totalAmount = counselingOptions
        .where((element) => element['selected'] == true)
        .fold<int>(0, (sum, item) => sum + (item['price'] as int));

    setState(() {}); // Refresh UI
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenheight(context) * 0.08,
            ),
            Center(
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome To ',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'arvo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Premium',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'arvo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'We are excited to have you on board.\nYou will be taking the best decision of your life.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF3d5f84),
                    Color(0xFF6f2439),
                  ],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(35)),
                          child: logo.isNotEmpty?Image.network(ImageURL+logo,fit: BoxFit.fill, height: 50,
                            width: 50,) : Icon(Icons.person, size: 40, color: Colors.grey),

                        ),
                        const SizedBox(
                          width: 10,
                        ),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$email",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 26),
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: rankController,
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            jeeRank = rankController.text;
                          },
                          decoration: InputDecoration(
                            labelText: "Enter JEE Rank",
                            filled: true,
                            fillColor: Colors.black,
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon:
                                const Icon(Icons.tag, color: themeColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: themeColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                dropdownColor: Colors.black,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Select Domicile State',
                                  labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  filled: true,
                                  fillColor: Colors.black,
                                ),
                                style: const TextStyle(color: Colors.white),
                                value: selectedDomicileState,
                                items: allStates
                                    .map((state) => DropdownMenuItem(
                                          value: state,
                                          child: Text(state,
                                              style: const TextStyle(
                                                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDomicileState = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Select Your Category',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black,
                          ),
                          style: const TextStyle(color: Colors.white),
                          value: selectedCategory,
                          items: categories
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category,
                                        style: const TextStyle(
                                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Select Your Gender',
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.black,
                          ),
                          style: const TextStyle(color: Colors.white),
                          value: selectedGender,
                          items: genders
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender,
                                        style: const TextStyle(
                                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: (){
                            _showCounselingBottomSheet(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  color: Colors.grey.shade800, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Select Counseling',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.monetization_on,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Total Amount',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '₹${totalAmount.toString()}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.discount,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Discount',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '₹0',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                 Row(
                                  children: [
                                    Icon(
                                      Icons.newspaper,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Payable Amount',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '₹${totalAmount.toString()}',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        hintText: 'Enter Refferal code',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 70,
                                      height: 50,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: blueGreen,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Center(
                                        child: Text(
                                          "Apply",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
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
                              await Future.delayed(const Duration(seconds: 2));
                              controller.success();
                              await Future.delayed(const Duration(seconds: 2));

                              uploadImage(context);

                              controller.reset();
                            },
                            child: const Text(
                              'Slide To Pay',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
