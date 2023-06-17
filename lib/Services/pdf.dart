import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Models/customer_model.dart';

class PdfService {
  static Future<String> generatePDF(Customer customer) async {
    if (await Permission.storage.request().isGranted) {
      final pdf = Document();
      pdf.addPage(MultiPage(
        header: (context) => header(),
        footer: (context) => footer(),
        build: (context) => [
          SizedBox(height: 30),
          formTo(customer),
          SizedBox(height: 30),
          builtItemTable(customer),
          Divider(),
          SizedBox(height: 10),
          Row(children: [
            Expanded(child: builtTerms()),
            Expanded(child: builtTotal(customer)),
            SizedBox(width: 5)
          ]),
          SizedBox(height: 20),
        ],
      ));

      final directory = (await getExternalStorageDirectories(
              type: StorageDirectory.downloads))!
          .first;
      final file = File('${directory.path}/invoice.pdf');

      await file.writeAsBytes(await pdf.save());

      Fluttertoast.showToast(msg: "Download", gravity: ToastGravity.BOTTOM);
      return file.path;
    } else {
      Fluttertoast.showToast(
          msg: "We can't download", gravity: ToastGravity.BOTTOM);

      return '';
    }
  }
}

header() => Container(
    alignment: Alignment.center,
    child: Column(children: [
      Text("Pawna Camp",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      Text(
          "Biling Address:S. No 59, at. Ambegaon, Beside PawnaNagar, Lonavala Rd, O,Pawna Nagar, Pune, Maharastra, 410406",
          style: const TextStyle(fontSize: 8)),
      SizedBox(height: 10),
      builtBarcode(),
      Divider()
    ]));

footer() => Container(
        child: Column(children: [
      Divider(color: PdfColors.black, thickness: 0.3),
      SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Website link: "),
        Text("https://pawnacamp.in",
            style: const TextStyle(color: PdfColors.blue))
      ]),
      Text("Contact: 9922664640")
    ]));

builtBarcode() => Row(children: [
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Invoice of Booking",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text("Email: contact@pawnacamp.in"),
        Text("Mobile: +91 9922664660")
      ])),
      SizedBox(width: 20),
      Expanded(
          child: Row(children: [
        BarcodeWidget(
            data: '7575829797',
            barcode: Barcode.qrCode(),
            width: 50,
            height: 50),
        SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          text("Date:", "2023-05-19"),
          text("Order Id:", "PO49326423942")
        ])
      ]))
    ]);

formTo(Customer customer) =>
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Form :",
            style: TextStyle(fontBold: Font.courierBold(), fontSize: 13)),
        SizedBox(height: 10),
        text("Address: ",
            "Biling Address:S. No 59, at.Ambegaon, Beside PawnaNagar, Lonavala Rd, O,Pawna Nagar, Pune, Maharastra, 410406"),
        SizedBox(height: 3),
        text("Contact: ", "+91 9922664660")
      ])),
      SizedBox(width: 5),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Customer :",
            style: TextStyle(fontBold: Font.courierBold(), fontSize: 13)),
        SizedBox(height: 10),
        text('Customer ID: ', customer.id.toString()),
        text("Customer Name: ", customer.name),
        text("Address: ", customer.address),
        text("Booking Date:", customer.bookingDate),
        text("Mode:", "Online"),
      ]))
    ]);

text(label, value) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              softWrap: true,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          SizedBox(
              width: 150,
              child: Text(
                value,
                softWrap: true,
                style: const TextStyle(fontSize: 11),
              )),
          SizedBox(height: 5)
        ]);

builtItemTable(Customer customer) {
  final headers = [
    "Item",
    "Fee",
    "No of Adults & childs",
    "GroupType",
    "Total Amount"
  ];
  final data = [
    [
      "Lonawala",
      customer.price.toString(),
      "${customer.adult},${customer.child}",
      customer.groupType,
      (customer.price * customer.adult +
              ((customer.price * 0.45) * customer.child))
          .toString()
    ]
  ];
  return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerAlignment: Alignment.center,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerLeft,
        3: Alignment.centerRight,
        4: Alignment.centerRight
      });
}

builtTotal(Customer customer) {
  final total = (customer.price * customer.adult +
      ((customer.price * 0.45) * customer.child));
  final rem = (total - customer.advAmt).toStringAsFixed(2);
  return Container(
      child: Row(children: [
    Spacer(flex: 6),
    Expanded(
        flex: 4,
        child: Column(children: [
          text("Total Amount", total.toString()),
          text("Advance", customer.advAmt.toString()),
          Divider(color: PdfColors.black),
          text("Remaining", rem.toString()),
          Divider(color: PdfColors.black),
        ]))
  ]));
}

builtTerms() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Terms & Condition",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      SizedBox(height: 3),
      Text("1) Cancelation Will be accepted before 2 days.",
          style: const TextStyle(fontSize: 10)),
      SizedBox(height: 3),
      Text(
          "2) Cancelation charges will be 15% in case you cancel on last booking date.",
          style: const TextStyle(fontSize: 10)),
      SizedBox(height: 3),
      Text(
          "3) Due to any external issues if event get cancel we will refund all the booking amount.",
          style: const TextStyle(fontSize: 10))
    ]);
