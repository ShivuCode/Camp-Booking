import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart';
import 'package:camp_booking/constant.dart';
import '../Models/customer_model.dart';
import '../Pages/pdfView.dart';

class PdfService {
  static Future<void> saveAndOpenPdf(context, customer, fileName) async {
    // Generate the PDF file
    final pdfBytes = await generatePdf(customer);

    if (kIsWeb) {
      // String url ="url";
      // try {
      //   var response = await http.get(Uri.parse(url));
      //   var bytes = response.bodyBytes;
      //   var fileName = url.split('/').last;
      //   var anchor = html.AnchorElement(
      //     href: 'data:application/octet-stream;base64,${base64.encode(bytes)}',
      //   )..setAttribute('download', fileName);

      //   html.document.body?.append(anchor);
      //   anchor.click();
      //   anchor.remove();
      // } catch (e) {
      //   print(e);
      // }
      if (kDebugMode) {
        print("web download complete");
      }
    } else {
      // Save the PDF file to the Android device
      final directory = await getExternalStorageDirectory();
      final file = io.File('${directory?.path}/$fileName.pdf');
      try {
        await file.writeAsBytes(pdfBytes);

        nextScreen(context, PdfViewer(path: file.path));

        // Open the PDF file using the default PDF viewer on the device
      } catch (e) {}
    }
  }

  // Function to generate the PDF file
  static Future<List<int>> generatePdf(Customer customer) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        header: (context) => builtHeader(customer),
        build: (context) => [
              SizedBox(height: 30),
              builtItemTable(customer),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 5),
              builtTotal(customer),
            ],
        footer: (context) => buildFooter(customer)));

    return pdf.save();
  }

  static builtHeader(Customer customer) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // builtSupplier(customer),
          Container(
              height: 50,
              width: 50,
              child: BarcodeWidget(
                  data: "o23748298386", barcode: Barcode.qrCode()))
        ]),
        SizedBox(height: 30),
        builtTile(customer),
        // SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [builtCustomer(customer), builtcustomerInfo(customer)]),
      ]);

  //built customer Information
  static builtcustomerInfo(Customer customer) {
    final title = [
      "customer Number: ",
      "customer Date: ",
      "Payment Terms: ",
      "Due Date: "
    ];
    final data = [
      "Id1223230",
      customer.bookingDate,
      "5 days",
      DateTime.now().toString()
    ];
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(title.length, (index) {
          return builtText(title: title[index], value: data[index], width: 200);
        }));
  }

//customer address
  static builtCustomer(Customer customer) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(customer.email, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text('${customer.address}', softWrap: true),
      ]);

  // //supplier details
  // static builtSupplier(customer customer) =>
  //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       Text("suppilerName", style: TextStyle(fontWeight: FontWeight.bold)),
  //       SizedBox(height: 1 * PdfPageFormat.mm),
  //       Text("suppilerAddress"),
  //       Text("No. 0949687830", style: const TextStyle(fontSize: 10))
  //     ]);

  //heading
  static builtTile(Customer customer) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10),
        Text("customer".toUpperCase(),
            style: TextStyle(fontSize: 20, fontBold: Font.courier())),
        SizedBox(height: 10),
        Text("Description"),
      ]);

//customer information
  static builtItemTable(Customer customer) {
    final headers = [
      "Item",
      "Price",
      "Food Type[Veg/Non]",
      "No of Adults & childs",
      "Total Amount"
    ];
    final data = [
      [
        "Lonawala",
        customer.price,
        '${customer.vegPeopleCount}/${customer.nonVegPeopleCount}',
        '${customer.adult},${customer.child}',
        ((customer.price * customer.adult) +
            ((customer.price / 0.8) * customer.child))
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

  //built total secton
  static builtTotal(Customer customer) {
    final total =
        ((customer.price * customer.adult) + (customer.price * customer.child));
    final adv = customer.price / 1.25;
    final rem = (total - adv).toStringAsFixed(2);
    return Container(
        child: Row(children: [
      Spacer(flex: 6),
      Expanded(
          flex: 4,
          child: Column(children: [
            builtText(
                title: "Total Amount", value: total.toString(), unite: true),
            builtText(title: "Advance", value: adv.toString(), unite: true),
            Divider(),
            builtText(title: "Remaining", value: rem.toString()),
            Divider()
          ]))
    ]));
  }

//built Text
  static builtText(
      {required String title,
      required String value,
      double width = double.infinity,
      TextStyle? titleStyle,
      bool unite = false}) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
    return Container(
        width: width,
        child: Row(children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null)
        ]));
  }

//create footer of pdf
  static buildFooter(Customer customer) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Divider(),
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Address: ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 2 * PdfPageFormat.mm),
          Text("Surat")
        ]),
        SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Paypal", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 2 * PdfPageFormat.mm),
          Text("https://payapal.me/sarahfieldzz")
        ]),
      ]);
}
