import 'package:cart/screens/pages/search.dart';
import 'package:flutter/cupertino.dart';

import 'screens/maintain/imports.dart';
// adb connect 192.168.137.162

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark));
  Get.put(Cart());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyApp();
          }
          return const Welcome();
        },
      ),
      initialBinding: Bind(),
      theme: ThemeData(
          primarySwatch: a.createMaterialColor(const Color(0xFFB98434)))));
}

var name = TextEditingController();
var cost = TextEditingController();
var stock = TextEditingController();
var category = TextEditingController();

var pname = TextEditingController();
var pcost = TextEditingController();
var pstock = TextEditingController();

class Edit extends StatefulWidget {
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: w / 11),
              child: Center(
                  child: Text(
                "Stock",
                style: TextStyle(fontFamily: "lr", fontSize: 24),
              )),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            CupertinoIcons.share,
            color: Colors.black,
          ),
          onPressed: () {
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
                            controller: pname,
                            decoration: const InputDecoration(
                                hintText: "Product :",
                                fillColor: Colors.white,
                                filled: true),
                          )),
                          const SizedBox(
                            height: 12,
                          ),
                          Material(
                              child: TextField(
                                  controller: pcost,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "cost :",
                                      fillColor: Colors.white,
                                      filled: true))),
                          const SizedBox(
                            height: 12,
                          ),
                          Material(
                              child: TextField(
                                  controller: pstock,
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
                                  if (pname.text.isNotEmpty &&
                                      pcost.text.isNotEmpty &&
                                      pstock.text.isNotEmpty) {
                                    await FirebaseFirestore.instance
                                        .collection(FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString())
                                        .add({
                                      "name": pname.text,
                                      "cost": int.parse(pcost.text),
                                      "stock": int.parse(pcost.text)
                                    });
                                    pname.clear();
                                    pcost.clear();
                                    pstock.clear();
                                    print("added--------------");
                                    Get.back();
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
          },
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(bottom: 8.0, left: w / 10, right: w / 10),
          child: ListView(children: [
            SizedBox(
              height: h / 30,
            ),
            Container(
              height: h / 10,
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
                    search = val;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xFFB98434),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                        flex: 1,
                        child: Text(
                          "Name",
                          style: TextStyle(fontSize: 14, fontFamily: "lb"),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text("      Cost",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "lb")))),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text("       Stock",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "lb")))),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text("        Edit",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "lb")))),
                  ],
                ),
              ),
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
                              const Text(
                                "E M P T Y",
                                style: TextStyle(color: Colors.black26),
                              ),
                              const Text("stock Items will be shown here",
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
                            var id = snapshots.data!.docs[i].id;
                            Product x = Product.fromMap(data);
                            if (search.isEmpty) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 235, 235, 235)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Wrap(children: [
                                          Text(x.name.toString())
                                        ])),
                                    Expanded(
                                        flex: 2,
                                        child: Text(x.cost.toString())),
                                    Expanded(
                                        flex: 2,
                                        child: Text(x.stock.toString())),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () async {
                                              // todo here------------------------------------------------------------

                                              name.text = data["name"];
                                              cost.text =
                                                  data["cost"].toString();
                                              category.text =
                                                  data["category"].toString();
                                              stock.text =
                                                  data["stock"].toString();

                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return Dialog(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          children: [
                                                            Material(
                                                                child:
                                                                    TextField(
                                                              controller: name,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      "Product :",
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true),
                                                            )),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Material(
                                                                child: TextField(
                                                                    controller:
                                                                        cost,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "cost :",
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        filled:
                                                                            true))),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Material(
                                                                child: TextField(
                                                                    controller:
                                                                        stock,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: const InputDecoration(
                                                                        hintText:
                                                                            "stock :",
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        filled:
                                                                            true))),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                            .doc(id)
                                                                            .update({
                                                                          "name":
                                                                              name.text,
                                                                          "cost":
                                                                              int.parse(cost.text),
                                                                          "stock":
                                                                              int.parse(stock.text),
                                                                        });
                                                                        print(
                                                                            "added--------------");
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Update",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "lb",
                                                                            color:
                                                                                Colors.black),
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
                                            icon: Icon(
                                              Icons.edit,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ))),
                                  ],
                                ),
                              );
                            }
                            if (data['name']
                                .toString()
                                .toLowerCase()
                                .startsWith(search.toLowerCase())) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 235, 235, 235)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(x.name.toString())),
                                    Expanded(
                                        flex: 2,
                                        child: Text(x.cost.toString())),
                                    Expanded(
                                        flex: 2,
                                        child: Text(x.stock.toString())),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () async {
                                              name.text = data["name"];
                                              cost.text =
                                                  data["cost"].toString();
                                              category.text =
                                                  data["category"].toString();
                                              stock.text =
                                                  data["stock"].toString();

                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return Dialog(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          children: [
                                                            Material(
                                                                child:
                                                                    TextField(
                                                              controller: name,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Product :",
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true),
                                                            )),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Material(
                                                                child: TextField(
                                                                    controller:
                                                                        cost,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "cost :",
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        filled:
                                                                            true))),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Material(
                                                                child: TextField(
                                                                    controller:
                                                                        stock,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "stock :",
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        filled:
                                                                            true))),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (name.text != null &&
                                                                            cost.text !=
                                                                                null &&
                                                                            stock.text !=
                                                                                null) {
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection("products")
                                                                              .doc(id)
                                                                              .update({
                                                                            "name":
                                                                                name.text,
                                                                            "cost":
                                                                                int.parse(cost.text),
                                                                            "stock":
                                                                                int.parse(stock.text),
                                                                          });
                                                                          print(
                                                                              "added--------------");
                                                                          Get.back();
                                                                        } else {
                                                                          Get.snackbar(
                                                                              "No Product",
                                                                              "Plz fill all the fields");
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "ADD",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "lb",
                                                                            color:
                                                                                Colors.black),
                                                                      )),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ))),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          });
                },
              ),
            )
          ]),
        ));
  }
}
