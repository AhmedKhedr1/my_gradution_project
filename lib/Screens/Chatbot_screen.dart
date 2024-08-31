import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:my_gradution_project/constns.dart';

class cahtbot_screen extends StatefulWidget {
  const cahtbot_screen({super.key});

  static String id = 'Chatbot_screen';

  @override
  State<cahtbot_screen> createState() => _cahtbot_screenState();
}

class _cahtbot_screenState extends State<cahtbot_screen> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
      id: "1", firstName: "Gemini", profileImage: 'assets/caht_icon.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Chat Bot',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildui(),
    );
  }

  Widget _buildui() {
    return DashChat(
      inputOptions: InputOptions(),
        currentUser: currentUser, onSend: sendMessage, messages: messages);
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastmessage = messages.firstOrNull;
        if (lastmessage != null && lastmessage.user == geminiUser) {
          lastmessage =messages.removeAt(0);
          String response = event.content?.parts
                  ?.fold("", (previous, current) => "$previous ${current.text}") ??
              "";
              lastmessage.text +=response;
              setState(() {
                messages=[lastmessage!,...messages];
              });
        } else {
          String response = event.content?.parts
                  ?.fold("", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
              setState(() {
                messages=[message, ...messages];
              });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
