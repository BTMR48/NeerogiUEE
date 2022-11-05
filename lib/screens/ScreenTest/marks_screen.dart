import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              Card()
            ],
          ),
        ),
      ),
    );
  }
}
