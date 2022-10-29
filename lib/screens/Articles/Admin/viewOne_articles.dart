import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewOneArticleScreen extends StatefulWidget {
  const ViewOneArticleScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ViewOneArticleScreen> createState() => _ViewOneArticleScreenState();
}

class _ViewOneArticleScreenState extends State<ViewOneArticleScreen> {
  // // Articles OneArticle = Articles();
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("articles")
  //       .doc(id)
  //       .get()
  //       .then((value) {
  //     OneArticle = Articles.formMap(value.data());
  //     setState(() {});
  //   });

  @override
  Widget build(BuildContext context) {
    // print(widget.id);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          // Image.network(
          //   OneArticle.url,
          //   height: 30,
          //   fit: BoxFit.cover,
          // ),
          // Text(OneArticle.topic,
          //     style: const TextStyle(
          //         fontSize: 20,
          //         color: Colors.black54,
          //         fontWeight: FontWeight.w500)),
          // Text(OneArticle.description,
          //     style: const TextStyle(
          //         fontSize: 20,
          //         color: Colors.black54,
          //         fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
