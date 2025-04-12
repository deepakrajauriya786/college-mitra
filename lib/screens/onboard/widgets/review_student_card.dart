import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';

class ReviewStudentCard extends StatelessWidget {
  String desc;
  String name;
  String role;

  ReviewStudentCard(this.desc, this.name, this.role, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenwidth(context),
      child: Card(
        elevation: 5,
        color: Colors.grey[850],
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                desc,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                ),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 35,
                    color: themeColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14,
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        role,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
