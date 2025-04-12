import 'dart:convert';

import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:college_dost/const/navigator.dart';
import 'package:college_dost/screens/counselling_tools/screens/college_predict.dart';
import 'package:college_dost/screens/counselling_tools/screens/compare_college.dart';
import 'package:college_dost/screens/dashboard/direct_admission_slide.dart';
import 'package:college_dost/screens/dashboard/management_quota_slide.dart';
import 'package:college_dost/screens/dashboard/premium_screen.dart';
import 'package:college_dost/screens/onboard/widgets/blogs_cards.dart';
import 'package:college_dost/screens/predictor/screens/rank_predictor_screen.dart';
import 'package:college_dost/screens/premium/screens/premium_onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../const/comming_soon.dart';
import '../../const/config.dart';
import '../../const/database.dart';
import '../../const/dummy_data.dart';
import '../onboard/widgets/crauser_slider.dart';
import '../onboard/widgets/review_student_card.dart';
import 'accomodation_slide.dart';
import 'counselling_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _OtpSigninState();
}

class _OtpSigninState extends State<HomeScreen> {
  List<dynamic> _bannerImages = [];
  List<dynamic> homeDetails = [];
  List<dynamic> _bannerImageSecound = [];
  String name = '';

  String email='';
  String call='';
  String insta='';
  String youtube='';
  String whatsapp='';
  List<dynamic> cardDataBlog = [];
  List<dynamic> cardDataMentorship = [];
  List<dynamic> category = [];
  List<dynamic> subCategory = [];
  List<dynamic> childCategory = [];
    final _key = GlobalKey<ExpandableFabState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
    getData();
  }

  void getData(){
    try{
      userProfileFetch();
    }catch(e){

    }
  }

  Future<void> launchEmail(String? email) async {
    if (email == null || email.isEmpty) {
      print('Invalid email address');
      return;
    }

    final Uri emailUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email client');
    }
  }

  Future<List<dynamic>> userProfileFetch() async {
    try {
      final userId = await UID; // Replace with actual user ID logic
      final response =
      await http.get(Uri.parse("${BASEURL}contact_detail.php?u_id=$userId"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {

          call=data[0]['call'];
          email=data[0]['email'];
          insta=data[0]['insta'];
          youtube=data[0]['youtube'];
          whatsapp=data[0]['whatsapp'];

        });
        return jsonDecode(response.body);

      } else {
        throw Exception("Server Error!");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<void> fetchData() async {
    try {
      await fetchDatacategory();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await initialize();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await getBannerList();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await getHomeList();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await getBannerList_bannerImageSecound();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await fetchDataBlog();
    } catch (e) {
      print('Error fetching data: $e');
    }
    try {
      await fetchDatacardDataMentorship();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<String> fetchDataBlog() async {
    try {
      final response =
          await http.get(Uri.parse(BASEURL + "blog_fetch.php?type=popular"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
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

  Future<String> fetchDatacategory() async {
    try {
      final response = await http
          .get(Uri.parse(BASEURL + "category_fetch.php?type=popular"));
      if (response.statusCode == 200) {
        print("category ${json.decode(response.body)}");
        setState(() {
          category = json.decode(response.body);
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

  Future<String> fetchDataSubcategory(String c_id) async {
    subCategory.clear();
    try {
      final response = await http
          .get(Uri.parse(BASEURL + "sub_category_fetch.php?c_id=$c_id"));
      if (response.statusCode == 200) {
        print("subCategory ${json.decode(response.body)}");
        setState(() {
          subCategory = json.decode(response.body);
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

  Future<String> fetchDataChildcategory(String sc_id) async {
    childCategory.clear();
    try {
      final response = await http
          .get(Uri.parse(BASEURL + "child_category_fetch.php?sc_id=$sc_id"));
      if (response.statusCode == 200) {
        print("child_category_fetch ${json.decode(response.body)}");
        setState(() {
          childCategory = json.decode(response.body);
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

  Future<String> fetchDatacardDataMentorship() async {
    try {
      final response = await http
          .get(Uri.parse(BASEURL + "mentorship_fetch.php?type=popular"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {
          cardDataMentorship = json.decode(response.body);
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

  Future<void> initialize() async {
    name = await getstring(USER_NAME);
    setState(() {});
  }

  Future<String> getBannerList() async {
    try {
      final response =
          await http.get(Uri.parse(BASEURL + "banners.php?place_id=0"));
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

  Future<String> getHomeList() async {
    try {
      final response =
          await http.get(Uri.parse(BASEURL + "home_details.php?place_id=0"));
      if (response.statusCode == 200) {
        print("home_details ${json.decode(response.body)}");
        setState(() {
          homeDetails = json.decode(response.body);
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

  Future<String> getBannerList_bannerImageSecound() async {
    try {
      final response =
          await http.get(Uri.parse(BASEURL + "banners.php?place_id=1"));
      if (response.statusCode == 200) {
        print("banner ${json.decode(response.body)}");
        setState(() {
          _bannerImageSecound = json.decode(response.body) as List<dynamic>;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hey $name",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "How can we help you today?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: themeColor,
                    ),
                    onPressed: () {
                      changeScreen(context, NotificationScreen());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _bannerImages.isNotEmpty
                ? CrauserSlider(
                    datalist: _bannerImages,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Explore",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                " Counselling and Mentorship",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 2,
                children: List.generate(category.length, (index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        final response =
                            await fetchDataSubcategory(category[index]['c_id']);
                        if (response == "success") {
                          showEngCollege(
                              context, category[index]['name'], subCategory);
                        }
                      } else if (index == 4) {
                        changeScreen(context, ManagementQuotaSlide());
                      } else {
                        final response =
                            await fetchDataSubcategory(category[index]['c_id']);

                        if (response == "success") {
                          print("object");
                          showEngcounselling(
                              context, subCategory, category[index]['name']);
                        }
                      }
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  ImageURL + category[index]['image'],
                                  // fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category[index]['name'],
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Best Services",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Try out some Best Services by us",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardData.length,
                        itemBuilder: (context, index) {
                          return Cards(index, context);
                        }))),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Popular Blogs",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Explore Admission Knowledge in Blogs",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardDataBlog.length,
                        itemBuilder: (context, index) {
                          return BlogsCards(
                            cardDataBlog[index]['title'],
                            cardDataBlog[index]['desc'],
                            cardDataBlog[index]['image'],
                          );
                        }))),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () =>  changeScreen(context, PremiumOnboardScreen()),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5), width: .5)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: homeDetails.isNotEmpty
                        ? Image.network(
                            ImageURL + homeDetails[0]['short_banner'])
                        : Image.asset("assets/images/guide.jpg")),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Our Mentorship",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Explore Fantastic Reviews by our Students",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardDataMentorship.length,
                        itemBuilder: (context, index) {
                          return ReviewStudentCard(
                              cardDataMentorship[index]['desc'],
                              cardDataMentorship[index]['name'],
                              cardDataMentorship[index]['role']);
                        }))),
            GestureDetector(
              onTap: () {
                changeScreen(context, PremiumOnboardScreen());
              },
              child: Container(
                width: screenwidth(context),
                height: 50,
                margin:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Get Premium Support",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: homeDetails.isNotEmpty
                      ? Image.network(ImageURL + homeDetails[0]['long_banner'])
                      : Image.asset("assets/images/reminder.jpg")),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Why CollegeFriend?",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      homeDetails.isNotEmpty
                          ? Image.network(
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                              ImageURL + homeDetails[0]['addmission'])
                          : Image.asset(
                              "assets/images/add.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                      Text(
                        "Addmission",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      homeDetails.isNotEmpty
                          ? Image.network(
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                              ImageURL + homeDetails[0]['counselling'])
                          : Image.asset(
                              "assets/images/coun.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                      Text(
                        "Counselling",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      homeDetails.isNotEmpty
                          ? Image.network(
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                              ImageURL + homeDetails[0]['community'])
                          : Image.asset(
                              "assets/images/com.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                      Text(
                        "Community",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      homeDetails.isNotEmpty
                          ? Image.network(
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                              ImageURL + homeDetails[0]['accomodation'])
                          : Image.asset(
                              "assets/images/acco.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                      Text(
                        "Accomodation",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _bannerImageSecound.isNotEmpty
                ? CrauserSlider(
                    datalist: _bannerImageSecound,
                    autoplay: false,
                    height: 130,
                    viewport: 0.60,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
        floatingActionButtonLocation:
          ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        distance: 60,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black87.withOpacity(0.4), 
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.highlight_remove),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: themeColor,
          backgroundColor: themelightblue,
          shape: const CircleBorder(),
        ),

        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.menu),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: themeColor,
          backgroundColor: themelightblue,
          shape: const CircleBorder(),
        ),
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 30,
                child: Center(child: Text('Mail')),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(width: 10),
              Container(
                height: 35,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Icon(
                    Icons.alternate_email,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 30,
                child: Center(child: Text('Youtube')),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(width: 10),
              Container(
                height: 35,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.video_camera_back_outlined,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 30,
                child: Center(child: Text('Call Now')),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(width: 10),
              Container(
                height: 35,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 30,
                child: Center(child: Text('Whatsapp')),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(width: 10),
              Container(
                height: 35,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget Cards(index, context) {
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          changeScreen(context, RankPredictorPage());
        } else if (index == 3) {
          changeScreen(context, CollegePredict());
        } else if (index == 4) {
          changeScreen(context, CompareCollege());
        } else if (index == 5) {
          changeScreen(context, CommingSoon());
        } else if (index == 1) {
          changeScreen(context, AccomodationSlide());
        } else if (index == 0) {
          changeScreen(context, DirectAdmissionSlide());
        }
      },
      child: Card(
        color: Colors.grey[850],
        margin: const EdgeInsets.only(right: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: 120,
          width: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData[index]['subtitle']!,
                style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.2)),
                child: Text(
                  cardData[index]['title']!,
                  style: TextStyle(
                      color: themeColor.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showEngCollege(
    BuildContext context,
    String name,
    List<dynamic> sub_category,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[850],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 3,
                color: Colors.grey,
              ),
              Container(
                color: Colors.black,
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Select types",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.79,
                      ),
                      itemCount: sub_category.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            // Navigator.pop(context);

                            final response = await fetchDataChildcategory(
                                sub_category[index]['sc_id']);

                            if (response == "success") {
                              print("object");
                              showEngcounselling(context, childCategory,
                                  sub_category[index]['name']);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          ImageURL +
                                              sub_category[index]['image'],
                                          // fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  sub_category[index]['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showEngcounselling(
      BuildContext context, List<dynamic> listdata, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[850],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 3,
                color: Colors.grey,
              ),
              Container(
                color: Colors.black,
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Select Counselling",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.95,
                      ),
                      itemCount: listdata.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            changeScreen(
                                context,
                                JosaaCounsellingPage(
                                  sc_id: listdata[index]['sc_id']??'0',cc_id: listdata[index]['cc_id']??'0',title: listdata[index]['name'],
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          ImageURL + listdata[index]['image'],
                                          // fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  listdata[index]['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
