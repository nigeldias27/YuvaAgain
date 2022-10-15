import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuva_again/screens/registration/personalInfo.dart';

import '../home.dart';
import 'auth.dart';

class InitializerWidget extends StatefulWidget {
  final registering;
  const InitializerWidget({Key? key, this.registering}) : super(key: key);

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth? _auth;
  User? _user;
  bool isLoading = true;
  String username = '';
  @override
  void initState() {
    late SingleValueDropDownController _cnt = SingleValueDropDownController();
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    //FirebaseAuth.instance.signOut();
    route();
  }

  Future<void> route() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') != null) {
      setState(() {
        isLoading = false;
        username = prefs.getString('username')!;
      });
    }

    //  if (_user == null) {
    //    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //      Navigator.pushReplacement(
    //          context, MaterialPageRoute(builder: (context) => Authenticate()));
    //    });}
    print(_user?.uid);
    if (_user?.uid != null) {
      String? uid = _user?.uid;
      final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
      if (snapshot.exists) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PersonalInfo()));
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Yuva Again"),
            ),
            body: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * (7 / 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Choose your Language",
                      style: GoogleFonts.montserrat(
                        fontSize: 48,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: DropDownTextField(
                          dropDownIconProperty:
                              IconProperty(color: Colors.black),
                          clearIconProperty: IconProperty(color: Colors.black),
                          textFieldDecoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orangeAccent)),
                              labelText: "Languages",
                              labelStyle: GoogleFonts.montserrat(
                                  fontSize: 16, color: Colors.black)),
                          dropDownList: [
                            DropDownValueModel(
                                name: "English", value: "English")
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Authenticate()));
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                          padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.zero),
                        ),
                        child: Ink(
                          decoration: const BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 88.0,
                                minHeight:
                                    36.0), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black, fontSize: 24),
                              ),
                            ),
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
}
