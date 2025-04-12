import 'dart:convert';

import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../const/config.dart';
import '../onboard/widgets/popular_blog_card.dart';
import 'blog_detail_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({
    super.key,
  });

  @override
  State<BlogScreen> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<BlogScreen> {

   List<dynamic> cardData = [
    // {"title": "JEE Mains Exam", "image": "assets/images/uni1.jpeg"},
    // {"title": "JEE Advanced Exam", "image": "assets/images/uni.png"},
    // {"title": "JMI Delhi Exam", "image": "assets/images/uni1.jpeg"},
    // {"title": "NEET Mains Exam", "image": "assets/images/images.jpeg"},
    // {"title": "JEE Mains Exam", "image": "assets/images/uni1.jpeg"},
    // {"title": "JEE Advanced Exam", "image": "assets/images/uni.png"},
    // {"title": "JMI Delhi Exam", "image": "assets/images/uni1.jpeg"},
    // {"title": "NEET Mains Exam", "image": "assets/images/images.jpeg"},
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
          "blog_fetch.php?type=popular"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {

          cardData = json.decode(response.body) ;


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
      body: Container(
        padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Blog",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 33,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                  color: themeColor, borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: cardData.isEmpty?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetailScreen(),
                            ));
                      },
                      child: Container(
                        height: screenheight(context) * 0.30,
                        width: screenwidth(context),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(ImageURL+
                                  cardData[0]['image'],
                                width: screenwidth(context),
                                fit: BoxFit.fill,
                                height: screenheight(context) * 0.30,
                              ),
                            ),
                             Positioned(
                              left: 10,
                              bottom: 10,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.newspaper,
                                    color: themeColor,
                                    size: 27,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    cardData[0]['title'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // const Text(
                    //   "Popular",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white,
                    //     fontSize: 33,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //   height: 3,
                    //   width: 80,
                    //   decoration: BoxDecoration(
                    //       color: themeColor, borderRadius: BorderRadius.circular(5)),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: cardData.length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if(index==0){
                          return Container();
                        }
                        return PopularBlogCard(
                          img: cardData[index]['image']!,
                          title: cardData[index]['title']!,
                        );

                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
