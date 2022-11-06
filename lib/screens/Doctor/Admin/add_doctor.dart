import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neerogi/core/app_style.dart';
import 'package:neerogi/screens/Doctor/Admin/view_doctors.dart';

import '../../../utils/config.dart';

class AddDoctorsScreen extends StatefulWidget {
  // the user id to create a image folder for a particular user
  String? userId;
  AddDoctorsScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<AddDoctorsScreen> createState() => _AddDoctorsScreenState();
}

class _AddDoctorsScreenState extends State<AddDoctorsScreen> {
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
        FirebaseStorage.instance.ref().child("doctors").child("post_$postID");

    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();

    //uploading to cloudfirestore
    await firebaseFirestore.collection("doctors").doc().set({
      "topic": sampledata1.text,
      "description": sampledata2.text,
      'url': downloadURL
    }).whenComplete(
        () => showSnackBar("Doctor added successful", Duration(seconds: 2)));
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
    Widget introButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton(
            onPressed: () {
              send();
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                const EdgeInsets.all(15),
              ),
              backgroundColor:
                  MaterialStateProperty.all(Colors.blueAccent.withOpacity(0.4)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(179, 27, 5, 84),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#00FFFF').withOpacity(0.4),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ViewDoctorsScreens()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color.fromARGB(255, 12, 63, 112),
          ),
        ),
        title: Text(
          "Add Doctor",
          style: h2Style.copyWith(color: Color.fromARGB(255, 12, 63, 112)),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(Config.app_background),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  //for rounded rectange clip
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      height: 450,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(
                          child: Column(
                            children: [
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
                                      labelText: 'Add Doctor Name',
                                      hintText: 'Doctor Name',
                                      prefixIcon: Icon(Icons.favorite),
                                      suffixIcon: Icon(Icons.query_builder),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.1),
                                child: SizedBox(
                                  width: width * 0.9,
                                  child: TextField(
                                    controller: sampledata2,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      labelText: 'Add Description',
                                      hintText: 'New Description',
                                      prefixIcon: Icon(Icons.favorite),
                                      suffixIcon: Icon(Icons.query_builder),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: 320,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 3, 35, 91))),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              imagePickerMethod();
                                            },
                                            child: Text("Select Image",
                                                style: h3Style.copyWith(
                                                    color: Color.fromARGB(
                                                        255, 223, 221, 220)))),
                                        Expanded(
                                          child: _image == null
                                              ? const Center(child: Text(""))
                                              : Image.file(_image!),
                                        ),
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
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              introButton()
            ],
          ),
        ),
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
