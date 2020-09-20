import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/poseidon.jpg')),
        ),
        floatingActionButton: _fabUploadImage(),
      ),
    );
  }

  FloatingActionButton _fabUploadImage() {
    return FloatingActionButton(
      onPressed: _uploadImage,
      tooltip: 'Upload Audio',
      child: Icon(Icons.cloud_upload),
    );
  }

  _uploadImage() async {
    final path = await getImage();
    final key = 'poseidon.jpg';
    S3UploadFileOptions options =
        S3UploadFileOptions(accessLevel: StorageAccessLevel.guest);
    UploadFileResult result = await Amplify.Storage.uploadFile(
        key: key, local: File(path), options: options);
    print(result);
  }

  Future<String> getImage() async {
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
    return file.path;
  }

  showToast() async {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_SHORT,
        msg: 'Signup successfully!',
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }
}
