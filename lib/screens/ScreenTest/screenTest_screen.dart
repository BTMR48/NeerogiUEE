import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';
import '../../utils/config.dart';
import 'marks_screen.dart';

class ScreenTestScreen extends StatefulWidget {
  const ScreenTestScreen({Key? key}) : super(key: key);

  @override
  State<ScreenTestScreen> createState() => _ScreenTestScreenState();
}

class _ScreenTestScreenState extends State<ScreenTestScreen> {
  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // dropdown buttons

  @override
  void initState() {
    super.initState();
    dropdownValueMembers = items.first;
    dropdownValueNumber = number.first;
    dropdownValueEducationM = educationM.first;
    dropdownValueEducationF = educationF.first;
    dropdownValueIncome = income.first;
    checkValueMembers();
    checkValueNumber();
    checkValueEducationM();
    checkValueEducationF();
    checkValueIncome();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.formMap(value.data());
      setState(() {});
    });
  }

/////////////////////////1st//////////////////////////
  // pawle daruwan keeyada
  // Initial Selected Value  Members
  // List of items in our dropdown menu
  String? dropdownValueMembers;
  List<String> items = [
    'කීයක්',
    '1 ක්',
    '2 ක්',
    '3 ක්	',
    '4 ක්	',
    '5ක් හෝ වැඩි'
  ];

  checkValueMembers() {
    _getData();
  }

  _saveData(String dropdownValueMembersShared) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data", dropdownValueMembersShared);
  }

  _getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dropdownValueMembers = sharedPreferences.getString("data") ?? items.first;
    setState(() {});
  }

  // 2nd dropdown button
  // data which child
  String? dropdownValueNumber;

//   // List of items in our dropdown menu
  List<String> number = ['බලනවාද?', 'ඔව්', 'නෑ'];

  //IF "dropdownValueMembers" is empty pass "which" word as a initial value if al ready selected then pass the shared preference value
  checkValueNumber() {
    _getDataNumber();
  }

  _saveDataNumbers(String dropdownValueNumberShared) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data2", dropdownValueNumberShared);
  }

  _getDataNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dropdownValueNumber = sharedPreferences.getString("data2") ?? number.first;
    setState(() {});
  }

  ///
/////3rd///
// 2nd dropdown button
  // data which child
  String? dropdownValueEducationM;

//   // List of items in our dropdown menu
  List<String> educationM = ['හදුනාගන්නවාද?', 'ඔව්', 'නෑ'];

  //IF "dropdownValueMembers" is empty pass "which" word as a initial value if al ready selected then pass the shared preference value
  checkValueEducationM() {
    _getDataEducationM();
  }

  _saveDataEducationM(String dropdownValueEducationMShared) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data3", dropdownValueEducationMShared);
  }

  _getDataEducationM() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dropdownValueEducationM =
        sharedPreferences.getString("data3") ?? educationM.first;
    setState(() {});
  }

  /// 4th

// 2nd dropdown button
  // data which child
  String? dropdownValueEducationF;

//   // List of items in our dropdown menu
  List<String> educationF = ['හදුනාගන්නවාද?', 'ඔව්', 'නෑ'];

  //IF "dropdownValueMembers" is empty pass "which" word as a initial value if al ready selected then pass the shared preference value
  checkValueEducationF() {
    _getDataEducationF();
  }

  _saveDataEducationF(String dropdownValueEducationFShared) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data4", dropdownValueEducationFShared);
  }

  _getDataEducationF() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dropdownValueEducationF =
        sharedPreferences.getString("data4") ?? educationF.first;
    setState(() {});
  }

//////
  // Initial Selected Value  income
  // 2nd dropdown button
  // data which child
  String? dropdownValueIncome;

