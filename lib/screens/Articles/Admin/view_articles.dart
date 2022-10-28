import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neerogi/screens/Articles/Admin/viewOne_articles.dart';

import '../articlesModel.dart';

class ViewArticlesScreens extends StatefulWidget {
  const ViewArticlesScreens({Key? key}) : super(key: key);

  @override
  State<ViewArticlesScreens> createState() => _ViewArticlesScreensState();
}

class _ViewArticlesScreensState extends State<ViewArticlesScreens> {
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
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              //chip words
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                    width: width * 0.94,
                    height: height * 0.90,
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
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                            leading: Image.network(
                                              data[index].url,
                                              height: 30,
                                              fit: BoxFit.cover,
                                            ),
                                            title: Text(data[index].topic),
                                            subtitle:
                                                Text(data[index].description),
                                            trailing: ElevatedButton(
                                              child: Text('View'),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewOneArticleScreen(
                                                                // id: article.id,
                                                                )));
                                              },
                                            ))
                                      ],
                                    ),
                                  ));
                                });
                          }
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
