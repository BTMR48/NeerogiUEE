import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/config.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Config.app_background),
          fit: BoxFit.fill,
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: height * 0.2),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Admin Add Questions",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,

                            decorationColor: Colors.redAccent,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.1),
                    child: SizedBox(
                      width: width * 0.9,
                      child: TextField(
                        controller: sampledata1,
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Add Questions',
                          hintText: 'New question',
                          prefixIcon: Icon(Icons.favorite),
                          suffixIcon: Icon(Icons.query_builder),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 150, bottom: height * 0.31),
                    child: ElevatedButton(
                      onPressed: () {
                        send();
                      },
                      child: Text("Add Question"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void send() {
    uploadImage();
  }
}
