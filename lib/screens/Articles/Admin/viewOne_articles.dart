import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:neerogi/screens/Articles/Admin/view_articles.dart';
import '../../../core/app_style.dart';
import '../articlesModel.dart';
import 'package:neerogi/screens/Articles/ArticleIntroScreen.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#00FFFF').withOpacity(0.4),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ViewArticlesScreens()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color.fromARGB(255, 12, 63, 112),
          ),
        ),
        title: Text(
          "View one article",
          style: h2Style.copyWith(color: Color.fromARGB(255, 12, 63, 112)),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(oneArticle!.topic,
                  style: const TextStyle(
                      fontSize: 50,
                      color: Color.fromARGB(255, 12, 63, 112),
                      fontWeight: FontWeight.w500)),
                const SizedBox(
                    height: 45,
                  ),
              Image.network(
                oneArticle!.url,
                height: 350,
                fit: BoxFit.cover,
              ),
               const SizedBox(
                    height: 25,
                  ),
              Text(oneArticle!.description,
              style: const TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 12, 63, 112),
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
