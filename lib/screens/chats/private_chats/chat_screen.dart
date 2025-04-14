import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../const/database.dart';

class PrivateChatScreen extends StatefulWidget {
  final String contactName;
  final String contactAvatar;
  final String receiverId;

  const PrivateChatScreen({
    super.key,
    required this.contactName,
    required this.contactAvatar,
    required this.receiverId,
  });

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
    userId = await getstring(USER_NUMBER);
    setState(() {
      // userId = "$userId";
      List<String> sortedIds = [userId, widget.receiverId]..sort();
      chatId = sortedIds.join("_");
    });
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    DocumentReference chatRef = _firestore.collection("chats").doc(chatId);
    DocumentSnapshot chatSnap = await chatRef.get();
    if (!chatSnap.exists) {
      await chatRef.set({
        "users": [userId, widget.receiverId],
        "createdAt": FieldValue.serverTimestamp(),
        "lastMessage": message,
        "lastMessageTime": FieldValue.serverTimestamp(),
      });
    }

    await chatRef.collection("messages").add({
      "sender": userId,
      "text": message,
      "timestamp": FieldValue.serverTimestamp(),
    });

    await chatRef.update({
      "lastMessage": message,
      "lastMessageTime": FieldValue.serverTimestamp(),
    });

    _controller.clear();
    _scrollToBottom;
  }

  Stream<QuerySnapshot> getMessages() {
    return _firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

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
        iconTheme: const IconThemeData(color: Colors.white), // Set back button/icon color

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
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No messages yet",
                        style: TextStyle(color: Colors.grey)),
                  );
                }
                return ListView(
                  controller: _scrollController,
                  children: snapshot.data!.docs.map((doc) {
                    final String message = doc["text"];
                    final bool isMe = doc["sender"] == userId;
                    _scrollToBottom();
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isMe)
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(
                                widget.contactAvatar,
                                style: const TextStyle(color: Colors.white),
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
                                    DateFormat('hh:mm a').format(
                                      (doc["timestamp"] as Timestamp?)
                                          ?.toDate() ??
                                          DateTime.now(),
                                    ),
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
                  }).toList(),
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