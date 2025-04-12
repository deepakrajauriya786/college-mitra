import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widgets/video_player_screen.dart';

class PrivateChatScreen extends StatefulWidget {
  final String contactName;
  final String contactAvatar;

  const PrivateChatScreen({
    super.key,
    required this.contactName,
    required this.contactAvatar,
  });

  @override
  State<PrivateChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<PrivateChatScreen> {
  final List<Map<String, dynamic>> dummyMessages = [
    {
      'user': 'Recipient',
      'message': 'Hello! How are you?',
      'avatar': 'R',
      'time': '12:30 PM',
      'type': 'text',
    },
    {
      'user': 'You',
      'message': 'I am good, thanks for asking.',
      'avatar': 'Y',
      'time': '12:32 PM',
      'type': 'text',
    },
    {
      'user': 'Recipient',
      'message': 'Do you have the notes from class?',
      'avatar': 'R',
      'time': '12:35 PM',
      'type': 'text',
    },
    {
      'user': 'You',
      'message': 'Sure! I will share them shortly.',
      'avatar': 'Y',
      'time': '12:36 PM',
      'type': 'text',
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final currentTime = DateFormat('hh:mm a').format(DateTime.now());
      setState(() {
        dummyMessages.add({
          'user': 'You',
          'message': _controller.text,
          'avatar': 'Y',
          'time': currentTime,
          'type': 'text',
        });
        _controller.clear();
      });
      _scrollToBottom();
    }
  }

  void _sendMedia(String path, String type) {
    final currentTime = DateFormat('hh:mm a').format(DateTime.now());
    setState(() {
      dummyMessages.add({
        'user': 'You',
        'message': path,
        'avatar': 'Y',
        'time': currentTime,
        'type': type,
      });
    });
    _scrollToBottom();
  }

  Future<void> _pickMedia(ImageSource source, String type) async {
    final picker = ImagePicker();
    final pickedFile = await (type == 'image'
        ? picker.pickImage(source: source)
        : picker.pickVideo(source: source));

    if (pickedFile != null) {
      _sendMedia(pickedFile.path, type);
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
        automaticallyImplyLeading: false,
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
            child: ListView.builder(
              controller: _scrollController,
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                final message = dummyMessages[index];
                final isMe = message['user'] == 'You';

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                          child: message['type'] == 'text'
                              ? Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message['message'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      message['time'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              : message['type'] == 'image'
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Image.file(
                                              File(message['message']),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.file(
                                        File(message['message']),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerScreen(
                                              videoPath: message['message'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.play_circle_filled,
                                        color: Colors.blue,
                                        size: 50,
                                      ),
                                    ),
                        ),
                      ),
                      if (isMe) const SizedBox(width: 10),
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
                  onPressed: () => _pickMedia(ImageSource.gallery, 'image'),
                  icon: const Icon(Icons.image, color: Colors.white),
                ),
                IconButton(
                  onPressed: () => _pickMedia(ImageSource.gallery, 'video'),
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
