import 'package:cart/screens/pages/search.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../controllers/functions.dart';

topdf(
    {required var name,
    required var gst,
    required url,
    required customer,
    required cnumber,
    required var compnayNumber,
    required var compnayUpi,
    required var compnayAddress,
    required var date}) async {
  final netImage = await networkImage(url);
  //  finding same object
  Cart a = Get.find();

  //  removing items with no value

  a.cart.removeWhere((key, value) => value == 0);

  //  start painting pdf
  Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
    final pdf = Document();
    var rang = PdfColor.fromHex("#B3B3B3");
    var blk = PdfColor.fromHex("#060606");
    var wyt = PdfColor.fromHex("#FFFFFF");
    pdf.addPage(MultiPage(
        maxPages: 30,
        margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
        mainAxisAlignment: MainAxisAlignment.start,
        build: (context) => [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                        horizontalRadius: 8,
                        verticalRadius: 8,
                        child: Image(netImage))),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text("${name}",
                      style:
                          TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
                  SizedBox(height: 2),
                  Text(gst.toString(),
                      style:
                          TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
                  SizedBox(height: 2),
                  Text("${compnayNumber.toString()}",
                      style:
                          TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
                  SizedBox(height: 2),
                  Text("${compnayAddress.toString()}",
                      style:
                          TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
                ])
              ]),
              SizedBox(height: 40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "RECIPENT",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                Text("Invoice",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ))
              ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Name :", style: TextStyle(color: rang)),
                  Text(cnumber.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  SizedBox(height: 5),
                  Text("Number :", style: TextStyle(color: rang)),
                  Text(customer.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text("date", style: TextStyle(color: rang)),
                  Text("${date.toString()}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  SizedBox(height: 5),
                  Text("Invoice No", style: TextStyle(color: rang)),
                  Text("CXRET426",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  SizedBox(height: 5),
                  Text("UPI", style: TextStyle(color: rang)),
                  Text("${compnayUpi.toString()}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                ])
              ]),
              SizedBox(height: 40),

              // todo header
              Table(
                  columnWidths: {
                    0: const FlexColumnWidth(2),
                    1: const FlexColumnWidth(4),
                    2: const FlexColumnWidth(4),
                    3: const FlexColumnWidth(4),
                  },
                  border: TableBorder.all(
                    color: PdfColors.grey100,
                  ),
                  // defaultColumnWidth: const FixedColumnWidth(150.0),
                  children: [
                    TableRow(
                        decoration:
                            BoxDecoration(color: PdfColor.fromHex("#f0f8ff")),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                                child: Text("S/No",
                                    style: TextStyle(fontSize: 15.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                                child: Text("Product",
                                    style: TextStyle(fontSize: 15.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                              "Quantity",
                              style: TextStyle(fontSize: 15.0),
                            )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(
                                child: Text("Cost",
                                    style: TextStyle(fontSize: 15.0))),
                          ),
                        ])
                  ]),
              // todo products
              ListView.builder(
                  itemCount: a.cart.length,
                  itemBuilder: ((context, index) {
                    var x = a.cart.keys.toList()[index].cost! *
                        a.cart.values.toList()[index];
                    var itemNumber = index + 1;
                    return Table(
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(4),
                          3: FlexColumnWidth(4),
                        },
                        defaultColumnWidth: FixedColumnWidth(150.0),
                        border: TableBorder.all(
                            color: PdfColors.grey100, style: BorderStyle.solid),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(7),
                              child: Center(
                                  child: Text(itemNumber.toString(),
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child: Center(
                                  child: Text(a.k.toList()[index].toString(),
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child: Center(
                                  child: Text(
                                a.v.toList()[index].toString(),
                                style: TextStyle(fontSize: 10.0),
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child: Center(
                                  child: Text(x.toString(),
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                          ]),
                        ]);
                  })),
              // todo products

              // todo total
              Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(4),
                    2: FlexColumnWidth(4),
                    3: FlexColumnWidth(4),
                  },
                  defaultColumnWidth: FixedColumnWidth(150.0),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                            child: Text("", style: TextStyle(fontSize: 15.0))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                            child: Text("-", style: TextStyle(fontSize: 15.0))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                            child: Text(
                          "Total ",
                          style: TextStyle(fontSize: 15.0),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                            child: Text(a.full.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ])
                  ]),
              Expanded(child: Container()),
              Container(
                  height: 70,
                  color: blk,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                                padding: EdgeInsets.only(left: 12, top: 12),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Developers Contact",
                                          style: TextStyle(
                                              color: wyt, fontSize: 18)),
                                      SizedBox(height: 5),
                                      Text("Phone : 7036727179",
                                          style: TextStyle(
                                              color: wyt, fontSize: 9)),
                                      Text("Mail : connectasifshail@gamail.com",
                                          style: TextStyle(
                                              color: wyt, fontSize: 9)),
                                    ]))),
                        VerticalDivider(color: rang),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text("THANK\nYOU!",
                                    style:
                                        TextStyle(color: wyt, fontSize: 22)))),
                      ]))
            ]));

    return pdf.save();
  });
}
