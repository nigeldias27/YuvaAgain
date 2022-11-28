import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/services/getNotifications.dart';
import 'package:yuva_again/widgets/header.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List allnotifications = [];
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(100),
            title: 'First Notification',
            body: "somebody",
            channelKey: 'Yuva Again'));
    allnotifications = await getNotifications();
    setState(() {
      allnotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFEFCF3),
        body: Column(
          children: [
            Header(
              heading: "Notifications",
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: allnotifications.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(21.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfffbf2ce)),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allnotifications[index]['name'],
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  allnotifications[index]['description'],
                                  style: GoogleFonts.montserrat(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
