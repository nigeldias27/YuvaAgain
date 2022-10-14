import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:yuva_again/screens/registration/personalInfo.dart';

import 'init.dart';

enum ScreenState { MOBILE_NO_STATE, OTP_STATE }

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  ScreenState curr_state = ScreenState.MOBILE_NO_STATE;
  final mobFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  String mob_no = "";
  String otp = "";
  String countryCode = "+91";
  String? _verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PersonalInfo()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  Widget get_mob_state(BuildContext context) {
    return Form(
      key: mobFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Yuva Again",
            style: GoogleFonts.montserrat(fontSize: 48),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CountryCodePicker(
                    onChanged: (val) {
                      countryCode = val.toString();
                    },
                    initialSelection: "IN",
                    showFlagMain: false,
                    textStyle: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.black),
                    dialogSize: Size(300, 400)),
                Container(
                  width: 250,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent)),
                        hintText: "Enter your phone number",
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 16, color: Colors.black)),
                    validator: (val) {
                      if (val == null || val.length != 10) {
                        return "Please enter a valid moble number.";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => setState(() {
                      mob_no = value!;
                    }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 16,
          ),
          TextButton(
            child: Text(
              "Get OTP",
              style: GoogleFonts.montserrat(fontSize: 22, color: Colors.black),
            ),
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  //side: BorderSide(color: Colors.red)
                )),
                backgroundColor:
                    MaterialStateProperty.all(Colors.orangeAccent)),
            onPressed: () async {
              final isValid = mobFormKey.currentState!.validate();
              if (isValid) {
                mobFormKey.currentState!.save();

                setState(() {
                  showLoading = true;
                });
                await _auth.verifyPhoneNumber(
                    phoneNumber: countryCode + mob_no,
                    verificationCompleted: (phoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });

                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    verificationFailed: (verificationFailed) async {
                      setState(() {
                        showLoading = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(verificationFailed.message!),
                          duration: const Duration(minutes: 2)));
                    },
                    codeSent: (verificationId, resendingToken) async {
                      setState(() {
                        showLoading = false;
                        curr_state = ScreenState.OTP_STATE;
                        _verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InitializerWidget(
                                    registering: true,
                                  )));
                    });
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
        ],
      ),
    );
  }

  //TODO: Impement a good otp entry field
  Widget get_otp_state(BuildContext context) {
    return Form(
      key: otpFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Verify\nNumber",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 48),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          // TextFormField(
          //   keyboardType: TextInputType.number,
          //   onSaved: (value) => setState(() {
          //     otp = value!;
          //   }),
          //   validator: (val) {
          //     if (val!.length != 6) {
          //       return "Enter valid OTP";
          //     } else {
          //       return null;
          //     }
          //   },
          // ),
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 40,
            style: TextStyle(fontSize: 17, color: Colors.black),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              otp = pin;
              onOtpPressed();
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 16,
          ),
          ElevatedButton(
              child: Text(
                "Verify",
                style:
                    GoogleFonts.montserrat(fontSize: 22, color: Colors.black),
              ),
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    //side: BorderSide(color: Colors.red)
                  )),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent)),
              onPressed: onOtpPressed),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
        ],
      ),
    );
  }

  void onOtpPressed() async {
    final isValid = otpFormKey.currentState!.validate();
    if (isValid) {
      otpFormKey.currentState!.save();
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);

      signInWithPhoneAuthCredential(phoneAuthCredential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        showLoading
            ? Center(child: CircularProgressIndicator())
            : curr_state == ScreenState.MOBILE_NO_STATE
                ? get_mob_state(context)
                : get_otp_state(context),
      ],
    ));
  }
}