//   // List of items in our dropdown menu
  List<String> income = [
    'පැවසුවේ?',
    'මාස 18 පෙර',
    'මාස 18ට පසු ',
  ];

  //IF "dropdownValueMembers" is empty pass "which" word as a initial value if al ready selected then pass the shared preference value
  checkValueIncome() {
    _getDataIncome();
  }

  _saveDataIncome(String dropdownValueIncomeShared) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data5", dropdownValueIncomeShared);
  }

  _getDataIncome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dropdownValueIncome = sharedPreferences.getString("data5") ?? income.first;
    setState(() {});
  }

  //
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                  Text(
                    'ප්‍රශ්නාවලිය',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.00,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                          size: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13),
                          child: SizedBox(
                            width: width * 0.82,
                            child: Text(
                              Config.app_Screentestquestion1,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 5),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            boxShadow: const <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.37), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(20),
                            // Initial Value
                            value: dropdownValueMembers,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: SizedBox(
                                  height: 15,
                                  width: 180, // for example
                                  child: Text(items,
                                      style: const TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  dropdownValueMembers = newValue!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  //මෙම දරුවා පවුලේ කී වෙනි දරුවාද?
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                          size: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13, right: 2),
                          child: SizedBox(
                            width: width * 0.82,
                            child: Text(
                              Config.app_Screentestquestion2,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //parents education topic
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            boxShadow: const <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.37), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(20),
                            // Initial Value
                            value: dropdownValueNumber,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: number.map((String number) {
                              return DropdownMenuItem(
                                value: number,
                                child: SizedBox(
                                  height: 17,
                                  width: 180.0, // for example
                                  child: Text(number,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newNumber) {
                              setState(
                                () {
                                  dropdownValueNumber = newNumber!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                          size: 10.0,
                        ),
                        SizedBox(
                          width: width * 0.82,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Text(
                              Config.app_Screentestquestion3,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            boxShadow: const <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.37), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(20),
                            // Initial Value
                            value: dropdownValueEducationM,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: educationM.map((String educationM) {
                              return DropdownMenuItem(
                                value: educationM,
                                child: SizedBox(
                                  height: 17,
                                  width: 180, // for example
                                  child: Text(educationM,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newEducation) {
                              setState(
                                () {
                                  dropdownValueEducationM = newEducation!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                          size: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13),
                          child: SizedBox(
                            width: width * 0.82,
                            child: Text(
                              Config.app_Screentestquestion4,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            boxShadow: const <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.37), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(20),
                            // Initial Value
                            value: dropdownValueEducationF,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: educationM.map((String educationF) {
                              return DropdownMenuItem(
                                value: educationF,
                                child: SizedBox(
                                  height: 17,
                                  width: 180, // for example
                                  child: Text(educationF,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newEducationF) {
                              setState(
                                () {
                                  dropdownValueEducationF = newEducationF!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.brightness_1,
                          color: Colors.black,
                          size: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13),
                          child: SizedBox(
                            width: width * 0.82,
                            child: Text(
                              Config.app_Screentestquestion5,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 38,
                        ),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            boxShadow: const <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.37), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(20),
                            // Initial Value
                            value: dropdownValueIncome,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: income.map((String income) {
                              return DropdownMenuItem(
                                value: income,
                                child: SizedBox(
                                  height: 20,
                                  width: 180, // for example
                                  child: Center(
                                    child: Text(income,
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newIncome) {
                              setState(
                                () {
                                  dropdownValueIncome = newIncome!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: height * 0.02, top: height * 0.10),
                    child: SizedBox(
                      width: 160.0,
                      height: 35.0,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onsend();
                            marks();

                            _saveData(dropdownValueMembers!);
                            _saveDataNumbers(dropdownValueNumber!);
                            _saveDataEducationM(dropdownValueEducationM!);
                            _saveDataEducationF(dropdownValueEducationF!);
                            _saveDataIncome(dropdownValueIncome!);
                          },
                          child: const Text('ඉදිරියට යන්න')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onsend() async {
    //uploading to cloudfirestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection("answers")
        .doc("${loggedInUser.uid}")
        .set({
      'familyChildren': dropdownValueMembers,
      "whichChild": dropdownValueNumber,
      "motherEducation": dropdownValueEducationM,
      "fatherEducation": dropdownValueEducationF,
      "monthlyIncome": dropdownValueIncome,
    });
    //.whenComplete(() =>
    // showSnackBar("Voice uploaded successful", Duration(seconds: 2)));
  }

  void marks() {
    var marks = 0;
    if (dropdownValueMembers == '5ක් හෝ වැඩි') marks += 10;
    if (dropdownValueNumber == 'ඔව්') marks += 10;
    if (dropdownValueEducationM == 'ඔව්') marks += 10;
    if (dropdownValueEducationF == 'ඔව්') marks += 10;
    if (dropdownValueIncome == 'මාස 18 පෙර') marks += 10;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MarksScreen(
                marks: marks,
              )),
    );
  }
}
