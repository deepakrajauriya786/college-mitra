import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // Import if not already present
import 'package:provider/provider.dart';

import '../../../const/app_sizes.dart';
import '../../../const/database.dart';

import 'chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardChat extends StatefulWidget {
  const DashboardChat({Key? key}) : super(key: key);

  @override
  State<DashboardChat> createState() => _MessageScreensState();
}

class _MessageScreensState extends State<DashboardChat> {
  List<ChatData> chats = []; // Use the ChatData model
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    getCurrentUserId();
  }

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      print("Firebase initialized successfully");
      // You can perform other Firebase related tasks here
    } catch (e) {
      print("Failed to initialize Firebase: $e");
      // Handle the error appropriately, such as displaying an error message to the user
    }
  }

  Future<void> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId =
          prefs.getString('mobile') ?? ''; // Use null-aware operator
      print('Current User ID: $currentUserId'); // Debugging
      fetchChatData();
    });
  }

  Future<void> fetchChatData() async {
    try {
      final chatsCollection = FirebaseFirestore.instance.collection('chats');

      // Query for chats ordered by lastMessageTime descending
      final querySnapshot = await chatsCollection
          .orderBy('lastMessageTime', descending: true) // Order by lastMessageTime
          .get();

      List<ChatData> fetchedChats = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        print('data 456 $data');
        // Check if the 'users' map contains the current user ID
        bool userInChat = false;
        if (data['users'] != null && data['users'] is Map) { // Check for null and type
          Map<String, dynamic> usersMap = data['users'] as Map<String, dynamic>;
          userInChat = usersMap.containsKey(currentUserId); //Check if current user is present in User map
        }

        if (userInChat) {
          fetchedChats.add(await ChatData.fromFirestore(doc,currentUserId));
        }
      }

      setState(() {
        chats = fetchedChats;
      });
    } catch (e) {
      print("Error fetching chat data: $e");
      // Handle the error appropriately
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
      body: chats.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          final isUnread = chat.unreadCount >
              0; // Use the unread count from the ChatData

          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    chat.otherUserName.substring(0, 1).toUpperCase(),
                    //chat.otherUserName[0].toUpperCase(), //chat.otherUserName.isNotEmpty ? chat.otherUserName[0].toUpperCase() : 'U',  // Assuming there's a 'name' field
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                if (chat.unreadCount > 0)
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
                        chat.unreadCount.toString(),
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
              chat.otherUserName, // chat.otherUserName,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              chat.lastMessage, // Use the last message from the ChatData
              style: TextStyle(
                color: isUnread ? Colors.white : Colors.grey,
                fontWeight:
                isUnread ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chat.lastMessageTimeFormatted,
                  //chat.lastMessageTime.toString(),  // Format the date if needed
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
                    contactName: chat.otherUserName,
                    //chat.otherUserName,
                    contactAvatar:
                    chat.otherUserName.substring(0, 1).toUpperCase(),
                    //chat.otherUserName.isNotEmpty ? chat.otherUserName[0].toUpperCase() : 'U',
                    receiverId: chat.otherUserId,
                    //chat.otherUserId,
                    message: "",
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

// Data Model
class ChatData {
  final String chatId;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageTimeFormatted;
  final int unreadCount;
  final String otherUserId;
  final String otherUserName;

  ChatData({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageTimeFormatted,
    required this.unreadCount,
    required this.otherUserId,
    required this.otherUserName,
  });

  static Future<ChatData> fromFirestore(DocumentSnapshot doc, String currentUserId) async {
    final data = doc.data() as Map<String, dynamic>;
    final chatId = doc.id;

    // Extract the other user's ID
    String otherUserId = '';
    if (data['users'] != null && data['users'] is Map) {
      Map<String, dynamic> users = data['users'] as Map<String, dynamic>;
      users.forEach((userId, value) {
        if (userId != currentUserId) {
          otherUserId = userId;
        }
      });
    }

    // Fetch the other user's name from the 'users' collection
    String otherUserName = 'Unknown';
    if (otherUserId.isNotEmpty) {
      final userQuerySnapshot = await FirebaseFirestore.instance
          .collection('messages')
          .where('sender', isEqualTo: otherUserId)
          .get();

      print('Found ${userQuerySnapshot.docs.length} messages from other user');

      if (userQuerySnapshot.docs.isNotEmpty) {
        final userData = userQuerySnapshot.docs[0].data() as Map<String, dynamic>;
        print('Fetched user data from message: $userData');
        otherUserName = userData['name'] ?? 'Unknown';
      }
    }


    print('currentUserId $otherUserId');
    print('otherUserName $otherUserName');

    // Parse last message time
    DateTime lastMessageTime;
    if (data['lastMessageTime'] is Timestamp) {
      lastMessageTime = (data['lastMessageTime'] as Timestamp).toDate();
    } else {
      lastMessageTime = DateTime.now();
    }

    // Calculate unread count
    int unreadCount = await getUnreadCount(chatId, currentUserId);
    print('Unread count: $unreadCount');

    return ChatData(
      chatId: chatId,
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime: lastMessageTime,
      lastMessageTimeFormatted: lastMessageTime.toString(),
      unreadCount: unreadCount,
      otherUserId: otherUserId,
      otherUserName: otherUserName,
    );
  }

  static Future<int> getUnreadCount(String chatId, String currentUserId) async {
    try {
      final messagesCollection = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages');

      final unreadMessagesQuery = await messagesCollection
          .where('sender', isNotEqualTo: currentUserId)
          .where('isRead', isEqualTo: false)
          .get();

      return unreadMessagesQuery.docs.length;
    } catch (e) {
      print("Error getting unread count: $e");
      return 0; // Return 0 in case of an error
    }
  }
}