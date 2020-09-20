import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final String email;
  SignupPage({Key key, this.email}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final confirmationController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Successfully Signup user'),
        ),
        body: Center(
          child: Image.asset('assets/poseidon.jpg'),
        ),
      ),
    );
  }
}
