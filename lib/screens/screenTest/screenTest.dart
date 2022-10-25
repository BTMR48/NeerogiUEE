import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenTestScreen extends StatefulWidget {
  const ScreenTestScreen({Key? key}) : super(key: key);

  @override
  State<ScreenTestScreen> createState() => _ScreenTestScreenState();
}

class _ScreenTestScreenState extends State<ScreenTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("sdfsafsdfsdx"),
        ),
      ),
    );
  }
}
