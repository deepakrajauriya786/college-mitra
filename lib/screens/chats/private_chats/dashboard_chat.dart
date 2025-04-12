import 'package:flutter/material.dart';

import 'chat_screen.dart';

class DashboardChat extends StatelessWidget {
  DashboardChat({super.key});

  final List<Map<String, dynamic>> contacts = [
    {
      'name': 'Aditi Gupta',
      'message': 'Par bhaiya CAT is not that easy to crack...',
      'avatar': 'A',
      'unreadCount': 3,
      'lastMessageTime': '12:30 PM',
    },
    {
      'name': 'ChickMagnet',
      'message': '"baby IIMs" 😅',
      'avatar': 'C',
      'unreadCount': 0,
      'lastMessageTime': '11:15 AM',
    },
    {
      'name': 'Ananya Pandey',
      'message': 'Hey does anyone have ideas for free mocks?',
      'avatar': 'An',
      'unreadCount': 5,
      'lastMessageTime': '10:45 AM',
    },
    {
      'name': 'Arunav Ghosh',
      'message': 'Just use GPT!',
      'avatar': 'Ar',
      'unreadCount': 1,
      'lastMessageTime': '09:50 AM',
    },
    {
      'name': 'Anonymous',
      'message': 'Is there live class today in hustlers batch?',
      'avatar': 'An',
      'unreadCount': 0,
      'lastMessageTime': 'Yesterday',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131b28),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff252d3a),
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final isUnread = contact['unreadCount'] > 0;

          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    contact['avatar']!,
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
              contact['name']!,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              contact['message']!,
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
                  contact['lastMessageTime']!,
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
                    contactName: contact['name']!,
                    contactAvatar: contact['avatar']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
