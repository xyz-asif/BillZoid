import 'package:cart/screens/maintain/imports.dart';
import 'package:flutter/cupertino.dart';

class Invoices extends StatefulWidget {
  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  String name = "";

  @override
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
                "Invoices",
                style: TextStyle(fontFamily: "lr", fontSize: 24),
              )),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                left: w / 10, right: w / 10, top: 17, bottom: 15),
            child: Container(
              height: h / 12,
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
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bills')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection("invoices")
                  .snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting) ||
                        snapshots.data?.docs.isEmpty == true
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "E M P T Y",
                              style: TextStyle(color: Colors.black26),
                            ),
                            const Text("payed bills will be shown here",
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

                          if (name.isEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, right: 28),
                              child: Container(
                                height: h / 6.3,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFB98434),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(118, 75, 75, 77),
                                          spreadRadius: 5,
                                          blurRadius: 24,
                                          offset: Offset(4, 12))
                                    ]),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data["amount"].toString()),
                                          SizedBox(
                                            height: h / 35,
                                          ),
                                          Text(
                                            data["customer"].toString(),
                                            style: TextStyle(
                                                fontSize: h / 26,
                                                fontFamily: "lb"),
                                          ),
                                          Text(
                                              "Phone : ${data["phone"].toString()}")
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Invoice : 4563"),
                                            Text(
                                              data["amount"].toString(),
                                              style: TextStyle(
                                                  fontFamily: "lb",
                                                  fontSize: h / 26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 25,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (data['customer']
                              .toString()
                              .toLowerCase()
                              .startsWith(name.toLowerCase())) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, right: 28),
                              child: Container(
                                height: h / 6.3,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFB98434),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(118, 75, 75, 77),
                                          spreadRadius: 5,
                                          blurRadius: 24,
                                          offset: Offset(4, 12))
                                    ]),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data["amount"].toString()),
                                            SizedBox(
                                              height: h / 34,
                                            ),
                                            Text(
                                              data["customer"].toString(),
                                              style: TextStyle(
                                                  fontSize: h / 26,
                                                  fontFamily: "lb"),
                                            ),
                                            Text(
                                                "Phone : ${data["phone"].toString()}")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Invoice : 4563"),
                                            Text(
                                              data["amount"].toString(),
                                              style: TextStyle(
                                                  fontFamily: "lb",
                                                  fontSize: h / 26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 25,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        });
              },
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ]));
  }
}


// Billy(amount: data["amount"], customer: data["customer"], date: "ghf", phone: data["phone"])