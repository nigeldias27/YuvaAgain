import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:yuva_again/screens/games/games.dart';
import 'package:yuva_again/screens/hobbies/hobbies.dart';
import 'package:yuva_again/screens/voiceChannels/voiceChannels.dart';

import '../services/treeIncrementor.dart';

class Home extends StatefulWidget {
  final username;
  const Home({Key? key, this.username}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth? _auth;
  String greetings = '';
  Artboard? riveartboard;
  late StreamSubscription stream;
  StateMachineController? stateMachineController;
  SMIInput<double>? _progress;
  bool loadingtreeScore = true;
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() async {
    _auth = FirebaseAuth.instance;
    await greeting();
    await rootBundle.load('assets/tree_demo.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, 'Grow');
      if (controller != null) {
        artboard.addController(controller);
        _progress = controller.findInput('input');
        setState(() {
          loadingtreeScore = false;
          riveartboard = artboard;
        });
      }
    });
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/' + _auth!.currentUser!.uid);
    stream = ref.onValue.listen((event) {
      var data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      print(data);
      int myscore = data['treeScore'] != null ? data['treeScore'] : 0;
      setState(() {
        _progress?.value = myscore.toDouble();
      });
    });
  }

  greeting() async {
    final ref = FirebaseDatabase.instance.ref();
    String user = _auth!.currentUser!.uid;
    final snapshot = await ref.child('users/$user').get();
    if (snapshot.exists) {
      var data = Map<String, dynamic>.from(snapshot.value as dynamic);
      var dt = DateTime.now();
      if (dt.hour < 5) {
        setState(() {
          greetings = "Good night " + data['Name'];
        });
      } else if (dt.hour < 12) {
        setState(() {
          greetings = "Good morning " + data['Name'];
        });
      } else if (dt.hour < 15) {
        setState(() {
          greetings = "Good afternoon " + data['Name'];
        });
      } else if (dt.hour < 19) {
        setState(() {
          greetings = "Good evening " + data['Name'];
        });
      } else {
        setState(() {
          greetings = "Good night " + data['Name'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Yuva Again",
            style: GoogleFonts.montserrat(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextToSpeech tts = TextToSpeech();
            tts.speak(greetings);
            sleep(Duration(seconds: 3));
            tts.speak(" Voice Channels, Hobbies and Games");
          },
          backgroundColor: Colors.orangeAccent,
          child: Icon(
            Icons.speaker_group,
            color: Colors.black,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 32.0, 10, 0),
                  child: Text(
                    greetings,
                    style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            treeincrement(_auth!.currentUser!.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => VoiceChannels()));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Voice Channels',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Google_Voice_icon_%282020%29.svg/2020px-Google_Voice_icon_%282020%29.svg.png",
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            treeincrement(_auth!.currentUser!.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => Hobbies()));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Hobbies',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/3713/3713309.png",
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            treeincrement(_auth!.currentUser!.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => Games()));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Games',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/2533/2533402.png",
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: loadingtreeScore
                  ? Center(child: CircularProgressIndicator())
                  : Rive(
                      artboard: riveartboard!,
                      alignment: Alignment.center,
                    ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    stream.cancel();
    super.deactivate();
  }
}
