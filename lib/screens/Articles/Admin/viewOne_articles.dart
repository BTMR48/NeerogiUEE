import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neerogi/screens/Articles/Admin/view_articles.dart';

import '../../../utils/config.dart';
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Config.app_background), fit: BoxFit.fill),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  oneArticle!.topic,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    decorationColor: Colors.redAccent,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Image.network(
                  oneArticle!.url,
                  height: 350,
                  width: width * 0.8,
                ),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: Card(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.greenAccent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(oneArticle!.description,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: delete,
                    child: Text(
                      "Delete",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() {
    final id = widget.id;
    FirebaseFirestore.instance.doc('articles/$id').delete().whenComplete(() =>
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewArticlesScreens())));
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
