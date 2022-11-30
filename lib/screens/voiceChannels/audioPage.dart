import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:convert';
import 'package:sdp_transform/sdp_transform.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:yuva_again/widgets/header.dart';
import 'package:yuva_again/screens/voiceChannels/webrtcLogic.dart';
import 'package:just_audio/just_audio.dart';

class Audio extends StatefulWidget {
  // final uid;
  final String? roomId;

  // const Audio({Key? key, required this.uid, this.roomID}) : super(key: key);
  const Audio({Key? key, this.roomId}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  final _audioPlayer = AudioPlayer();

  WebRTCLogic webrtcLogic = WebRTCLogic();
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  String? roomId;

  initializeAudio() async {
    await _audioPlayer.setUrl(
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3");
    _audioPlayer.play();
  }

  initializeWebRTC() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    webrtcLogic.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    webrtcLogic.openUserMedia(_localRenderer, _remoteRenderer);
    // roomId = await webrtcLogic.createRoom(_remoteRenderer);
    // print("roomID: $roomId");
    roomId = widget.roomId;
    webrtcLogic.joinRoom(
      roomId!,
      _remoteRenderer,
    );
  }

  @override
  void initState() {
    initializeWebRTC();
    initializeAudio();
    super.initState();
  }

  @override
  void dispose() async {
    await _localRenderer.dispose();
    await _remoteRenderer.dispose();
    webrtcLogic.hangUp(_localRenderer);
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Header(
            heading: "Voice Channels",
          ),
          // Status text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfffbf2ce)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16.0, 0, 16),
                      child: Text(
                        "Reading",
                        style: GoogleFonts.alata(fontSize: 30),
                      ),
                    ),
                    Image.asset('assets/images/events.png'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                dispose();
                              },
                              icon: Icon(
                                Icons.call_end,
                                size: 42,
                              )),
                          IconButton(
                              onPressed: () {
                                webrtcLogic.muteMic();
                              },
                              icon: Icon(
                                Icons.mic,
                                size: 42,
                              )),
                          IconButton(
                              onPressed: () {
                                webrtcLogic.muteAudio();
                              },
                              icon: Icon(
                                Icons.volume_mute,
                                size: 42,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.person,
                                size: 42,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
