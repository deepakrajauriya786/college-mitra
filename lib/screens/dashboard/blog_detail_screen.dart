import 'dart:convert';

import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../const/config.dart';

class BlogDetailScreen extends StatefulWidget {
  String bd_id;

  BlogDetailScreen(
    this.bd_id, {
    super.key,
  });

  @override
  State<BlogDetailScreen> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<BlogDetailScreen> {
  List<dynamic> cardData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<String> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse(BASEURL + "blog_detail_fetch.php?bd_id=${widget.bd_id}"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {
          cardData = json.decode(response.body);
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
      body: cardData.isEmpty
          ? CircularProgressIndicator()
          : Stack(
              children: [
                SizedBox(
                  width: screenwidth(context),
                  height: screenheight(context) * 0.35,
                  child: Image.network(
                    ImageURL + cardData[0]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  right: 15,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
                Container(
                  height: screenheight(context),
                  width: screenwidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Container(
                        height: screenheight(context) * 0.70,
                        width: screenwidth(context),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "POPULAR",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: themeColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  cardData[0]['title'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Post Date: ${cardData[0]['date']}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[850],
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "CollegeFriend",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(cardData[0]['desc'],
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
