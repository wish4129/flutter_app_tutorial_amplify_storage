import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  final String email;
  SigninPage({Key key, this.email}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final confirmationController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hello ${widget?.email}'),
        ),
        body: Center(
          child: Image.asset('assets/poseidon.jpg'),
        ),
      ),
    );
  }
}
