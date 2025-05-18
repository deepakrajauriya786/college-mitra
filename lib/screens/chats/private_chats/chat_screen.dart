import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../const/database.dart'; // Ensure this import is correct

class PrivateChatScreen extends StatefulWidget {
  final String contactName;
  final String contactAvatar;
  final String receiverId;
  final String message; //initial Message

  const PrivateChatScreen({
    Key? key,
    required this.contactName,
    required this.contactAvatar,
    required this.receiverId,
    required this.message,
  }) : super(key: key);

  @override
  State<PrivateChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<PrivateChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String chatId = "";
  String userId = '';

  @override
  void initState() {
    super.initState();
    initializeChat();
  }

  Future<void> initializeChat() async {
    userId = await getstring('mobile'); // Assuming this retrieves the user ID correctly
    if (userId.isEmpty) {
      print("User ID is empty!"); // Debugging
      return;
    }
print('userId $userId');
    setState(() {
      List<String> sortedIds = [userId, widget.receiverId]..sort();
      chatId = sortedIds.join("_");
    });

    //Send initial message if available.
    if (widget.message.isNotEmpty) {
      sendMessage(widget.message);
    }

    //Mark message as read when user open chat
    markMessagesAsRead();

    // Scroll to bottom initially - VERY IMPORTANT
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    try {
      DocumentReference chatRef = _firestore.collection("chats").doc(chatId);
      DocumentSnapshot chatSnap = await chatRef.get();

      if (!chatSnap.exists) {
        //If chat doesn't exist then create it
        await chatRef.set({
          "users": {userId: userId, widget.receiverId: widget.receiverId},
          "createdAt": FieldValue.serverTimestamp(),
          "lastMessage": message,
          "lastMessageTime": FieldValue.serverTimestamp(),
        });
      }

      final messageData = {
        "sender": userId,
        "text": message,
        "timestamp": FieldValue.serverTimestamp(),
        "isRead": false, // Set to false when message is sent
      };

      await chatRef.collection("messages").add(messageData);

      await chatRef.update({
        "lastMessage": message,
        "lastMessageTime": FieldValue.serverTimestamp(),
      });

      _controller.clear();
      _scrollToBottom();
    } catch (e) {
      print("Error sending message: $e");
      // Handle the error (e.g., show an error message to the user)
    }
  }

  Stream<QuerySnapshot> getMessages() {
    try {
      return _firestore
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .orderBy("timestamp",
          descending:
          false) // VERY IMPORTANT: Newest messages at the BOTTOM of the list!
          .snapshots();
    } catch (e) {
      print("Error getting messages: $e");
      return const Stream.empty(); // Or handle the error differently
    }
  }

  Future<void> markMessagesAsRead() async {
    try {
      // Filter messages that are from the other user, and are not read yet
      final messagesRef = _firestore
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .where("sender", isNotEqualTo: userId)
          .where("isRead", isEqualTo: false);

      final snapshot = await messagesRef.get();

      // Update each document that matched the query
      for (final doc in snapshot.docs) {
        await doc.reference.update({"isRead": true}); // Mark each message as read
      }
    } catch (e) {
      print("Error marking messages as read: $e");
      // Handle the error appropriately
    }
  }

  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeOut,
  //     );
  //   }
  // }
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131b28),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff252d3a),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(widget.contactAvatar,
                  style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 15),
            Text(
              widget.contactName,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text("Error loading messages: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red)));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No messages yet",
                        style: TextStyle(color: Colors.grey)),
                  );
                }

                return ListView.builder( // Use ListView.builder for efficiency
                  controller: _scrollController,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final Map<String, dynamic> data =
                    doc.data() as Map<String, dynamic>;
                    final String message = data["text"] ?? ""; // Use null-aware operator
                    final bool isMe = data["sender"] == userId;
                    final Timestamp? timestamp =
                    data["timestamp"] as Timestamp?; // Use null-aware operator
                    final DateTime dateTime =
                        timestamp?.toDate() ?? DateTime.now();
                    _scrollToBottom();

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isMe)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Text(
                                  widget.contactAvatar,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          if (!isMe) const SizedBox(width: 10),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? const Color(0xff222e3a)
                                    : const Color(0xff333e4a),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10),
                                  topRight: const Radius.circular(10),
                                  bottomLeft: Radius.circular(isMe ? 10 : 0),
                                  bottomRight: Radius.circular(isMe ? 0 : 10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    DateFormat('hh:mm a').format(dateTime),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isMe) const SizedBox(width: 10),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.black54,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onTap: _scrollToBottom,
                  ),
                ),
                IconButton(
                  onPressed: () => sendMessage(_controller.text),
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}