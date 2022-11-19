import 'dart:convert';
import 'package:arishti_chat_app/models/Message.dart';
import 'package:arishti_chat_app/providers/MessageProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController messageController = TextEditingController();
  late IO.Socket socket;

  void sendMessage(String message) {
    final messageJson = {'message': message, 'sentByMe': socket.id};
    socket.emit('message', messageJson);
  }

  void setUpSocketListner() {
    socket.on('message-recieve', (messageJson) {
      try {
        print(messageJson);

        Provider.of<MessageProvider>(context, listen: false).addNewMessage(
            Message(
                message: messageJson['message'],
                senderSocketId: messageJson['sentByMe'],
                sentAt: DateTime.now()));
        print('After provider');
      } catch (e) {
        print("Hello I am inside catch block");
        print(e);
      }
    });
  }

  Future<void> FetchData() async {
    try {
      final url = Uri.parse('http://localhost:5000');
      final response = await get(url);
      final data = jsonDecode(response.body);
      print('data fetched using nodejs api is : ${data}');
    } catch (e) {
      print('you are inside catch block : ${e}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    socket = IO.io(
        'http://localhost:5000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    setUpSocketListner();
    FetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Chat Room'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: Consumer<MessageProvider>(
                  builder: (_, provider, __) {
                    return ListView.builder(
                      itemCount: provider.messageList.length,
                      itemBuilder: (_, index) {
                        String text = provider.messageList[index].message;
                        String id = provider.messageList[index].senderSocketId;
                        return MessageItem(
                            message: text, sentByMe: id == socket.id);
                      },
                    );
                  },
                )),

            // Expanded(
            //     flex: 9,
            //     child: ListView.builder(
            //       itemCount: 10,
            //       itemBuilder: (context, index) {
            //         print("Inside builder");
            //         return MessageItem(message : 'Hello', sentByMe: true);
            //       },
            //     )),

            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                cursorColor: Colors.purple,
                style: TextStyle(color: Colors.white),
                autofocus: true,
                controller: messageController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Container(
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        onPressed: () {
                          sendMessage(messageController.text);
                          messageController.text = "";
                        },
                        icon: Icon(Icons.send, color: Colors.white),
                      ),
                    )),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  MessageItem({Key? key, required this.message, required this.sentByMe})
      : super(key: key);

  final String message;
  final bool sentByMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: sentByMe ? Colors.purple : Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text('${message}',
                style: TextStyle(
                    fontSize: 18,
                    color: sentByMe ? Colors.white : Colors.purple)),
            SizedBox(width: 5),
            Text("10:30 PM",
                style: TextStyle(
                    fontSize: 10,
                    color: (sentByMe ? Colors.white : Colors.purple)
                        .withOpacity(0.7)))
          ],
        ),
      ),
    );
  }
}
