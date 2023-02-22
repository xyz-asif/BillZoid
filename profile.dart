import 'dart:io';
import 'package:cart/screens/pages/search.dart';
import 'package:flutter/cupertino.dart';
import '../maintain/imports.dart';

final TextEditingController _name = TextEditingController();

final TextEditingController _number = TextEditingController();

final TextEditingController _gst = TextEditingController();

final TextEditingController _address = TextEditingController();

final TextEditingController _upi = TextEditingController();

class Profile extends StatelessWidget {
  const Profile({super.key});

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: w / 11),
            child: const Center(
                child: Text(
              "Profile",
              style: TextStyle(fontFamily: "lr", fontSize: 24),
            )),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final data = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => a.path.value == ''
                              ? InkWell(
                                  onTap: () {
                                    a.pick();
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        data["url"],
                                        height: 100,
                                        width: 100,
                                      )))
                              : InkWell(
                                  onTap: () {
                                    a.pick();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
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
                    ListTile(
                      leading: Icon(CupertinoIcons.person),
                      title: Text(data["name"].toString()),
                      subtitle: Text(
                        "Name",
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            _name.text = data["name"];

                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Material(
                                              child: TextField(
                                            controller: _name,
                                            decoration: InputDecoration(
                                                hintText: "Name :",
                                                fillColor: Colors.white,
                                                filled: true),
                                          )),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Container(
                                            height: 45,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  if (_name.text.isNotEmpty) {
                                                    a.updatekey(
                                                        "name", _name.text);
                                                    print(
                                                        "added--------------");
                                                    Get.back();
                                                  } else {
                                                    Get.snackbar("No Product",
                                                        "Plz fill all the fields");
                                                  }
                                                },
                                                child: Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                      fontFamily: "lb",
                                                      color: Colors.black),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                          },
                          icon: Icon(Icons.edit)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.phone),
                      title: Text(data["number"].toString()),
                      subtitle: Text(
                        "Number",
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                          onPressed: () async {},
                          icon: IconButton(
                              onPressed: () {
                                _number.text = data["number"];

                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Material(
                                                  child: TextField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                ],
                                                controller: _number,
                                                decoration: InputDecoration(
                                                    hintText: "Number :",
                                                    fillColor: Colors.white,
                                                    filled: true),
                                              )),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Container(
                                                height: 45,
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_number
                                                          .text.isNotEmpty) {
                                                        a.updatekey("number",
                                                            _number.text);
                                                        print(
                                                            "added--------------");
                                                        Get.back();
                                                      } else {
                                                        Get.snackbar(
                                                            "No Product",
                                                            "Plz fill all the fields");
                                                      }
                                                    },
                                                    child: Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontFamily: "lb",
                                                          color: Colors.black),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                              },
                              icon: Icon(Icons.edit))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.location),
                      title: Text(data["address"].toString()),
                      subtitle: Text(
                        "Address",
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                          onPressed: () async {},
                          icon: IconButton(
                              onPressed: () {
                                _address.text = data["address"];

                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Material(
                                                  child: TextField(
                                                controller: _address,
                                                decoration: InputDecoration(
                                                    hintText: "Address :",
                                                    fillColor: Colors.white,
                                                    filled: true),
                                              )),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Container(
                                                height: 45,
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_address
                                                          .text.isNotEmpty) {
                                                        a.updatekey("address",
                                                            _address.text);
                                                        print(
                                                            "added--------------");
                                                        Get.back();
                                                      } else {
                                                        Get.snackbar(
                                                            "No Product",
                                                            "Plz fill all the fields");
                                                      }
                                                    },
                                                    child: Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontFamily: "lb",
                                                          color: Colors.black),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                              },
                              icon: Icon(Icons.edit))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      leading: Icon(Icons.money),
                      title: Text(data["gst"].toString()),
                      subtitle: Text(
                        "GST",
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                          onPressed: () async {},
                          icon: IconButton(
                              onPressed: () {
                                _gst.text = data["gst"];

                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Material(
                                                  child: TextField(
                                                controller: _gst,
                                                decoration: InputDecoration(
                                                    hintText: "GST :",
                                                    fillColor: Colors.white,
                                                    filled: true),
                                              )),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Container(
                                                height: 45,
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_gst.text != null &&
                                                          _gst.text
                                                              .isNotEmpty) {
                                                        a.updatekey(
                                                            "gst", _gst.text);
                                                        print(
                                                            "added--------------");
                                                        Get.back();
                                                      } else {
                                                        Get.snackbar(
                                                            "No Product",
                                                            "Plz fill all the fields");
                                                      }
                                                    },
                                                    child: Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontFamily: "lb",
                                                          color: Colors.black),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                              },
                              icon: Icon(Icons.edit))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      leading: Icon(Icons.wallet),
                      title: Text(data["upi"].toString()),
                      subtitle: Text(
                        "UPI",
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                          onPressed: () async {},
                          icon: IconButton(
                              onPressed: () {
                                _upi.text = data["upi"];

                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Material(
                                                  child: TextField(
                                                controller: _upi,
                                                decoration: InputDecoration(
                                                    hintText: "UPI :",
                                                    fillColor: Colors.white,
                                                    filled: true),
                                              )),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Container(
                                                height: 45,
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_upi.text != null) {
                                                        a.updatekey(
                                                            "upi", _upi.text);
                                                        print(
                                                            "added--------------");
                                                        Get.back();
                                                      } else {
                                                        Get.snackbar(
                                                            "No Product",
                                                            "Plz fill all the fields");
                                                      }
                                                    },
                                                    child: Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontFamily: "lb",
                                                          color: Colors.black),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                              },
                              icon: Icon(Icons.edit))),
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
                                Get.snackbar("UPDATED", "");

                                Get.to(MyApp());
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
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
