import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../articlesModel.dart';

class ViewOneArticleScreen extends StatefulWidget {
  const ViewOneArticleScreen({Key? key}) : super(key: key);

  @override
  State<ViewOneArticleScreen> createState() => _ViewOneArticleScreenState();
}

class _ViewOneArticleScreenState extends State<ViewOneArticleScreen> {
  Future<List<Articles>> fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('articles').get();
    return mapRecords(records);
  }

  List<Articles> mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (article) => Articles(
            id: article.id,
            topic: article['topic'],
            description: article['description'],
            url: article['url'],
          ),
        )
        .toList();

    return _list;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          // Image.network(
          //   data[index].url,
          //   height: 30,
          //   fit: BoxFit.cover,
          // ),
          // Text($topic),
          // Text($description),
        ],
      ),
    );
  }
}
