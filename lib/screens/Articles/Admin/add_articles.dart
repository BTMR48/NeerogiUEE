import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddArticleScreen extends StatefulWidget {
  // the user id to create a image folder for a particular user
  String? userId;
  AddArticleScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  // initialization code
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  //image picker
  Future imagePickerMethod() async {
    //picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        //showing a snackbar with error
        showSnackBar("No file selected", Duration(milliseconds: 400));
      }
    });
  }

  //uploading the image , then getting the download url and then
  //adding that download url to our cloud fire store
  Future uploadImage() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref =
        FirebaseStorage.instance.ref().child("articles").child("post_$postID");

    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();

    //uploading to cloudfirestore
    await firebaseFirestore.collection("articles").doc().set({
      "topic": sampledata1.text,
      "description": sampledata2.text,
      'url': downloadURL
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
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              //for rounded rectange clip
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  height: 550,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("Upload Image"),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _image == null
                                      ? const Center(
                                          child: Text("No Image Selected"))
                                      : Image.file(_image!),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      imagePickerMethod();
                                    },
                                    child: Text("Select Image")),
                              ],
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
          TextField(
            controller: sampledata1,
            decoration: const InputDecoration(hintText: "name"),
          ),
          TextField(
            controller: sampledata2,
            decoration: const InputDecoration(hintText: "age"),
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
    if (_image != null) {
      uploadImage();
    } else {
      showSnackBar("Select Image first", Duration(milliseconds: 400));
    }
  }
}
