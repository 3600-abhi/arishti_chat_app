import 'package:arishti_chat_app/providers/HomepageProvider.dart';
import 'package:arishti_chat_app/providers/LoginProvider.dart';
import 'package:arishti_chat_app/screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();

  void handleBottonClick(String name) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    if (name == '') {
      provider.setErrorMessage('Please Enter your name');
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<HomepageProvider>(
                  create: (context) => HomepageProvider(), child: Homepage(name: name))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Consumer<LoginProvider>(
                  builder: (context, provider, child) {
                    return Text(provider.errorMessage, style: TextStyle(color: Colors.red));
                  },
                ),

                SizedBox(height: 20),

                Container(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 150,
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Enter Chat Room'),
                  onPressed: () {
                    handleBottonClick(nameController.text.trim());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
