import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter_app_tutorial_amplify_storage/signup.dart';
import 'package:flutter_app_tutorial_amplify_storage/signin.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    routes: {
      '/secondpage': (_) => SignupPage(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;
  Duration get loginTime => Duration(milliseconds: 2250);
  bool _isSignin = false;
  String email;
  // Instantiate Amplify
  Amplify amplifyInstance = Amplify();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!_amplifyConfigured) _configureAmplify();
  }

  void _configureAmplify() async {
    if (!mounted) return;

    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyStorageS3 storage = AmplifyStorageS3();
    amplifyInstance
        .addPlugin(authPlugins: [authPlugin], storagePlugins: [storage]);
    // Once Plugins are added, configure Amplify
    await amplifyInstance.configure(amplifyconfig);
    try {
      setState(() {
        _amplifyConfigured = true;
        print('amplify configured: $_amplifyConfigured');
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> _signupUser(LoginData data) async {
    Map<String, dynamic> userAttributes = {
      'email': emailController.text,
    };
    SignUpResult res = await Amplify.Auth.signUp(
        username: data.name,
        password: data.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes));
    print(res);
    if (res.isSignUpComplete) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: 'Signup successfully!',
          backgroundColor: Colors.blue,
          textColor: Colors.white);
      return null;
    }
    return 'error';
  }

  Future<String> _authUser(LoginData data) async {
    SignInResult res = await Amplify.Auth.signIn(
      username: data.name,
      password: data.password,
    );
    if (res.isSignedIn) {
      _isSignin = true;
      email = data.name;
      return null;
    }
    return 'error';
  }

  void _gotoSecondPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => _isSignin
              ? SigninPage(
                  email: email,
                )
              : SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterLogin(
        title: 'POSEIDON',
        logo: 'assets/poseidon.jpg',
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: _gotoSecondPage,
        onRecoverPassword: (_) => null,
      ),
    );
  }
}
