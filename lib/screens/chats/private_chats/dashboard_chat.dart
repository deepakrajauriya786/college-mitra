import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../const/config.dart';
import 'chat_screen.dart';

class DashboardChat extends StatelessWidget {
  DashboardChat({super.key});

  List<Map<String, dynamic>> contacts = [
    {
      'id': '42554543534',
      'name': 'Aditi Gupta',
      'message': 'Par bhaiya CAT is not that easy to crack...',
      'avatar': 'A',
      'unreadCount': 3,
      'lastMessageTime': '12:30 PM',
    },
    {
      'id': '4664646464',
      'name': 'ChickMagnet',
      'message': '"baby IIMs" 😅',
      'avatar': 'C',
      'unreadCount': 0,
      'lastMessageTime': '11:15 AM',
    },
    {
      'id': '46477744',
      'name': 'Ananya Pandey',
      'message': 'Hey does anyone have ideas for free mocks?',
      'avatar': 'An',
      'unreadCount': 5,
      'lastMessageTime': '10:45 AM',
    },
    {
      'id': '6865765656',
      'name': 'Arunav Ghosh',
      'message': 'Just use GPT!',
      'avatar': 'Ar',
      'unreadCount': 1,
      'lastMessageTime': '09:50 AM',
    },
    {
      'id': '87998779433534',
      'name': 'Anonymous',
      'message': 'Is there live class today in hustlers batch?',
      'avatar': 'An',
      'unreadCount': 0,
      'lastMessageTime': 'Yesterday',
    },
  ];

  Future<List<dynamic>> fetchProduct() async {
    try {
      final userId = await UID;
      final response = await http.get(Uri.parse("${BASEURL}user_list_fetch.php?u_id=$userId"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Server Error!");
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
      return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131b28),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff252d3a),
        title: const Text('Private Chats', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("We will be soon serving this area"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return
              ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final contact = snapshot.data![index];
                  final isUnread = false;

                  return ListTile(
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            contact['avatar']??'Chat',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        if (isUnread)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                contact['unreadCount'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      contact['name'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      contact['addreass'],
                      style: TextStyle(
                        color: isUnread ? Colors.white : Colors.grey,
                        fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          contact['create_date'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivateChatScreen(
                            contactName: contact['name'],
                            contactAvatar: contact['avatar']??'Chat',
                            receiverId: contact['mobile'],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
          } else {
            return const Center(child: Text('No Data Available'));
          }
        },
      ),
    );
  }
}
