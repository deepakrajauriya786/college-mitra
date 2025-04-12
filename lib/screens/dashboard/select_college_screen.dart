import 'package:college_dost/const/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../const/dummy_data.dart';
import '../../const/navigator.dart';
import '../onboard/widgets/crauser_slider.dart';
import 'counselling_screen.dart';

class SelectCollegeScreen extends StatelessWidget {
  SelectCollegeScreen({Key? key, required this.datas}) : super(key: key);
  final List<String> datas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Select You College',
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
              CrauserSlider(
                datalist: lists,
              ),
              const SizedBox(height: 16),
              const Text(
                'Choose College',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Engineering Counselling and Mentorship Details...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 0,
                  children: List.generate(datas.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // changeScreen(
                        //     context,
                        //     JosaaCounsellingPage(
                        //       sc_id: datas,cc_id: datas[index]['cc_id']??'0',
                        //     ));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Image.asset("assets/images/uni.png"),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            datas[index],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/banner.jpg',
                  width: screenwidth(context),
                  height: 150,
                ),
              ),
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
                datalist: listsecond,
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

  Widget _buildToolItem(String title, String iconPath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
