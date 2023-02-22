import 'package:badges/badges.dart';
import 'package:cart/main.dart';
import 'package:cart/screens/pages/bills.dart';
import 'package:cart/screens/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import '../maintain/imports.dart';

var namea = TextEditingController();
var costa = TextEditingController();
var stocka = TextEditingController();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";
  Cart a = Get.find();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                  ),
                  child: Icon(
                    CupertinoIcons.square_grid_2x2,
                    color: Colors.black,
                  ),
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              Badge(
                badgeColor: Color.fromARGB(255, 0, 0, 0),
                animationType: BadgeAnimationType.scale,
                position: BadgePosition.topStart(top: 7, start: 20),
                badgeContent: Obx((() => Text(
                      a.k.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ))),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => P());
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(
                      right: 25,
                    ),
                    child: const Icon(
                      CupertinoIcons.bag,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          drawer: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Drawer(
              backgroundColor: Color(0xFFB98434),
              width: 150,
              elevation: 100,
              child: Column(
                // Important: Remove any padding from the ListView.
                // padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Text('User',
                        style:
                            TextStyle(color: Colors.black, fontFamily: "lr")),
                    trailing:
                        Icon(CupertinoIcons.person, color: Colors.white70),
                    onTap: () {
                      Get.to(Profile());
                    },
                  ),
                  Expanded(child: Container()),
                  ListTile(
                    leading: const Text('Bills',
                        style:
                            TextStyle(color: Colors.black, fontFamily: "lr")),
                    trailing:
                        Icon(CupertinoIcons.square_list, color: Colors.white60),
                    onTap: () {
                      Get.to(Invoices());
                    },
                  ),
                  ListTile(
                    leading: Text(
                      'Cart',
                      style: TextStyle(color: Colors.black, fontFamily: "lr"),
                    ),
                    trailing:
                        const Icon(CupertinoIcons.cart, color: Colors.white60),
                    onTap: () {
                      Get.to(() => P());
                    },
                  ),
                  ListTile(
                    leading: const Text('Stock',
                        style:
                            TextStyle(color: Colors.black, fontFamily: "lr")),
                    trailing:
                        Icon(CupertinoIcons.cube_box, color: Colors.white60),
                    onTap: () {
                      Get.to(Edit());
                    },
                  ),
                  Expanded(child: Container()),
                  ListTile(
                    leading: const Text('Log Out',
                        style:
                            TextStyle(color: Colors.black, fontFamily: "lr")),
                    trailing: Icon(Icons.logout_rounded, color: Colors.white60),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: (() {
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
                              controller: namea,
                              decoration: const InputDecoration(
                                  hintText: "Product :",
                                  fillColor: Colors.white,
                                  filled: true),
                            )),
                            SizedBox(
                              height: 12,
                            ),
                            Material(
                                child: TextField(
                                    controller: costa,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "cost :",
                                        fillColor: Colors.white,
                                        filled: true))),
                            const SizedBox(
                              height: 12,
                            ),
                            Material(
                                child: TextField(
                                    controller: stocka,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "stock :",
                                        fillColor: Colors.white,
                                        filled: true))),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 45,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    Get.back();
                                    if (namea.text.isNotEmpty &&
                                        costa.text.isNotEmpty &&
                                        stocka.text.isNotEmpty) {
                                      await FirebaseFirestore.instance
                                          .collection(FirebaseAuth
                                              .instance.currentUser!.uid
                                              .toString())
                                          .add({
                                        "name": namea.text,
                                        "cost": int.parse(costa.text),
                                        "stock": int.parse(stocka.text)
                                      });

                                      namea.clear();
                                      costa.clear();
                                      stocka.clear();

                                      print("added--------------");
                                    } else {
                                      Get.snackbar("No Product",
                                          "Plz fill all the fields");
                                    }
                                  },
                                  child: Text(
                                    "ADD",
                                    style: TextStyle(
                                        fontFamily: "lb", color: Colors.black),
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
            }),
            child: const Icon(
              CupertinoIcons.share,
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
                bottom: 8.0, left: w / 12, right: w / 12, top: 0),
            child: ListView(children: [
              Container(
                alignment: Alignment.center,
                height: h / 8,
                color: Colors.white,
                child: TextField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.search),
                      suffixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'search',
                            style: TextStyle(
                                fontFamily: "pr",
                                color: Color.fromARGB(255, 187, 187, 187)),
                          ))),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              SizedBox(
                height: h / 40,
              ),
              SizedBox(
                height: h / 1.4,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(
                          FirebaseAuth.instance.currentUser!.uid.toString())
                      .snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                                ConnectionState.waiting) ||
                            snapshots.data?.docs.isEmpty == true
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("EMPTY",
                                    style: TextStyle(color: Colors.black26)),
                                const Text("Added Items will be shown here",
                                    style: TextStyle(color: Colors.black38)),
                                Lottie.asset(
                                  'assets/emtyy.json',
                                  height: 250,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, i) {
                              var data = snapshots.data!.docs[i].data()
                                  as Map<String, dynamic>;
                              Product x = Product.fromMap(data);
                              if (name.isEmpty) {
                                // hereeee
                                return Padding(
                                  padding: EdgeInsets.only(bottom: h / 32),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    tileColor: Colors.black,
                                    title: Text(
                                      x.name.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          a.increment(x);
                                          a.total();
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Color(0xFFB98434),
                                        )),
                                  ),
                                );
                              }
                              if (data['name']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    tileColor: Colors.black,
                                    title: Text(
                                      x.name.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          a.increment(x);
                                          a.total();
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Color(0xFFB98434),
                                        )),
                                  ),
                                );
                              }
                              return Container();
                            });
                  },
                ),
              )
            ]),
          )),
    );
  }
}
