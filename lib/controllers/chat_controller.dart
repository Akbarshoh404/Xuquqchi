import 'package:flutter/material.dart';

enum MessageType { text, image, audio, document }

enum MessageStatus { sent, delivered, read }

class ChatMessage {
  final String id;
  final String text;
  final bool isSent;
  final DateTime time;
  final MessageType type;
  final MessageStatus status;
  final List<String>? imageUrls;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isSent,
    required this.time,
    this.type = MessageType.text,
    this.status = MessageStatus.read,
    this.imageUrls,
  });
}

class ChatSession {
  final String id;
  final String doctorName;
  final String doctorImage;
  final String lastMessage;
  final DateTime lastTime;
  final bool hasUnread;

  ChatSession({
    required this.id,
    required this.doctorName,
    required this.doctorImage,
    required this.lastMessage,
    required this.lastTime,
    this.hasUnread = false,
  });
}

class ChatController extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  bool _showAttachmentMenu = false;
  bool _showMoreMenu = false;

  bool get showAttachmentMenu => _showAttachmentMenu;
  bool get showMoreMenu => _showMoreMenu;

  // Demo messages matching the designs
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Hi, good afternoon Dr. Drake... 😁😁',
      isSent: true,
      time: DateTime(2022, 12, 20, 16, 0),
      status: MessageStatus.read,
    ),
    ChatMessage(
      id: '2',
      text: "I'm Andrew, I have a problem with my immune system 🤧",
      isSent: true,
      time: DateTime(2022, 12, 20, 16, 0),
      status: MessageStatus.read,
    ),
    ChatMessage(
      id: '3',
      text: 'Hello, good afternoon too Andrew 😊',
      isSent: false,
      time: DateTime(2022, 12, 20, 16, 1),
    ),
    ChatMessage(
      id: '4',
      text: 'Can you tell me the problem you are having? So that I can identify it.',
      isSent: false,
      time: DateTime(2022, 12, 20, 16, 1),
    ),
    ChatMessage(
      id: '5',
      text: 'Recently I often feel unwell. I also sometimes experience pain in the legs, and I don\'t know why 😰😰 Do you know anything doc?',
      isSent: true,
      time: DateTime(2022, 12, 20, 16, 2),
      status: MessageStatus.read,
    ),
    ChatMessage(
      id: '6',
      text: '',
      isSent: true,
      time: DateTime(2022, 12, 20, 16, 2),
      type: MessageType.image,
      imageUrls: [
        'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
        'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=200',
      ],
    ),
    ChatMessage(
      id: '7',
      text: '',
      isSent: true,
      time: DateTime(2022, 12, 20, 16, 3),
      type: MessageType.audio,
      status: MessageStatus.read,
    ),
    ChatMessage(
      id: '8',
      text: "I'm seeing signs that what you're experiencing is actually because you've been working too much.",
      isSent: false,
      time: DateTime(2022, 12, 20, 16, 29),
    ),
    ChatMessage(
      id: '9',
      text: 'My advice is that you eat healthy food, sleep early and enough, & you can also try to exercise 2 times a week. 😊',
      isSent: false,
      time: DateTime(2022, 12, 20, 16, 29),
    ),
    ChatMessage(
      id: '10',
      text: 'Thank you very much doctor for the advice and solutions you provide. I\'ll try it from today 👍👍',
      isSent: true,
      time: DateTime(2022, 12, 20, 16, 29),
      status: MessageStatus.read,
    ),
    ChatMessage(
      id: '11',
      text: 'I will contact you again in 2 weeks! Thank you very much! 😊',
      isSent: true,
      time: DateTime(2022, 12, 20, 16, 30),
      status: MessageStatus.read,
    ),
    ChatMessage(
      id: '12',
      text: 'My pleasure. All the best for you Andrew! 🔥🔥',
      isSent: false,
      time: DateTime(2022, 12, 20, 16, 30),
    ),
  ];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  // Chat history sessions
  final List<ChatSession> sessions = [
    ChatSession(id: '1', doctorName: 'Dr. Drake Boeson', doctorImage: '', lastMessage: 'My pleasure. All the best for ...', lastTime: DateTime.now()),
    ChatSession(id: '2', doctorName: 'Dr. Aidan Allende', doctorImage: '', lastMessage: 'Your solution is great! 🔥🔥', lastTime: DateTime.now().subtract(const Duration(days: 1))),
    ChatSession(id: '3', doctorName: 'Dr. Salvatore Heredia', doctorImage: '', lastMessage: 'Thanks for the help doctor 🙏', lastTime: DateTime(2022, 12, 20, 10, 30)),
    ChatSession(id: '4', doctorName: 'Dr. Delaney Mangino', doctorImage: '', lastMessage: 'I have recovered, thank you v...', lastTime: DateTime(2022, 12, 14, 17, 0)),
    ChatSession(id: '5', doctorName: 'Dr. Beckett Calger', doctorImage: '', lastMessage: 'I went there yesterday 😊', lastTime: DateTime(2022, 11, 26, 9, 30)),
    ChatSession(id: '6', doctorName: 'Dr. Bernard Bliss', doctorImage: '', lastMessage: 'IDK what else is there to do ...', lastTime: DateTime(2022, 11, 9, 10, 0)),
    ChatSession(id: '7', doctorName: 'Dr. Jada Srnsky', doctorImage: '', lastMessage: 'I advise you to take a break 🛌', lastTime: DateTime(2022, 10, 18, 15, 30)),
    ChatSession(id: '8', doctorName: 'Dr. Randy Wigham', doctorImage: '', lastMessage: 'Yeah! You\'re right. 💯💯', lastTime: DateTime(2022, 10, 7, 10, 0)),
  ];

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    _messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isSent: true,
      time: DateTime.now(),
      status: MessageStatus.sent,
    ));
    messageController.clear();
    notifyListeners();
  }

  void toggleAttachmentMenu() {
    _showAttachmentMenu = !_showAttachmentMenu;
    if (_showAttachmentMenu) _showMoreMenu = false;
    notifyListeners();
  }

  void toggleMoreMenu() {
    _showMoreMenu = !_showMoreMenu;
    if (_showMoreMenu) _showAttachmentMenu = false;
    notifyListeners();
  }

  void closeMenus() {
    _showAttachmentMenu = false;
    _showMoreMenu = false;
    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    _showMoreMenu = false;
    notifyListeners();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
