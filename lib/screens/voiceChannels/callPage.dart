/*
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class CallCard extends StatefulWidget {
  const CallCard({Key? key}) : super(key: key);

  @override
  State<CallCard> createState() => _CallCardState();
}

class _CallCardState extends State<CallCard> {
  final AgoraClient _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: '5ef9b48c22384b14bf4faccc9d250bc0',
          channelName: 'Knitting',
          tempToken:
              '007eJxTYPA8yKR8eeYDEzfBl1f5PX+mT9nv2jiB/xanw1Gxgggr8QwFBtPUNMskE4tkIyNjC5MkQ5OkNJO0xOTkZMsUI1ODpGQDfQev5IZARobL8UpMjAwQCOJzMHjnZZaUZOalMzAAADHnHqc='));
  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  _initAgora() async {
    await _client.initialize();
  }

 */
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              layoutType: Layout.floating,
              showNumberOfUsers: true,
            ),
            AgoraVideoButtons(
              client: _client,
              enabledButtons: const [
                BuiltInButtons.toggleCamera,
                BuiltInButtons.callEnd,
                BuiltInButtons.toggleMic
              ],
            )
          ],
        ),
      ),
    );
  }
}
*/
