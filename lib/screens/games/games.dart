import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  bool isLoading = true;
  bool hasConnection = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      checkUserConnection();
    });

    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
        body: Stack(
          children: [
            WebView(
              initialUrl:
                  "https://www.seniorsonline.vic.gov.au/services-information/games",
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            (isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack())
          ],
        ));
  }

  Future<void> checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          hasConnection = true;
        });
      }
    } catch (error) {
      setState(() {
        hasConnection = false;
      });
    }
  }
}
