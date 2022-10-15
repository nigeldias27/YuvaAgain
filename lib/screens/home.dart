import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:yuva_again/screens/voiceChannels/voiceChannels.dart';
import 'package:yuva_again/services/treeHeight.dart';

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
        int treeScore = await treeHeight(_auth!.currentUser!.uid);
        setState(() {
          loadingtreeScore = false;
          _progress?.value = treeScore.toDouble();
          riveartboard = artboard;
        });
      }
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 32.0, 0, 0),
                  child: Text(
                    greetings,
                    style: GoogleFonts.montserrat(
                        fontSize: 36,
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => VoiceChannels()));
                          },
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Voice Channels',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.mic,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Hobbies',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Games',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black),
                                ),
                                Icon(
                                  Icons.gamepad_outlined,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 156,
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
}
