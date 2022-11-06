import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../core/res/color.dart';
import '../utils/config.dart';
import '../widgets/task_group.dart';
import 'Articles/ArticleIntroScreen.dart';
import 'Doctor/User/view_user_doctors.dart';
import 'Question/Parent/viewuserQuestion.dart';
import 'ScreenTest/screenTest_screen.dart';
import 'login.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      extendBody: true,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Config.app_background2), fit: BoxFit.fill),
          ),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              _buildBody(),
            ],
          )),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _taskHeader(),
                const SizedBox(
                  height: 15,
                ),
                buildGrid(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _onGoingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "On Going",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Text(
            "See all",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Row _taskHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          "Welcome to Neerogi",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        // IconButton(
        //     onPressed: () {
        //
        //     },
        //     icon: Icon(
        //       Icons.add_circle_outline,
        //       color: Colors.blue[400],
        //     ))
      ],
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: <Widget>[
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewUserDoctorsScreens()));
            },
            child: TaskGroupContainer(
              color: Colors.pink,
              icon: Icons.medical_information_rounded,
              taskCount: 10,
              taskGroup: "Doctors",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewUserQuestionScreens()));
            },
            child: const TaskGroupContainer(
              color: Colors.orange,
              isSmall: true,
              icon: Icons.question_answer,
              taskCount: 5,
              taskGroup: " Questions",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IntroScreen()));
            },
            child: TaskGroupContainer(
              color: Colors.green,
              icon: Icons.article,
              taskCount: 2,
              taskGroup: "Articles",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScreenTestScreen()));
            },
            child: const TaskGroupContainer(
              color: Colors.blue,
              isSmall: true,
              icon: Icons.pending_actions_rounded,
              taskCount: 9,
              taskGroup: "Screen Test",
            ),
          ),
        ),
      ],
    );
  }

  _appBar() {
    //getting the size of app bar
    // get height
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
        child: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        preferredSize: Size.fromHeight(appBarHeight));
  }
}
