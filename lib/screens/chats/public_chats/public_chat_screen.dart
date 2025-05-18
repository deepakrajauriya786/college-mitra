import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../private_chats/chat_screen.dart';
import '../widgets/video_player_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../const/database.dart';

class PublicChatScreen extends StatefulWidget {
  const PublicChatScreen({super.key});

  @override
  State<PublicChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<PublicChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = "";
  String userId = '';

  @override
  void initState() {
    super.initState();
    initializeChat();
  }

  Future<void> initializeChat() async {
    userId = await getstring('mobile');
    name = await getstring(USER_NAME);
    print("namename $userId");
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': _controller.text,
        'sender': userId ?? 'Anonymous',
        'name': name ?? 'Anonymous',
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131b28),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        // Set back button/icon color

        backgroundColor: const Color(0xff252d3a),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.group, color: Colors.white),
            ),
            SizedBox(width: 15),
            Text('Public Chat',
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final text = message['text'];
                    final sender = message['sender'];
                    final name = message['name'];
                    final isMe = sender == userId;
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
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xff222e3a),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10),
                                  topRight: const Radius.circular(10),
                                  bottomLeft: Radius.circular(isMe ? 10 : 0),
                                  bottomRight: Radius.circular(isMe ? 0 : 10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isMe)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PrivateChatScreen(
                                              contactName: name,
                                              contactAvatar:
                                                  'Chat',
                                              receiverId: sender,
                                                  message: '',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  if (!isMe) const SizedBox(height: 5),
                                  Text(
                                    text,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isMe) const SizedBox(width: 10),
                          if (isMe)
                            const CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
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
                  onPressed: _sendMessage,
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
