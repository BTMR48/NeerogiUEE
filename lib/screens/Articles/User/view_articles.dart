import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neerogi/screens/Articles/User/viewOne_articles.dart';

import '../../../utils/config.dart';
import '../articlesModel.dart';

class ViewUserArticlesScreens extends StatefulWidget {
  const ViewUserArticlesScreens({Key? key}) : super(key: key);

  @override
  State<ViewUserArticlesScreens> createState() =>
      _ViewUserArticlesScreensState();
}

class _ViewUserArticlesScreensState extends State<ViewUserArticlesScreens> {
  @override
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Config.article_background), fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    "Articles",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,

                      decorationColor: Colors.redAccent,
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          leading: GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: width * 0.94,
                      height: height * 0.95,
                      child: FutureBuilder<List<Articles>>(
                          future: fetchRecords(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<Articles> data = snapshot.data ?? [];

                              return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return (SizedBox(
                                      height: 100,
                                      child: Card(
                                        color: Colors.white.withOpacity(0.8),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.greenAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                                leading: Image.network(
                                                  data[index].url,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                                title: Text(data[index].topic),
                                                subtitle: Text(
                                                    data[index].description),
                                                trailing: ElevatedButton(
                                                  child: Text('View'),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewOneUserArticleScreen(
                                                                  id: data[
                                                                          index]
                                                                      .id,
                                                                )));
                                                  },
                                                ))
                                          ],
                                        ),
                                      ),
                                    ));
                                  });
                            }
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
