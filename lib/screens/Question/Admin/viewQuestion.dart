import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/config.dart';
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Config.app_background), fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    "Questions",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,

                      decorationColor: Colors.redAccent,
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      width: width * 0.94,
                      height: height * 0.95,
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
                                                title:
                                                    Text(data[index].question),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: ElevatedButton(
                                                    child: Text('View'),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewOneQuestionsScreen(
                                                                    id: data[
                                                                            index]
                                                                        .id,
                                                                  )));
                                                    },
                                                  ),
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
