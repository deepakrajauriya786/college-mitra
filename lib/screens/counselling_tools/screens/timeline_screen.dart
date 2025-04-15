import 'dart:convert';

import 'package:college_dost/const/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeline_tile/timeline_tile.dart';

import '../../../const/config.dart';
import '../../../const/dummy_data.dart';

class TimelineScreen extends StatefulWidget {

  final String sc_id;
  final String cc_id;
  final String title;

  const TimelineScreen(
      {super.key, required this.sc_id, required this.cc_id, required this.title});

  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<TimelineScreen> {

  List<dynamic> cardDataBlog = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await fetchDataBlog();
    } catch (e) {
      print('Error fetching data: $e');
    }

  }

  Future<String> fetchDataBlog() async {
    try {
      final response = await http.get(Uri.parse(BASEURL +
          "timeline_fetch.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}"));
      if (response.statusCode == 200) {
        print(
            "timeline_fetch timeline_fetch.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}");
        setState(() {
          cardDataBlog = json.decode(response.body);
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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Timeline',
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
      body: Column(
        children: [
          Container(
            color: Colors.black,
            width: screenwidth(context),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/uni.png",
                  width: 80,
                  height: 80,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Schedule",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          cardDataBlog.isEmpty?CircularProgressIndicator(): Expanded(
            child: ListView.builder(
              itemCount: cardDataBlog.length,
              itemBuilder: (context, index) {
                final item = cardDataBlog[index];
                final bool isFirst = index == 0;
                final bool isLast = index == cardDataBlog.length - 1;

                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.2,
                  isFirst: isFirst,
                  isLast: isLast,
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    color: Colors.blue,
                    indicatorXY: 0.5,
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.blue,
                    thickness: 2,
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.blue,
                    thickness: 2,
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                     "${ item['date']} - ${ item['time']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  endChild: Card(
                    margin:
                        const EdgeInsets.only(left: 8.0, bottom: 8, right: 5),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item['description'],
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
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
