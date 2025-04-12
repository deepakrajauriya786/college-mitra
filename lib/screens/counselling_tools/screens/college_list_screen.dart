import 'dart:convert';

import 'package:college_dost/const/navigator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../const/config.dart';
import '../../../const/dummy_data.dart';
import 'college_detail_screen.dart';

class CollegeListScreen extends StatefulWidget {
  @override
  State<CollegeListScreen> createState() => _CollegeListScreenState();
}

class _CollegeListScreenState extends State<CollegeListScreen> {
  String selectedTab = 'State';
  Map<String, bool> selectedStates = {};
  Map<String, bool> selectedColleges = {};
  Map<String, bool> selectedTypes = {};

  List<dynamic> collegesList = [
    // {"name": "Dr. B R Ambedkar National Institute of Technology, Jalandhar", "branches": 14},
    // {"name": "Malaviya National Institute of Technology Jaipur", "branches": 8},
    // {"name": "Maulana Azad National Institute of Technology Bhopal", "branches": 9},
    // {"name": "Motilal Nehru National Institute of Technology Allahabad", "branches": 8},
    // {"name": "National Institute of Technology Agartala", "branches": 14},
    // {"name": "National Institute of Technology Calicut", "branches": 8},
  ];


  @override
  void initState() {
    super.initState();
    fetchData();
    states.forEach((state) => selectedStates[state] = false);
    colleges.forEach((college) => selectedColleges[college] = false);
    // Use college name as key
    types.forEach((type) => selectedTypes[type] = false);
  }

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse(BASEURL +
          "college_list_fetch.php?rank=300"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {

          collegesList = json.decode(response.body) ;


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



  void showbottom(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            List<dynamic> items = selectedTab == 'State'
                ? states
                : selectedTab == 'Colleges'
                    ? colleges
                    : types;
            Map<String, bool> selectedMap = selectedTab == 'State'
                ? selectedStates
                : selectedTab == 'Colleges'
                    ? selectedColleges
                    : selectedTypes;

            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.black87,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter Options',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: ['Type', 'Colleges', 'State']
                        .map(
                          (tab) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setBottomSheetState(() {
                                  selectedTab = tab;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: selectedTab == tab
                                          ? Colors.blue
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  tab,
                                  style: TextStyle(
                                    color: selectedTab == tab
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        String item;
                        if (selectedTab == 'Colleges') {
                          // Extract the college name for display
                          item = items[index];
                        } else {
                          item = items[index];
                        }

                        return CheckboxListTile(
                          title: Text(
                            item,
                            style: TextStyle(color: Colors.white),
                          ),
                          value: selectedMap[item],
                          onChanged: (value) {
                            setBottomSheetState(() {
                              toggleSelection(item, selectedMap);
                            });
                          },
                          activeColor: Colors.blue,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void toggleSelection(String key, Map<String, bool> map) {
    setState(() {
      map[key] = !map[key]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          "All Colleges",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      showbottom(context);
                    },
                    child: const Icon(
                      Icons.filter_alt,
                      color: Colors.white,
                    )),
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Search Colleges...",
                hintStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: collegesList.length,
              itemBuilder: (context, index) {
                var college = collegesList[index];
                return GestureDetector(
                  onTap: () {
                    changeScreen(context, CollegeDetailScreen());
                  },
                  child: Card(
                    color: Colors.grey[900],
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(ImageURL+
                                college['image'],
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 10,
                              right: 10,
                              bottom: 5,
                              child: Text(
                                college['name'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Type: \n${college['exam']}",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "State: \n${college['state']}",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
