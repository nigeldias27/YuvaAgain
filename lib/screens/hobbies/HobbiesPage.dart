import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/widgets/header.dart';

class HobbyTracker extends StatefulWidget {
  const HobbyTracker({Key? key}) : super(key: key);

  @override
  State<HobbyTracker> createState() => _HobbyTrackerState();
}

class _HobbyTrackerState extends State<HobbyTracker> {
  FirebaseAuth? auth;
  List allEvents = [];
  DateTime initialval = DateTime.now();
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffFEFCF3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            heading: 'Hobby Tracker',
          ),
          CalendarTimeline(
            initialDate: initialval,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) async {
              setState(() {
                initialval = date;
              });
            },
            leftMargin: 20,
            monthColor: Colors.grey,
            dayColor: Colors.black,
            activeDayColor: Colors.black,
            activeBackgroundDayColor: Colors.orangeAccent,
            dotsColor: Color(0xFF333A47),
            locale: 'en_ISO',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 16),
            child: Text(
              "My Tasks",
              style: GoogleFonts.alata(fontSize: 32),
            ),
          ),
          Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      width: 150,
                      height: 125,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Gardening",
                              style: GoogleFonts.alata(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 7,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Voice channels",
                                          style: GoogleFonts.alata(
                                              color: Colors.yellow),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Text(
                                            "Gardening",
                                            style:
                                                GoogleFonts.alata(fontSize: 24),
                                          ),
                                        ),
                                        Text(
                                          "10:00am-12:00am",
                                          style: GoogleFonts.alata(
                                              color: Color(0xff91D7E0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  Icons
                                      .circle_outlined, //Icons.check_circle_rounded,
                                  color: Colors.green,
                                  size: 32,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    ));
  }
}
