import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../const/config.dart';


class CollegeListPredict extends StatefulWidget {

  final String rank;
  final String selectedDomicileState;
  final String selectedCategory;
  final String selectedExams;

  const CollegeListPredict(
      {super.key,
        required this.rank,
        required this.selectedDomicileState,
        required this.selectedCategory,
        required this.selectedExams});

  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<CollegeListPredict> {


  List<dynamic> colleges = [
    // {"name": "Dr. B R Ambedkar National Institute of Technology, Jalandhar", "branches": 14},
    // {"name": "Malaviya National Institute of Technology Jaipur", "branches": 8},
    // {"name": "Maulana Azad National Institute of Technology Bhopal", "branches": 9},
    // {"name": "Motilal Nehru National Institute of Technology Allahabad", "branches": 8},
    // {"name": "National Institute of Technology Agartala", "branches": 14},
    // {"name": "National Institute of Technology Calicut", "branches": 8},
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse(BASEURL +
          "college_list_fetch.php?rank=${widget.rank}"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {

          colleges = json.decode(response.body) ;


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Colleges List', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search Colleges...',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                filterButton('Counselling', 'JEE'),
                filterButton('Domicile', widget.selectedDomicileState),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: colleges.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.school, color: Colors.white),
                  ),
                  title: Text(
                    colleges[index]['name'],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${colleges[index]['branches']} Branches',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget filterButton(String label, String value) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
