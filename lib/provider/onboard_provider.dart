import 'package:flutter/cupertino.dart';

class OnBoardProvider with ChangeNotifier {
  int currentstep = 0;
  int get _currentstep => currentstep;
  PageController onbordingScroll = PageController();

  List onBoarddata = [
    {
      "title": "Find Perfect Stay",
      "image": "assets/images/sone.png",
      "desc": "PG, Hostel, flats, and rooms-all in one place"
    },
    {
      "title": "Find Your Roomie",
      "image": "assets/images/friends.png",
      "desc":
          "Connect with new students in a public chatroom and find your perfect roomie"
    },
    {
      "title": "Buy Premium",
      "image": "assets/images/buy.png",
      "desc": "Get Premium Now - Find Your Perfect Stay Today"
    }
  ];
  setcurrentstate(value) {
    currentstep = value;
    notifyListeners();
  }

  int getstate() {
    return _currentstep;
  }
}
