import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../const/app_sizes.dart';
import '../../../const/config.dart';
import '../../../const/navigator.dart';
import 'college_list_predict.dart';
import 'compare_detail.dart';

class CompareCollege extends StatefulWidget {
  @override
  _CompareCollegeState createState() => _CompareCollegeState();
}

class _CompareCollegeState extends State<CompareCollege> {

   List<String> colleges = [];

  String? selectedCollege1;
  String? selectedCollege2;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse(BASEURL +
          "college_list_fetch.php"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {

         var college = json.decode(response.body) ;
         for (var vs in college) { // Iterate over the list
           colleges.add(vs['name']); // Extract and add the name to the list
         }


        });
        return "success";
      } else {
        throw Exception("Failed to fetch car list");
      }
    } catch (e) {
      print('Error fetching car list: $e');
      throw Exception("Error fetching car data");
    }
  }




  void showCollegePicker(BuildContext context, int circleIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.black87,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select College',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: colleges.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        colleges[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        setState(() {
                          if (circleIndex == 1) {
                            selectedCollege1 = colleges[index];
                          } else {
                            selectedCollege2 = colleges[index];
                          }
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
          "College Comparison",
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
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenheight(context) * 0.12,
                ),
                const Text(
                  'College Comparison',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // const Text(
                //   'JOSAA',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.blue,
                //   ),
                // ),
                const SizedBox(height: 4),
                const Text(
                  "College provides Free tool to Compare and select different college options and get the comparison listed based on different parameters.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child:  GestureDetector(
                    onTap: () => showCollegePicker(context, 1),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                          child: Text(
                            selectedCollege1 != null
                                ? selectedCollege1![0]
                                : '?',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          selectedCollege1 ?? 'Select College',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ))
                 ,
                  const Icon(Icons.compare_arrows,
                      size: 40, color: Colors.blue),
                 Expanded(child: GestureDetector(
                   onTap: () => showCollegePicker(context, 2),
                   child: Column(
                     children: [
                       CircleAvatar(
                         radius: 40,
                         backgroundColor: Colors.blue,
                         child: Text(
                           selectedCollege2 != null
                               ? selectedCollege2![0]
                               : '?',
                           style: const TextStyle(
                             fontSize: 24,
                             color: Colors.white,
                           ),
                         ),
                       ),
                       const SizedBox(height: 8),
                       Text(
                         selectedCollege2 ?? 'Select College',
                         style: const TextStyle(color: Colors.white),
                       ),
                     ],
                   ),
                 ),)

                ],
              ),
            ),
            SizedBox(
              height: screenheight(context) * 0.12,
            ),
            GestureDetector(
              onTap: () {
                if (selectedCollege1 != null && selectedCollege2 != null) {
                  // Handle comparison logic here
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(
                  //         'Comparing $selectedCollege1 and $selectedCollege2'),
                  //   ),
                  // );
                  changeScreen(context, CompareDetail());


                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select both colleges'),
                    ),
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Get College",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
