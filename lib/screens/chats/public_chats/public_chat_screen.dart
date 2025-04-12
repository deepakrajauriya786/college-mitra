import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/video_player_screen.dart';

class PublicChatScreen extends StatefulWidget {
  const PublicChatScreen({super.key});

  @override
  State<PublicChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<PublicChatScreen> {
  final List<Map<String, dynamic>> dummyMessages = [
    {
      'user': 'Aditi Gupta',
      'message': 'Par bhaiya CAT is not that easy to crack plus...',
      'type': 'text',
      'avatar': 'A',
      'time': '12:45 PM'
    },
    {
      'user': 'ChickMagnet',
      'message': '"baby IIMs" 😅',
      'type': 'text',
      'avatar': 'C',
      'time': '12:47 PM'
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String message, String type) {
    if (message.isNotEmpty) {
      setState(() {
        dummyMessages.add({
          'user': 'You',
          'message': message,
          'type': type,
          'avatar': 'Y',
          'time': _getCurrentTime(),
        });
        _controller.clear();
      });
      _scrollToBottom();
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendMessage(pickedFile.path, 'image');
    }
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendMessage(pickedFile.path, 'video');
    }
  }

  void _playVideo(String videoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoPath: videoPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131b28),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff252d3a),
        title: const Flexible(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.group, color: Colors.white),
              ),
              SizedBox(width: 15),
              Text('AcelIPM: IPMAT Indore',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                final message = dummyMessages[index];
                final isMe = message['user'] == 'You';

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe)
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(
                            message['avatar']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
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
                            child: message['type'] == 'text'
                                ? Text(
                                    message['message']!,
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : message['type'] == 'image'
                                    ? Image.file(
                                        File(message['message']),
                                        fit: BoxFit.cover,
                                      )
                                    : GestureDetector(
                                        onTap: () =>
                                            _playVideo(message['message']),
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      if (isMe) const SizedBox(width: 10),
                      if (isMe)
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            message['avatar']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.black54,
            child: Row(
              children: [
                IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image, color: Colors.white),
                ),
                IconButton(
                  onPressed: _pickVideo,
                  icon: const Icon(Icons.videocam, color: Colors.white),
                ),
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
                  onPressed: () => _sendMessage(_controller.text, 'text'),
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
