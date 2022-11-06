import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neerogi/screens/Doctor/Admin/viewOne_doctor.dart';

import '../../../utils/config.dart';
import '../doctorsModel.dart';

class ViewUserDoctorsScreens extends StatefulWidget {
  const ViewUserDoctorsScreens({Key? key}) : super(key: key);

  @override
  State<ViewUserDoctorsScreens> createState() => _ViewUserDoctorsScreensState();
}

class _ViewUserDoctorsScreensState extends State<ViewUserDoctorsScreens> {
  @override
  Future<List<Doctors>> fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('doctors').get();
    return mapRecords(records);
  }

  List<Doctors> mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (doctors) => Doctors(
            id: doctors.id,
            topic: doctors['topic'],
            description: doctors['description'],
            url: doctors['url'],
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
                  const SizedBox(height: 10),
                  const Text(
                    "Doctors",
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
                      child: FutureBuilder<List<Doctors>>(
                          future: fetchRecords(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<Doctors> data = snapshot.data ?? [];

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
                                                                ViewOneDoctorsScreen(
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
