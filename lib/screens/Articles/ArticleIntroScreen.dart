import 'package:flutter/material.dart';
import 'package:neerogi/core/app_style.dart';
import 'package:neerogi/screens/Articles/User/view_articles.dart';

import '../../../utils/config.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget introButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ViewUserArticlesScreens()),
              );
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                const EdgeInsets.all(8),
              ),
              backgroundColor:
                  MaterialStateProperty.all(Colors.blueAccent.withOpacity(0.6)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            icon: CircleAvatar(
              backgroundColor:
                  Color.fromARGB(255, 39, 76, 140).withOpacity(0.4),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            label: Text(
              "ලිපි",
              style: h3Style.copyWith(color: Color.fromARGB(179, 27, 5, 84)),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Config.article_background),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 1),
                Text(
                  "ඔටිසම් පිළිබඳ දෙමව්පියන් ගේ දැනුම වර්ධනය",
                  style:
                      h1Style.copyWith(color: Color.fromARGB(255, 11, 11, 11)),
                ),
                const SizedBox(height: 35),
                Text(
                  "ඔටිසම් සහිත දරුවන් සිටින  දෙමාපියන්ට ඔටිසම් පිළිබඳව නිසි අවබෝධයක් තිබිය යුතුය.ලාංකික දෙමාපියන්ගෙ ඔටිසම් පිළිබදව දැනුම වර්ධනය කිරීම සඳහා ලිපි මාලාවක් මෙහි අන්තර්ගත වේ",
                  style:
                      h3Style.copyWith(color: Color.fromARGB(255, 10, 10, 10)),
                ),
                const SizedBox(height: 40),
                introButton(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
