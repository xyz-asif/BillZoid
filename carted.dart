import 'package:badges/badges.dart';
import 'package:cart/screens/maintain/imports.dart';
import 'package:cart/screens/maintain/navigation.dart';
import 'package:cart/screens/pages/search.dart';
import 'package:flutter/cupertino.dart';

class P extends StatelessWidget {
  TextEditingController cName = TextEditingController();
  TextEditingController cNumber = TextEditingController();

  Widget build(BuildContext context) {
      

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Cart a = Get.find();
    
    return SafeArea(
      
      child: Scaffold(
                appBar: AppBar(
          actions: [
   Padding(
     padding:  EdgeInsets.only(right:w/11),
     child: Center(child: Text("Cart",style: TextStyle(fontFamily: "lr",fontSize: 24),)),
   )
          ],
        ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        width: w / 2.8,
                        child: Column(
                          children: [
                            Text(
                              "total :",
                              style:
                                  TextStyle(fontFamily: "pr", fontSize: h / 40),
                            ),
                            Obx(() => Text(
                                  "₹ ${a.full.toString()}",
                                  style: TextStyle(
                                      fontFamily: "lb", fontSize: h / 34),
                                )),
                          ],
                        )),
                    Expanded(child: Container()),
                 
                  ],
                ),

                SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    Container(
                        width: w / 2.8,
                        child: TextField(
                          controller: cName,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 14),
                              hintText: "Name",
                              suffixIcon: Icon(
                                Icons.account_box_outlined,
                              )),
                        )),
                    Expanded(child: Container()),
                    Container(
                        width: w / 2.8,
                        child: TextField(
                                inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
                          keyboardType: TextInputType.number,
                          controller: cNumber,
                          decoration: InputDecoration(
                            
                              hintStyle: TextStyle(fontSize: 14),
                              hintText: "Number",
                              suffixIcon: Icon(
                                Icons.phone_android_rounded,
                              )),
                        )),
                  ],
                ),

                SizedBox(
                  height: 15,
                ),

                Flexible(
                  flex: 1,
                  //  height: h/1.30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ,
                  child: a.cart == null || a.full == 0
                      ? Center(
                          child: Lottie.asset(
                            'assets/empty.zip',
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        )
                      : ListView.builder(
                          itemCount: a.k.length,
                          itemBuilder: (_, index) {
                            var k = a.k[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 15),
                              child: Container(
                                height: h / 7,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFB98434),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                 ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: h / 50, top: h / 70),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // here
                                          Flexible(
                                            child: Text(
                                              k.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'peb',
                                                  fontSize: h / 38),
                                            ),
                                          ),
                                          Container(
                                            height: h / 25,
                                            width: w / 4.5,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const [
                                                Text(
                                                  "stock",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "cost",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            height: h / 25,
                                            width: w / 4.5,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(k.stock.toString(),
                                                    style: const TextStyle(
                                                        fontFamily: 'lb',
                                                        fontSize: 13)),
                                                Text(k.cost.toString(),
                                                    style: const TextStyle(
                                                        fontFamily: 'lb',
                                                        fontSize: 13)),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: h / 60.0, right: w / 30),
                                          child: Container(
                                            height: h / 21,
                                            width: w / 2.5,
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      // a.minus(k);
                                                      a.minus(k);
                                                      a.total();
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    )),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, bottom: 10),
                                                  child: VerticalDivider(
                                                      color: Color.fromARGB(
                                                          255, 92, 87, 87)),
                                                ),
                                                Obx(() =>  a.v[index] == null
                                                    ? const Text("0")
                                                    : Text(
                                                        a.v[index].toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, bottom: 10),
                                                  child: VerticalDivider(
                                                      color: Color.fromARGB(
                                                          255, 92, 87, 87)),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      a.increment(k);
                                                      a.total();
                                                    },
                                                    icon: const Icon(Icons.add,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),

                // bottom-------------------

                Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();

                          if(cName.text.isNotEmpty && cNumber.text.isNotEmpty){
                                                        Get.dialog(Center(
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  alignment: Alignment.center,
                                  child: Lottie.asset(
                                    'assets/loading.zip',
                                    height: 125,
                                    //  fit: BoxFit.fill,
                                  ),
                                ),
                              ));
                              a.change();
                              a.bill(cName.text, a.full.value,
                                  int.parse(cNumber.text));

                              // todo validation
                              await a.make(
                                  name: cName.text,
                                  number: int.parse(cNumber.text));
                              Get.back();
                          }else{
                             Get.snackbar("Empty Field", "Please Enter All Fields");
                          }
                            },
                            child: Text(
                              "Invoice",
                              style: TextStyle(fontFamily: "pb"),
                            ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(12),
                                backgroundColor: Colors.black),
                          )),
                      ElevatedButton(
                        onPressed: () {
                          // here

                          Get.to( MyApp());

                          a.full.value = 0;
                          Future.delayed(Duration(seconds: 1), () {
                            a.cart.clear();
                          });
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Color(0xFFB98434),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}














































// Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(k.toString()),
//                                   Text(k.cost.toString()),
//                                   Text(k.stock.toString()),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       a.increment(k);
                                  //       a.total();
                                  //     },
                                  //     icon: const Icon(Icons.add)),
                                //  Obx(() => a.v[index] == null
                                //      ? const Text("0")
                                //      : Text(a.v[index].toString())),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       a.minus(k);
                                  //       a.total();
                                  //     },
                                  //     icon: const Icon(Icons.remove)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );