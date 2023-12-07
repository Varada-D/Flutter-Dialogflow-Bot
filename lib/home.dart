import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow_agent/chat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  // late ScrollController _scrollController;
  // bool _scrollToBottom = false;

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    // _scrollController = ScrollController();
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Row(
          children: [
            Image(
              image: AssetImage('assets/chatbot.png'),
              height: 60,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  'Diabot',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  "A Flutter Dialogflow Agent",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(21, 101, 192, 1)),
                )
              ],
            ))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Chat(messages: messages),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.deepPurple,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      onSubmitted: (value) {
                        sendMessage(value);
                        _controller.clear();
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  sendMessage(String msg) async {
    if (msg.isEmpty) {
      print("Message is Empty");
    } else {
      print(msg);
      setState(() {
        addMessage(msg, true);
      });
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: msg)));
      if (response.message == null) {
        return;
      } else {
        setState(() {
          print(response.message!.text!.text![0]);
          addMessage(response.message!.text!.text![0]);
          // _scrollToBottom = true;
          // _scrollController.animateTo(
          //   _scrollController.position.maxScrollExtent,
          //   duration: const Duration(milliseconds: 300),
          //   curve: Curves.easeOut,
          // );
        });
      }
    }
  }

  addMessage(String message, [bool isUserMessage = false]) {
    // print(message);
    messages.add({"message": message, "isUserMessage": isUserMessage});
    // print(messages);
  }
}
