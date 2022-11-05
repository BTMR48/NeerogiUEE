import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Parent/viewOneQuestion.dart';
import '../questionModel.dart';

class ViewQuestionScreens extends StatefulWidget {
  const ViewQuestionScreens({Key? key}) : super(key: key);

  @override
  State<ViewQuestionScreens> createState() => _ViewQuestionScreensState();
}

class _ViewQuestionScreensState extends State<ViewQuestionScreens> {
  @override
  Future<List<Questions>> fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('question').get();
    return mapRecords(records);
  }

  List<Questions> mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (questions) => Questions(
            id: questions.id,
            question: questions['question'],
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
                    child: FutureBuilder<List<Questions>>(
                        future: fetchRecords(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Questions> data = snapshot.data ?? [];

                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return (SizedBox(
                                    height: 100,
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                            title: Text(data[index].question),
                                            trailing: ElevatedButton(
                                              child: Text('View'),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewOneQuestionsScreen(
                                                              id: data[index]
                                                                  .id,
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
