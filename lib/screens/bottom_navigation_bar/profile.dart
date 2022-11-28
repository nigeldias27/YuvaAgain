import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/screens/home.dart';

import 'notifications.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffFEFCF3),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/profileGradient.png'),
                                fit: BoxFit.cover)),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image:
                                    AssetImage("assets/images/Customer.png"))),
                      ))
                ],
              ),
              Text(
                "Nigel Dias",
                style: GoogleFonts.alata(fontSize: 32),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "Phone Number",
                        style: GoogleFonts.alata(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.alata(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            //      fillColor: Color(0xffFDF2C9),
                            //      focusColor: Color(0xffFDF2C9),
                            //      hoverColor: Color(0xffFDF2C9),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff12253A))),
                            //      labelText: "Age",
                            labelStyle: GoogleFonts.alata(
                                fontSize: 16, color: Color(0xff12253A))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "Hobbies",
                        style: GoogleFonts.alata(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.alata(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            //      fillColor: Color(0xffFDF2C9),
                            //      focusColor: Color(0xffFDF2C9),
                            //      hoverColor: Color(0xffFDF2C9),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff12253A))),
                            //      labelText: "Age",
                            labelStyle: GoogleFonts.alata(
                                fontSize: 16, color: Color(0xff12253A))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "Languages",
                        style: GoogleFonts.alata(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.alata(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            //      fillColor: Color(0xffFDF2C9),
                            //      focusColor: Color(0xffFDF2C9),
                            //      hoverColor: Color(0xffFDF2C9),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff12253A))),
                            //      labelText: "Age",
                            labelStyle: GoogleFonts.alata(
                                fontSize: 16, color: Color(0xff12253A))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff333232),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => Notifications()));
                        },
                        icon: Icon(
                          Icons.notifications,
                          size: 34,
                          color: Color(0xffFCE39A),
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) => Home()));
                        },
                        icon: Icon(
                          Icons.home,
                          size: 34,
                          color: Color(0xffFCE39A),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          size: 34,
                          color: Color(0xffFCE39A),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          size: 34,
                          color: Color(0xffFDBC4C),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
