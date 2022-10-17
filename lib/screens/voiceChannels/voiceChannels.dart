import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/screens/voiceChannels/audioPage.dart';
import 'package:yuva_again/screens/voiceChannels/callPage.dart';
import 'package:yuva_again/services/treeIncrementor.dart';
import 'package:yuva_again/services/yourChannels.dart';

class VoiceChannels extends StatefulWidget {
  const VoiceChannels({Key? key}) : super(key: key);

  @override
  State<VoiceChannels> createState() => _VoiceChannelsState();
}

class _VoiceChannelsState extends State<VoiceChannels> {
  FirebaseAuth? auth;
  List yourchannels = [];
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    init_wrapper();
  }

  init_wrapper() async {
    String uid = auth!.currentUser!.uid;
    List channels = await yourChannels(uid);
    print(await yourChannels(uid));
    setState(() {
      yourchannels = channels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orangeAccent, Colors.orange.shade200]),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32.0, 0, 0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 36,
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 32.0, 0, 24),
                    child: Text(
                      "Voice Channels",
                      style: GoogleFonts.montserrat(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 20, 0, 8),
            child: Text(
              "Your Channels",
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: yourchannels.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: channelClicked,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(yourchannels[index],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18, color: Colors.white)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }

  channelClicked() {
    treeincrement(auth!.currentUser!.uid);
    Navigator.push(context, MaterialPageRoute(builder: (builder) => Audio()));
  }
}
