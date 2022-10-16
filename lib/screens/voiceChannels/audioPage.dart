import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  String channelName = "Knitting";
  String token =
      "007eJxTYLA8E2rDy5Qae316zOyE69lWP5uahU/JeRV9K2DzmmF0yF+BwTQ1zTLJxCLZyMjYwiTJ0CQpzSQtMTk52TLFyNQgKdmgYbJ3ckMgI8PVmVFMjAwQCOJzMHjnZZaUZOalMzAAAFXEH/s=";
  static const appId = "5ef9b48c22384b14bf4faccc9d250bc0";
  int uid = 0; // uid of the local user
  bool mute = false;
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance
  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Yuva Again",
            style: GoogleFonts.montserrat(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status text
            Container(height: 40, child: Center(child: _status())),
            // Button Row
            Padding(
              padding: const EdgeInsets.only(top: 27.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              color: _isJoined
                                  ? Colors.orangeAccent
                                  : Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    offset: const Offset(0, 4))
                              ],
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add_call,
                                  color: Colors.black,
                                ),
                                Text(
                                  "Join",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                      onPressed: () => {join()},
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    offset: const Offset(0, 4))
                              ],
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.call_end,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Leave",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                      onPressed: () => {leave()},
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              color: mute
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    offset: const Offset(0, 4))
                              ],
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20),
                            child: Column(
                              children: [
                                Icon(
                                  mute
                                      ? Icons.mic_rounded
                                      : Icons.mic_off_rounded,
                                  color: Colors.black,
                                ),
                                Text(
                                  mute ? "Unmute" : "Mute",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                      onPressed: () => {
                        setState(() {
                          mute ? mute = false : mute = true;
                          agoraEngine.muteLocalAudioStream(mute);
                        })
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  Widget _status() {
    String statusText;

    if (!_isJoined)
      statusText = 'Join a channel';
    else if (_remoteUid == null)
      statusText = 'Waiting for a remote user to join...';
    else
      statusText = 'Connected to remote user, uid:$_remoteUid';

    return Text(
      statusText,
      style: GoogleFonts.montserrat(),
    );
  }

  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }
}
