import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Container(),
    );
  }
}
