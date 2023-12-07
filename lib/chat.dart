import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final List messages;
  const Chat({super.key, required this.messages});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        if (widget.messages[index]['isUserMessage']) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(20),
                      // color: Colors.deepPurple,
                    ),
                    color: Colors.deepPurple,
                  ),
                  constraints: BoxConstraints(maxWidth: width * 2 / 3),
                  child: Text(
                    widget.messages[index]['message'],
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(0),
                    ),
                    color: Color.fromRGBO(100, 181, 246, 1),
                  ),
                  constraints: BoxConstraints(maxWidth: width * 2 / 3),
                  child: Text(
                    widget.messages[index]['message'],
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
