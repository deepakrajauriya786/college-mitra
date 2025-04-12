import 'package:flutter/material.dart';


class HomeScreenqeWAERSTDGHJ extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenqeWAERSTDGHJ> {

  List<Map<String, dynamic>> counselingOptions = [
    {"name": "GGSIPU Delhi", "price": 500, "selected": false},
    {"name": "REAP", "price": 400, "selected": false},
    {"name": "WBJEE", "price": 600, "selected": false},
    {"name": "UTU", "price": 300, "selected": false},
    {"name": "JCECE", "price": 450, "selected": false},
    {"name": "MHTCET", "price": 550, "selected": false},
    {"name": "JAC Delhi", "price": 700, "selected": false},
    {"name": "HSTES", "price": 350, "selected": false},
    {"name": "UPTU", "price": 480, "selected": false},
    {"name": "UGEAC", "price": 620, "selected": false},
    {"name": "JOSAA", "price": 750, "selected": false},
    {"name": "MPDTE", "price": 380, "selected": false},
    {"name": "JAC Chandigarh", "price": 500, "selected": false},
    {"name": "OJEE", "price": 530, "selected": false},
  ];

  int totalAmount = 0;

  void _showCounselingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Counseling",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: counselingOptions.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(counselingOptions[index]['name']),
                          subtitle:
                          Text("₹${counselingOptions[index]['price']}"),
                          value: counselingOptions[index]['selected'],
                          onChanged: (bool? value) {
                            setState(() {
                              counselingOptions[index]['selected'] = value!;
                              _updateTotalAmount();
                            });
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {}); // Refresh UI
                    },
                    child: Text("Done"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updateTotalAmount() {

    totalAmount = counselingOptions
        .where((element) => element['selected'] == true)
        .fold<int>(0, (sum, item) => sum + (item['price'] as int));

    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counseling Selection")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Counseling"),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _showCounselingBottomSheet(context),
              child: Text("Select Counseling"),
            ),
            SizedBox(height: 20),
            Text("Total Amount: ₹$totalAmount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
