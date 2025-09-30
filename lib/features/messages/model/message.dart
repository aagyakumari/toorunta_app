class Message {
  final String id;
  final String senderName;
  final String lastMessage;
  final String time;
  final String avatarText;
  final String avatarColor;
  final bool unread;

  const Message({
    required this.id,
    required this.senderName,
    required this.lastMessage,
    required this.time,
    required this.avatarText,
    required this.avatarColor,
    required this.unread,
  });

  // Sample data for demonstration
  static List<Message> sampleMessages = [
    Message(
      id: '1',
      senderName: 'John Doe',
      lastMessage: 'Is this still available?',
      time: '2:47 PM',
      avatarText: 'JD',
      avatarColor: '#4A90E2',
      unread: true,
    ),
    Message(
      id: '2',
      senderName: 'Sarah Wilson',
      lastMessage: 'Thanks for the quick response!',
      time: '1:15 PM',
      avatarText: 'SW',
      avatarColor: '#F5A623',
      unread: false,
    ),
    Message(
      id: '3',
      senderName: 'Mike Chen',
      lastMessage: 'Is the furniture still available?',
      time: '10:30 PM',
      avatarText: 'MC',
      avatarColor: '#7B61FF',
      unread: false,
    ),
    Message(
      id: '4',
      senderName: 'Emma Davis',
      lastMessage: 'Great doing business with you!',
      time: 'Yesterday',
      avatarText: 'ED',
      avatarColor: '#E74C3C',
      unread: false,
    ),
    Message(
      id: '5',
      senderName: 'Alex Rodriguez',
      lastMessage: 'When can I see the apartment?',
      time: 'Yesterday',
      avatarText: 'AR',
      avatarColor: '#9B59B6',
      unread: false,
    ),
  ];
} 