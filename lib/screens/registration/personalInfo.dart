import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:yuva_again/screens/home.dart';
import 'package:yuva_again/services/getChannels.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final age = TextEditingController();
  FirebaseAuth? _auth;
  final name = TextEditingController();
  late SingleValueDropDownController _cnt = SingleValueDropDownController();
  late MultiValueDropDownController _cntMult = MultiValueDropDownController();
  late MultiValueDropDownController _cntMulti = MultiValueDropDownController();
  List<DropDownValueModel> current_interests = [];

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }

  init_wrapper() async {
    print("this is running");
    print(await getsChannels());
    List channels = await getsChannels();
    List<DropDownValueModel> allchannels = channels
        .map(
          (e) => DropDownValueModel(name: e, value: e),
        )
        .toList();
    setState(() {
      current_interests = allchannels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 24, 16, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 145,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 48, 8, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 44,
                                  child: Text(
                                    'Tell us more about yourself',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 40, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8.0, 8, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: name,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.orangeAccent)),
                                        labelText: "Name",
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize: 16, color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8.0, 8, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: age,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.orangeAccent)),
                                        labelText: "Age",
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize: 16, color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8.0, 8, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropDownTextField(
                                    textStyle: GoogleFonts.montserrat(),
                                    controller: _cnt,
                                    clearOption: true,
                                    dropDownIconProperty:
                                        IconProperty(color: Colors.black),
                                    clearIconProperty:
                                        IconProperty(color: Colors.black),
                                    textFieldDecoration: InputDecoration(
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.orangeAccent)),
                                        labelText: "Gender",
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize: 16, color: Colors.black)),
                                    validator: (value) {
                                      if (value == null) {
                                        return "Required field";
                                      } else {
                                        return null;
                                      }
                                    },
                                    dropDownList: const [
                                      DropDownValueModel(
                                          name: 'Male', value: "Male"),
                                      DropDownValueModel(
                                          name: 'Female', value: "Female")
                                    ],
                                    onChanged: (val) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8.0, 8, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropDownTextField.multiSelection(
                                    controller: _cntMult,
                                    checkBoxProperty: CheckBoxProperty(
                                        activeColor: Colors.orangeAccent),
                                    submitButtonColor: Colors.orangeAccent,
                                    textStyle: GoogleFonts.montserrat(),
                                    dropDownList: current_interests,
                                    dropDownIconProperty:
                                        IconProperty(color: Colors.black),
                                    clearIconProperty:
                                        IconProperty(color: Colors.black),
                                    textFieldDecoration: InputDecoration(
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.orangeAccent)),
                                        labelText: "Current Interests",
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize: 16, color: Colors.black)),
                                    validator: (value) {
                                      if (value == null) {
                                        return "Required field";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (val) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8.0, 8, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropDownTextField.multiSelection(
                                    controller: _cntMulti,
                                    checkBoxProperty: CheckBoxProperty(
                                        activeColor: Colors.orangeAccent),
                                    submitButtonColor: Colors.orangeAccent,
                                    textStyle: GoogleFonts.montserrat(),
                                    dropDownList: current_interests,
                                    dropDownIconProperty:
                                        IconProperty(color: Colors.black),
                                    clearIconProperty:
                                        IconProperty(color: Colors.black),
                                    textFieldDecoration: InputDecoration(
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.orangeAccent)),
                                        labelText:
                                            "Hobbies that you want to build",
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize: 16, color: Colors.black)),
                                    validator: (value) {
                                      if (value == null) {
                                        return "Required field";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (val) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                  onPressed: personal_added,
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4))
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'SIGN UP',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 22, color: Colors.black),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  personal_added() async {
    var loc = await Location().getLocation();
    print(_auth?.currentUser);
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/' + _auth!.currentUser!.uid);
    String latlong = loc.latitude.toString() + ',' + loc.longitude.toString();
    await ref.set({
      "Name": name.text,
      "Age": age.text,
      "Gender": _cnt.dropDownValue!.name,
      "Current Interests":
          _cntMult.dropDownValueList!.map((e) => e.name).toList().toString(),
      "Future Interests":
          _cntMulti.dropDownValueList!.map((e) => e.name).toList().toString(),
      'location': latlong
    });
    List currentinterest =
        _cntMult.dropDownValueList!.map((e) => e.name).toList();
    List futureinterest =
        _cntMulti.dropDownValueList!.map((e) => e.name).toList();

    for (int i = 0; i < currentinterest.length; i++) {
      String nameofchannel = currentinterest[i];
      FirebaseDatabase.instance
          .ref('channels/$nameofchannel')
          .update({_auth!.currentUser!.uid: 'Current Interests'});
    }

    for (int i = 0; i < futureinterest.length; i++) {
      String nameofchannel = futureinterest[i];
      FirebaseDatabase.instance
          .ref('channels/$nameofchannel')
          .update({_auth!.currentUser!.uid: 'Future Interests'});
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }
}
