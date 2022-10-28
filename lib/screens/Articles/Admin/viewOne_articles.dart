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
  Future async {
  await FirebaseFirestore.instance.collection('articles').doc(id).get();

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            data[index].url,
            height: 30,
            fit: BoxFit.cover,
          ),
          Text($topic),
          Text($description),
        ],
      ),
    );
  }
}
