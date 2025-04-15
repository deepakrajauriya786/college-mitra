import 'dart:convert';

import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/navigator.dart';
import 'package:college_dost/screens/predictor/screens/rank_predictor_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../const/config.dart';
import '../../const/dummy_data.dart';
import '../counselling_tools/screens/branch_predict.dart';
import '../counselling_tools/screens/college_list_form.dart';
import '../counselling_tools/screens/college_list_screen.dart';
import '../counselling_tools/screens/college_predict.dart';
import '../counselling_tools/screens/compare_college.dart';
import '../counselling_tools/screens/know_about_screen.dart';
import '../counselling_tools/screens/timeline_screen.dart';
import '../onboard/widgets/blogs_cards.dart';
import '../onboard/widgets/crauser_slider.dart';
import 'direct_admission_slide.dart';

class JosaaCounsellingPage extends StatefulWidget {
  final String sc_id;
  final String cc_id;
  final String title;

  const JosaaCounsellingPage(
      {super.key, required this.sc_id, required this.cc_id, required this.title});

  @override
  State<JosaaCounsellingPage> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<JosaaCounsellingPage> {
  List<dynamic> _bannerImages = [];
  List<dynamic> tool_detail = [];
  List<dynamic> home_detail = [];
  List<dynamic> cardDataBlog = [];
  List<dynamic> video_detail = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await fetchDetails();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await getBannerList();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await fetchCounsellingDetails();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await fetchDataBlog();
    } catch (e) {
      print('Error fetching data: $e');
    } try {
      await getBannervideo_detail();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<String> fetchDataBlog() async {
    try {
      final response =
          await http.get(Uri.parse(BASEURL + "blog_fetch.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}"));
      if (response.statusCode == 200) {
        print("blog_fetch blog_fetch.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}");
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

  Future<String> getBannerList() async {
    String place_id;
    if (widget.sc_id == '0') {
      place_id = widget.cc_id;
    } else {
      place_id = widget.sc_id;
    }

    try {
      final response = await http.get(Uri.parse(
          BASEURL + "banners.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {
          _bannerImages = json.decode(response.body) as List<dynamic>;
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

  Future<String> getBannervideo_detail() async {

    try {
      final response = await http.get(Uri.parse(
          BASEURL + "video_detail.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}"));
      if (response.statusCode == 200) {
        print("video_detail ${json.decode(response.body)}");
        setState(() {
          video_detail = json.decode(response.body) as List<dynamic>;
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

  Future<String> fetchDetails() async {
    try {
      final response = await http.get(Uri.parse(BASEURL +
          "tool_detail.php?cc_id=${widget.cc_id}&sc_id=${widget.sc_id}"));
      if (response.statusCode == 200) {
        print("detail_fetch ${json.decode(response.body)}");

        setState(() {
          tool_detail = json.decode(response.body);
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
      appBar: AppBar(
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
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bannerImages.isNotEmpty
                  ? CrauserSlider(
                      datalist: _bannerImages,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              SizedBox(height: 16),
              Text(
                'Counseling Tools',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Hands on these tools to know the Process...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              tool_detail.isNotEmpty
                  ? GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 10,
                      ),
                      children: [
                        _buildToolItem(
                            tool_detail[0]['name'], tool_detail[0]['image'],
                            () {
                          changeScreen(context, KnowAboutScreen(sc_id: widget.sc_id,cc_id: widget.cc_id,title: widget.title,));
                        }),
                        _buildToolItem(
                            tool_detail[1]['name'], tool_detail[1]['image'],
                            () {
                          changeScreen(context, TimelineScreen());
                        }),
                        _buildToolItem(
                            tool_detail[2]['name'], tool_detail[2]['image'],
                            () {
                          changeScreen(context, RankPredictorPage());
                        }),
                        _buildToolItem(
                            tool_detail[3]['name'], tool_detail[3]['image'],
                            () {
                          changeScreen(context, DirectAdmissionSlide());
                        }),
                        // _buildToolItem(
                        //     tool_detail[4]['name'], tool_detail[4]['image'],
                        //     () {
                        //   changeScreen(context, CollegePredict());
                        // }),
                        _buildToolItem(
                            tool_detail[5]['name'], tool_detail[5]['image'],
                            () {
                          changeScreen(context, CompareCollege());
                        }),
                        // _buildToolItem(
                        //     tool_detail[6]['name'], tool_detail[6]['image'],
                        //     () {
                        //   changeScreen(context, BranchPredict());
                        // }),
                        _buildToolItem(
                            tool_detail[7]['name'], tool_detail[7]['image'],
                            () {
                          changeScreen(context, CollegeListScreen());
                        }),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              SizedBox(height: 16),
              if (home_detail.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    ImageURL + home_detail[0]['image'],
                    width: screenwidth(context),
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  " Blogs",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                      height: 220, // Adjust the height of the cards
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cardDataBlog.length,
                          itemBuilder: (context, index) {
                            return BlogsCards(
                              cardDataBlog[index]['title'],
                              cardDataBlog[index]['desc'],
                              cardDataBlog[index]['image'],
                              cardDataBlog[index]['bd_id'],
                              background: Colors.grey.shade900,
                              title: Colors.white,
                            );
                          }))),
              const SizedBox(height: 16),
              const Text(
                'Related Videos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CrauserSlider(
                datalist: video_detail,
                autoplay: false,
                height: 130,
                viewport: 0.60,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolItem(String title, String iconPath, onpress) {
    return GestureDetector(
      onTap: onpress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    ImageURL + iconPath,
                    // fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
