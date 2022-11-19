import 'package:arishti_chat_app/providers/MessageProvider.dart';
import 'package:arishti_chat_app/screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Room',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: ChangeNotifierProvider<MessageProvider>(
        create: (context) => MessageProvider(),
        child: Homepage(),
      ),
    );
  }
}
