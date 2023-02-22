import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cart/screens/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../maintain/imports.dart';
import '../maintain/navigation.dart';

TextEditingController name = TextEditingController();
TextEditingController number = TextEditingController();
TextEditingController gst = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController upi = TextEditingController();

class D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: h / 25, right: h / 25, bottom: 20, top: h / 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => a.path.value == ''
                          ? InkWell(
                              onTap: () {
                                a.pick();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFB98434),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                alignment: Alignment.center,
                                height: h / 8,
                                width: h / 8,
                                child: const FaIcon(FontAwesomeIcons.image),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                a.pick();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.file(
                                  File(a.path.value),
                                  width: h / 8,
                                  height: h / 8,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                // ElevatedButton(onPressed: (){a.pick();}, child: const Text("pick"))
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 255, 255, 255), width: 2.0),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    hintText: "Name",
                    hintStyle: TextStyle(fontFamily: "pr"),
                    fillColor: Color(0xFFBF3F8FF),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                          color: Color(0xFFBF3F8FF),
                        )),
                    prefixIcon: Icon(Icons.boy_outlined),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: number,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 255, 255, 255), width: 2.0),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    hintText: "Number",
                    hintStyle: TextStyle(fontFamily: "pr"),
                    fillColor: Color(0xFFBF3F8FF),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                          color: Color(0xFFBF3F8FF),
                        )),
                    prefixIcon: Icon(Icons.phone_android_rounded),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: address,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 255, 255, 255), width: 2.0),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    hintText: "Address",
                    hintStyle: TextStyle(fontFamily: "pr"),
                    fillColor: const Color(0xFFBF3F8FF),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                          color: Color(0xFFBF3F8FF),
                        )),
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: gst,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 255, 255, 255), width: 2.0),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    hintText: "Gst",
                    hintStyle: TextStyle(fontFamily: "pr"),
                    fillColor: Color(0xFFBF3F8FF),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                          color: Color(0xFFBF3F8FF),
                        )),
                    prefixIcon: Icon(Icons.wallet_membership_rounded),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: upi,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 255, 255, 255), width: 2.0),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    hintText: "Upi",
                    hintStyle: const TextStyle(fontFamily: "pr"),
                    fillColor: Color(0xFFBF3F8FF),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                          color: Color(0xFFBF3F8FF),
                        )),
                    prefixIcon: Icon(Icons.wallet),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: h / 20,
                      width: w / 4,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (name.text.isNotEmpty &&
                                gst.text.isNotEmpty &&
                                number.text.isNotEmpty &&
                                address.text.isNotEmpty &&
                                upi.text.isNotEmpty) {
                              a.details(
                                  name.text.trim(),
                                  gst.text.trim(),
                                  upi.text.trim(),
                                  address.text.trimLeft(),
                                  number.text.trim());
                              Get.to(MyApp());
                            } else {
                              Get.snackbar(
                                  "Empty Fields", "Please Enter All Fields");
                            }
                          },
                          child: Text(
                            "save",
                            style: TextStyle(
                                fontFamily: "lb", color: Colors.black),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
