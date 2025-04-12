import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../const/config.dart';

class KnowAboutScreen extends StatefulWidget {
  final String sc_id;
  final String cc_id;
  final String title;

  const KnowAboutScreen(
      {super.key,
      required this.sc_id,
      required this.cc_id,
      required this.title});

  @override
  State<KnowAboutScreen> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<KnowAboutScreen> {
  List<dynamic> home_detail = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await fetchCounsellingDetails();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<String> fetchCounsellingDetails() async {
    try {
      final response = await http.get(Uri.parse(BASEURL +
          "counselling.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}"));
      if (response.statusCode == 200) {
        print("counselling ${json.decode(response.body)}");

        setState(() {
          home_detail = json.decode(response.body);
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Know About ${widget.title}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: home_detail.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(ImageURL+home_detail[0]['about_image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          home_detail[0]['short_title'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          home_detail[0]['short_desc'],
                          style: TextStyle(
                              fontSize: 16, height: 1.5, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Text(
                          home_detail[0]['long_title'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          home_detail[0]['long_desc'],
                          style: TextStyle(
                              fontSize: 16, height: 1.5, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
