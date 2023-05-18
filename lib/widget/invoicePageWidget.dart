import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:camp_booking/model/customer_model.dart';
import 'package:camp_booking/model/invoice_model.dart';
import 'package:camp_booking/pdf_service/pdf_seervice..dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camp_booking/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class InvoicePageWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var details;
  InvoicePageWidget({super.key, required this.details});

  @override
  State<InvoicePageWidget> createState() => _InvoicePageWidgetState();
}

class _InvoicePageWidgetState extends State<InvoicePageWidget> {
  String filename = "invoice";
  final headers = [
    "Item",
    "Price",
    "Food Type[Veg/Non]",
    "No of Adults & childs",
    "Total Amount"
  ];
  final value = [];
  @override
  void initState() {
    print(widget.details);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 30,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => share(filename),
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                ))
          ]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              height(10),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Customer Details: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.details["email"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.details["name"]),
                          SizedBox(
                            width: size * 0.3,
                            child: Text('${widget.details["add"]}',
                                softWrap: true),
                          ),
                        ]),
                    invoiceDetail(size < 400 ? 12 : 16),
                  ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                height(10),
                Text("Invoice".toUpperCase(),
                    style: const TextStyle(fontSize: 20)),
                height(10),
                const Text("Description"),
              ]),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Container(
                          alignment: Alignment.center,
                          width: 140,
                          child: const Text(
                            "Item",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )),
                    ),
                    TableCell(
                      child: Container(
                        width: 140,
                        alignment: Alignment.center,
                        child: const Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        width: 140,
                        alignment: Alignment.center,
                        child: const Text(
                          "Food Type",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        width: 140,
                        alignment: Alignment.center,
                        child: const Text(
                          "No of Adults & childs",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        width: 140,
                        alignment: Alignment.center,
                        child: const Text(
                          "Total Amount",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 40,
                      child: const Text("Id93864723"),
                    )),
                    TableCell(
                        child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 40,
                      child: Text(widget.details["price"]),
                    )),
                    TableCell(
                        child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 40,
                      child: Text(widget.details["foodType"]),
                    )),
                    TableCell(
                        child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 40,
                      child: Text(
                          "${widget.details["adult"]},${widget.details["chisld"]}"),
                    )),
                    TableCell(
                        child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 40,
                      child: Text(widget.details["total"]),
                    )),
                  ])
                ],
              ),
            ),
            const Divider(),
            height(10),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      text(
                          title: "Total Amount",
                          value: widget.details["total"]),
                      text(
                          title: "Advance Amount",
                          value: widget.details["advance"]),
                      height(10),
                      const Divider(
                        thickness: 0.4,
                        height: 2,
                        color: Colors.black,
                      ),
                      const Divider(
                        thickness: 0.4,
                        height: 2,
                        color: Colors.black,
                      ),
                      height(5),
                      text(
                          title: "Remaining",
                          value: (double.parse(widget.details["total"]) -
                                  double.parse(widget.details["advance"]))
                              .toString()),
                      height(5),
                      const Divider(
                        thickness: 0.4,
                        height: 2,
                        color: Colors.black,
                      ),
                      const Divider(
                        thickness: 0.4,
                        height: 2,
                        color: Colors.black,
                      ),
                    ],
                  )),
            ),
            height(10),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(40, 40)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Edit Customer".toUpperCase()))),
            height(5),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(40, 40)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("pay Advance")));
                    },
                    child: const Text("Pay Advancce"))),
            height(5),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(40, 40)),
                    onPressed: () {
                      goToPdf();
                    },
                    child: const Text("Download"))),
          ],
        )),
      ),
    );
  }

  share(filename) async {
    if (kIsWeb) {
      String url = "https://www.vnsgu.ac.in/Old%20Question%20Papers/Old%20Question%20Papers/EXAM%20PAPER%20FOR%202020%20YEAR/Science%20-%202019/BCA-2019/B.C.A.%20(Sem-VI)%20-2019/B.C.A.(Sem.VI)%20Examination%20Oct.Nov.-2019%20-%20602-E-Commerce%20&%20Cyber%20Secu..pdf";
      var response = await http.get(Uri.parse(url));
  var bytes = response.bodyBytes;
  var fileName = url.split('/').last;
  var tempDir = await getTemporaryDirectory();
  var filePath = '${tempDir.path}/$fileName';
  File file = File(filePath);
  await file.writeAsBytes(bytes);

  Share.shareFiles([filePath], text: 'Check out this PDF!');

    } else {
      final directory = await getApplicationDocumentsDirectory();
      Share.shareFiles(['${directory.path}/$filename.pdf'],
          text: "Invoice of Booking Camp");
    }
  }

    goToPdf() {
    PdfService.saveAndOpenPdf(
        context,
        Invoice(
            customer: Customer(
                name: widget.details["name"],
                address: widget.details["add"],
                email: widget.details["email"],
                mobNo: widget.details["mobile"],
                date: widget.details["bookingDate"]),
            item: [
              InvoiceItem(
                  price: double.parse(widget.details["price"]),
                  campName: widget.details["campName"],
                  noOfChild: int.parse(widget.details["child"]),
                  noOfAdult: int.parse(widget.details["adult"]),
                  foodType: widget.details["foodType"].toString())
            ]),
        filename);
  }

  invoiceDetail(double size) {
    final title = [
      "Invoice Number: ",
      "Invoice Date: ",
      "Payment Terms: ",
      "Due Date: "
    ];
    final data = [
      "Id1223230",
      widget.details["bookingDate"],
      "5 days",
      "${DateTime.now().day}/${DateTime.now().month},/${DateTime.now().year}"
    ];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(title.length, (index) {
          return text(
              titleStyle:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: size),
              childStyle: TextStyle(fontSize: size * 0.9),
              title: title[index],
              value: data[index],
              width: MediaQuery.of(context).size.width * 0.3);
        }));
  }

  text(
      {required String title,
      required String value,
      double width = double.infinity,
      TextStyle? titleStyle,
      TextStyle? childStyle,
      bool unite = false}) {
    final style = titleStyle ?? const TextStyle(fontWeight: FontWeight.bold);
    return SizedBox(
        width: width,
        child: Row(children: [
          Expanded(child: Text(title, style: style)),
          Text(
            value,
            style: unite ? style : childStyle,
            softWrap: true,
          )
        ]));
  }
}
