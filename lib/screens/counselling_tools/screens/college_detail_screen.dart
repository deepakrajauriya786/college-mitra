import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';

class CollegeDetailScreen extends StatefulWidget {
  const CollegeDetailScreen({super.key});

  @override
  State<CollegeDetailScreen> createState() => _PendingClientListPagesState();
}

class _PendingClientListPagesState extends State<CollegeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(() async {
      if (!tabController.indexIsChanging) {
        if (tabController.index == 0) {
        } else if (tabController.index == 1) {
        } else if (tabController.index == 2) {
        } else if (tabController.index == 4) {}
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        // final client = Provider.of<ClientsProvider>(context, listen: false);
        // client.setStatus('accept');
        // await client.fetchMyClientList();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text(
            'College Name',
            style: TextStyle(color: themeColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.black,
              child: TabBar(
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: -2),
                  isScrollable: true,
                  onTap: (index) async {
                    if (index == 0) {
                    } else if (index == 1) {
                    } else if (index == 2) {
                    } else if (index == 3) {
                    } else {}
                  },
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: themeColor,
                  padding: EdgeInsets.zero,
                  unselectedLabelColor: Colors.white,
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  indicator: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: themeColor, width: 5),
                  )),
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  labelStyle: const TextStyle(
                      color: themeColor,
                      fontSize: 15,
                      fontFamily: 'medium',
                      fontWeight: FontWeight.bold),
                  tabs: const [
                    Text(
                      'About',
                    ),
                    Text('Cutoffs'),
                    Text('Fees'),
                    Text('Placements Records'),
                    Text('Media'),
                    Text('Addmission'),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  about(),
                  cutoff(),

                  fees(),
                  placements(),
                  media(),
                  addmission(),

                  // for (int i = 0; i < 4; i++)
                  //   FutureBuilder(
                  //     future:
                  //         Provider.of<ClientsProvider>(context, listen: false)
                  //             .fetchMyClientList(),
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Center(
                  //           child: CustomProgressIndicator(
                  //               color: Colors.blueGrey.shade100,
                  //               height: 40,
                  //               progressColor: themeColor),
                  //         );
                  //       }
                  //       return Consumer<ClientsProvider>(
                  //           builder: (context, clientProvider, _) {
                  //         final list = clientProvider.manipulatedClient;
                  //         return ListView.builder(
                  //           physics: const BouncingScrollPhysics(),
                  //           padding: EdgeInsets.only(
                  //               right: screenWidth(context) * 0.04,
                  //               left: screenWidth(context) * 0.04,
                  //               top: 5),
                  //           itemCount: 15,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return TaskPendingCard();
                  //           },
                  //         );
                  //       });
                  //     },
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fees() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Branches",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Text("5 LPA",
                      //     style: TextStyle(
                      //         color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Yearly Fees",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Text("2-3 LPA",
                      //     style: TextStyle(
                      //         color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget placements() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: screenwidth(context),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Placement OverView",
                  style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: themeColor,
                  height: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Highest Packages",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text("5 LPA",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Average Packages ",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text("2-3 LPA",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: screenwidth(context),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recruiters",
                  style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: themeColor,
                  height: 3,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget about() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: screenwidth(context),
              height: screenheight(context) * 0.25,
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/counselling.jpg",
                        fit: BoxFit.fill,
                        width: screenwidth(context),
                      )),
                  const Positioned(
                      bottom: 10,
                      left: 5,
                      child: Text(
                        "C.D.L.U College",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: screenwidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Introduction",
                    style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: themeColor,
                    height: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy tes, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Founded: ",
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "2003",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ])),
                  SizedBox(
                    height: 5,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Ranking: ",
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "2003",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ])),
                  SizedBox(
                    height: 5,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Address: ",
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "CDLU Sirsa , Haryana",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ])),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: screenwidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connectivity",
                    style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: themeColor,
                    height: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.airplanemode_active,
                        color: Colors.purple,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Nearby Airport: ",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "2003",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.train,
                        color: Colors.purple,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Nearby Railway Station: ",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "2003",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.bus_alert,
                        color: Colors.purple,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Nearby Bus Stand: ",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "2003",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: screenwidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Details",
                    style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: themeColor,
                    height: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.download,
                        color: Colors.purple,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Website: ",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "2003",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.purple,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Email ID: ",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "2003",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.purple,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Contact No: ",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "2003",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: screenwidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Facilities",
                    style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: themeColor,
                    height: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addmission() {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/counselling.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is JoSAA counselling?',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Candidates who clear JEE (Main) or JEE (Advanced) must register for JoSAA counselling to participate in the admission process for various eminent engineering institutions in India. '
                    'JoSAA supervises admissions to 33 Other-GFTIs, 31 NITs, 26 IIITs, 23 IITs, and IIEST Shibpur.',
                    style: TextStyle(
                        fontSize: 16, height: 1.5, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Allotting seats to candidates occurs throughout six rounds of the JoSAA counselling process. The selection of candidates for seats through JoSAA is based on their qualifications and preferences for colleges and courses.',
                    style: TextStyle(
                        fontSize: 16, height: 1.5, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Eligibility criteria',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Candidates can participate in JoSAA counselling if they have one or more of the below qualifications. According to all the criteria mentioned below, the candidate must have also passed the “Performance in Class 12 or equivalent examination” to be JoSAA eligible.',
                    style: TextStyle(
                        fontSize: 16, height: 1.5, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• JEE (Advanced) for academic programmes (not including the preparatory courses) at IITs.',
                        style: TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• JEE (Advanced) for preparatory courses at IITs.',
                        style: TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Rank in JEE (Main) last year, B.E./BTech paper.',
                        style: TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cutoff() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Select',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black,
                  ),
                  style: TextStyle(color: Colors.white),
                  value: selectedExamdate,
                  items: dates
                      .map((state) => DropdownMenuItem(
                            value: state,
                            child: Text(state,
                                style: TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedExamdate = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Select',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black,
                  ),
                  style: TextStyle(color: Colors.white),
                  value: selectedShifts,
                  items: shifts
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category,
                                style: TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedShifts = value;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        "Get Cutoff Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String? selectedExamdate;

  String? selectedShifts;

  final List<String> dates = ['22 Jan 2025', '23 Jan 2025', '24 Jan 2025'];

  final List<String> shifts = ['1st Shift', '2nd Shift', '3rd Shift'];
  Widget media() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: screenwidth(context),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Images",
                  style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: themeColor,
                  height: 3,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            width: screenwidth(context),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Videos",
                  style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: themeColor,
                  height: 3,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
