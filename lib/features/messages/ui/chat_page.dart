import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/main_scaffold.dart';
import 'package:toorunta_mobile/features/messages/model/message.dart';

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
  });
}

class ChatPage extends StatefulWidget {
  final Message contact;

  const ChatPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hey! Are you still selling the bike?",
      isSentByMe: false,
      time: "2:30 PM",
    ),
    ChatMessage(
      text: "Yes, it's still available! When would you like to see it?",
      isSentByMe: true,
      time: "2:35 PM",
    ),
    ChatMessage(
      text: "How about Saturday at 2 PM?",
      isSentByMe: false,
      time: "2:40 PM",
    ),
    ChatMessage(
      text: "Perfect! 2 PM on Saturday works perfectly for me. I'll send you the address.",
      isSentByMe: true,
      time: "2:47 PM",
    ),
  ];

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isSentByMe) 
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFF0F0F0),
            ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: message.isSentByMe
                      ? const Color(0xFFFFB200)
                      : const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.isSentByMe ? Colors.white : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message.time,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (message.isSentByMe) const SizedBox(width: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: _getColorFromHex(widget.contact.avatarColor),
              child: Text(
                widget.contact.avatarText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contact.senderName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Online',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.image_outlined),
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.emoji_emotions_outlined),
                            color: Colors.grey,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB200),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
} 