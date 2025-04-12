import 'package:shared_preferences/shared_preferences.dart';


//google location api
const String apiKey = 'AIzaSyC9ANwxEYoo6TGTHJIuqSsEJmbfV-rFqHU';
const String ImageURL = "https://techeor.co.in/my_project/college_friend/images/";
const String BANNERIMAGE = "https://techeor.co.in/my_project/college_friend/banner_img/";
const String BASEURL = "https://techeor.co.in/my_project/college_friend/api/";


Future<String> get UID async {
  return await readStringFromPref();
}

// Method to read from SharedPreferences
Future<String> readStringFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('u_id') ?? '';
  return stringValue;
}
