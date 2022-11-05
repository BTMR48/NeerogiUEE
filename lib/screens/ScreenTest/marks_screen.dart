import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/config.dart';

class MarksScreen extends StatefulWidget {
  final int marks;

  MarksScreen({Key? key, required this.marks}) : super(key: key);

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(widget.marks);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Config.app_background), fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Column(
            children: [
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
              Card(
                margin: const EdgeInsets.only(top: 0, right: 10, left: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                shadowColor: Colors.white,
                color: HexColor('#FFFBFB').withOpacity(0.7),
                child: SizedBox(
                  height: height * 0.82,
                  width: (MediaQuery.of(context).size.width),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 5, right: 20, left: 0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical, //.horizontal
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 10, left: 10),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'නිරෝගී',
                                      style: TextStyle(
                                        color: HexColor('#1F1010'),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'මුලු ලකුණූ',
                                          style: TextStyle(
                                            color: HexColor('#1F1010'),
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Card(
                                            color: Colors.greenAccent,
                                            child: Center(
                                              child: Text(
                                                widget.marks.toString(),
                                                style: TextStyle(
                                                  color: HexColor('#1F1010'),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: result(),
                                        )
                                      ],
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

  result() {
    if (widget.marks >= 3) {}
  }
}
