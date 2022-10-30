import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../articlesModel.dart';

class ViewOneArticleScreen extends StatefulWidget {
  const ViewOneArticleScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ViewOneArticleScreen> createState() => _ViewOneArticleScreenState();
}

class _ViewOneArticleScreenState extends State<ViewOneArticleScreen> {
  Articles? oneArticle;
  bool loading = false;

  @override
  initState() {
    super.initState();
    loading = true;
    getArticle();
  }

  Future<void> getArticle() async {
    final id = widget.id;
    final reference = FirebaseFirestore.instance.doc('articles/$id');
    final snapshot = reference.get();

    final result = await snapshot.then(
        (snap) => snap.data() == null ? null : Articles.fromJson(snap.data()!));
    print('result is ====> $result');
    setState(() {
      oneArticle = result;
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
          Image.network(
            oneArticle!.url,
            height: 30,
            fit: BoxFit.cover,
          ),
          Text(oneArticle!.topic,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
          Text(oneArticle!.description,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
