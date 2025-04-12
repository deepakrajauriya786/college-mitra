import 'package:college_dost/const/config.dart';
import 'package:flutter/material.dart';

import '../../dashboard/blog_detail_screen.dart';

class BlogsCards extends StatelessWidget {


  final Color background;
  final Color title;
  final Color desc;
  final String name;
  final String detail;
  final String image;

  const BlogsCards(
      this.name,
      this.detail,
      this.image,
      {super.key,
        this.background = Colors.white,
        this.title = Colors.black,
        this.desc = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetailScreen(),
            ));
      },
      child: Card(
        elevation: 5,
        color: Colors.grey[850],
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: 200,
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  ImageURL+image,
                  height: 110,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "POPULAR",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      detail,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
