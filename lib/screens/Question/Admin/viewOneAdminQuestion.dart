import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neerogi/screens/Question/Admin/viewQuestion.dart';
import 'package:neerogi/screens/Question/questionModel.dart';

import '../../../model/user_model.dart';
import '../../../utils/config.dart';

class ViewOneAdminQuestionsScreen extends StatefulWidget {
  const ViewOneAdminQuestionsScreen({Key? key, required this.id})
      : super(key: key);
  final String id;

  @override
  State<ViewOneAdminQuestionsScreen> createState() =>
      _ViewOneAdminQuestionsScreenState();
}

class _ViewOneAdminQuestionsScreenState
    extends State<ViewOneAdminQuestionsScreen> {
  Questions? oneQuestions;
  bool loading = false;

  @override
  initState() {
    super.initState();
    loading = true;

    getQuestions();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.formMap(value.data());
      setState(() {});
    });
  }

  //uploading the image , then getting the download url and then
  //adding that download url to our cloud fire store

  TextEditingController sampledata1 = new TextEditingController();

  //snackbar for  showing error
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> getQuestions() async {
    final id = widget.id;
    final reference = FirebaseFirestore.instance.doc('question/$id');
    final snapshot = reference.get();

    final result = await snapshot.then((snap) =>
        snap.data() == null ? null : Questions.fromJson(snap.data()!));
    print('result is ====> $result');
    setState(() {
      oneQuestions = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.id);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Config.app_background), fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: height * 0.2),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Admin Question",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,

                        decorationColor: Colors.redAccent,
                        // fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              SizedBox(height: 45),
              Text('Question : ' + oneQuestions!.question,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 45),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: delete,
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void delete() {
    final id = widget.id;
    FirebaseFirestore.instance.doc('question/$id').delete().whenComplete(() =>
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewQuestionScreens())));
  }

//
}
