import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neerogi/screens/Question/questionModel.dart';

import '../../../model/user_model.dart';
import '../../home_screen.dart';

class ViewOneQuestionsScreen extends StatefulWidget {
  const ViewOneQuestionsScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ViewOneQuestionsScreen> createState() => _ViewOneQuestionsScreenState();
}

class _ViewOneQuestionsScreenState extends State<ViewOneQuestionsScreen> {
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
      body: Column(
        children: [
          Text(oneQuestions!.question,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
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

  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void send() {
    FirebaseFirestore.instance.collection("tutorialAnswers").doc().set({
      "questionAnswer": sampledata1.text,
      "question": oneQuestions!.question,
      "userID": user!.uid
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
