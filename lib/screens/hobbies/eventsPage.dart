import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/widgets/header.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffFEFCF3),
      body: Column(
        children: [
          Header(
            heading: "Events",
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 32.0, 32, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.alata(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Color(0xff12253A),
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffFDF2C9),
                          focusColor: Color(0xffFDF2C9),
                          hoverColor: Color(0xffFDF2C9),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff12253A))),
                          labelText: "Search",
                          labelStyle: GoogleFonts.alata(
                              fontSize: 16, color: Color(0xff12253A))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (builder) => Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://wallpaperaccess.com/full/1660718.jpg",
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    64,
                                                fit: BoxFit.fill,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0),
                                            child: Text(
                                              'Event 1',
                                              style: GoogleFonts.alata(
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff3F38DD)
                                                          .withOpacity(0.17),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.calendar_today,
                                                      color: Color(0xff3F38DD),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "14 December, 2022",
                                                        style:
                                                            GoogleFonts.alata(
                                                                fontSize: 14),
                                                      ),
                                                      Text(
                                                          "Tuesday, 4:00PM-9:00PM",
                                                          style:
                                                              GoogleFonts.alata(
                                                                  color: Color(
                                                                      0xff767676),
                                                                  fontSize: 14))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff3F38DD)
                                                          .withOpacity(0.17),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Color(0xff3F38DD),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Gala Convention Centre",
                                                        style:
                                                            GoogleFonts.alata(
                                                                fontSize: 14),
                                                      ),
                                                      Text(
                                                          "36 Street, Bangalore",
                                                          style:
                                                              GoogleFonts.alata(
                                                                  color: Color(
                                                                      0xff767676),
                                                                  fontSize: 14))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff3F38DD)
                                                          .withOpacity(0.17),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Color(0xff3F38DD),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Yuva Again",
                                                        style:
                                                            GoogleFonts.alata(
                                                                fontSize: 14),
                                                      ),
                                                      Text("Organizer",
                                                          style:
                                                              GoogleFonts.alata(
                                                                  color: Color(
                                                                      0xff767676),
                                                                  fontSize: 14))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0),
                                            child: Text(
                                              'About event',
                                              style: GoogleFonts.alata(
                                                  fontSize: 18),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    48,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5A68F6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "GOING",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.alata(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    "https://wallpaperaccess.com/full/1660718.jpg",
                                    width:
                                        MediaQuery.of(context).size.width - 64,
                                    fit: BoxFit.fill,
                                    height: 100,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Text(
                                  'Event 1',
                                  style: GoogleFonts.alata(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff3F38DD)
                                              .withOpacity(0.17),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xff3F38DD),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "14 December, 2022",
                                            style:
                                                GoogleFonts.alata(fontSize: 14),
                                          ),
                                          Text("Tuesday, 4:00PM-9:00PM",
                                              style: GoogleFonts.alata(
                                                  color: Color(0xff767676),
                                                  fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
