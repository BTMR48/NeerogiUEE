import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddQuestionScreen extends StatefulWidget {
  // the user id to create a image folder for a particular user
  String? userId;
  AddQuestionScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  //uploading the image , then getting the download url and then
  //adding that download url to our cloud fire store
  Future uploadImage() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    //uploading to cloudfirestore
    await firebaseFirestore.collection("question").doc().set({
      "question": sampledata1.text,
    }).whenComplete(
        () => showSnackBar("Image uploaded successful", Duration(seconds: 2)));
  }

  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  //snackbar for  showing error
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: sampledata1,
            decoration: const InputDecoration(hintText: "question"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              send();
            },
            child: const Text("submit"),
          ),
        ],
      ),
    );
  }

  void send() {
    uploadImage();
  }
}
