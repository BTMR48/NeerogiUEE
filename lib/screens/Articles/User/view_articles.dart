import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neerogi/screens/Articles/Admin/viewOne_articles.dart';
import 'package:neerogi/screens/Articles/ArticleIntroScreen.dart';
import '../../../utils/config.dart';
import '../articlesModel.dart';
import 'package:neerogi/core/app_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#00FFFF').withOpacity(0.4),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IntroScreen()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color.fromARGB(255, 12, 63, 112),
          ),
        ),
        title: Text(
          "Articles - ලිපි",
          style: h2Style.copyWith(color: Color.fromARGB(255, 12, 63, 112)),
        ),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 12, 63, 112)),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Config.article_background),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Card(
                      color: Colors.white.withOpacity(0.5),
                      child: Column(
                        //chip words
                        children: <Widget>[
                          const SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                                width: width * 0.90,
                                height: height * 0.90,
                                child: FutureBuilder<List<Articles>>(
                                    future: fetchRecords(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        List<Articles> data =
                                            snapshot.data ?? [];

                                        return ListView.builder(
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return (SizedBox(
                                                height: 80,
                                                child: Column(
                                                  children: <Widget>[
                                                    ListTile(
                                                        leading: Image.network(
                                                          data[index].url,
                                                          height: 30,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        title: Text(
                                                            data[index].topic),
                                                        subtitle: Text(
                                                            data[index]
                                                                .description),
                                                        trailing:
                                                            ElevatedButton(
                                                          child: Text('View'),
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ViewOneArticleScreen(
                                                                              id: data[index].id,
                                                                            )));
                                                          },
                                                        ))
                                                  ],
                                                ),
                                              ));
                                            });
                                      }
                                    })),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
