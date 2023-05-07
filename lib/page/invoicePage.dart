import 'package:camp_booking/page/pdfFile.dart';
import 'package:flutter/material.dart';
import '../constants/constant.dart';

class Invoice extends StatefulWidget {
  var details;
  Invoice({required this.details});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  void initState() {
    print(widget.details);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              "Invoice of Booking Camp",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            )),
            height(30),
            const Text("TO:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            height(10),
            Text.rich(TextSpan(
                text: "Name:",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  TextSpan(
                    text: widget.details["name"],
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  )
                ])),
            Text.rich(TextSpan(
                text: "Email:",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  TextSpan(
                    text: widget.details["email"],
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  )
                ])),
            Text.rich(TextSpan(
                text: "Address:",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  TextSpan(
                    text: widget.details["add"],
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  )
                ])),
            Text.rich(TextSpan(
                text: "Booking DateTime:",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  TextSpan(
                    text: widget.details["date"],
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  )
                ])),
            Text.rich(TextSpan(
                text: "Mobile No.:",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  TextSpan(
                    text: widget.details["mobile"],
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  )
                ])),
            height(25),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(width: 0.5),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      "Item",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
                  TableCell(
                      child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
                  TableCell(
                      child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      "People",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
                  TableCell(
                      child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      "Total Amount",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            widget.details["campName"],
                            textAlign: TextAlign.center,
                          ))),
                  TableCell(
                      child: Center(
                          child: Text(
                              "${widget.details["price"]},${widget.details["childPrice"]}"))),
                  TableCell(
                      child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                        "${widget.details["adult"]},${widget.details["child"]}"),
                  )),
                  TableCell(
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(widget.details["total"]))),
                ]),
              ],
            ),
            height(15),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: size < 600 ? 200 : 400,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      const TableCell(
                          child: Center(
                        child: Text(
                          "Total Amount",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                      TableCell(
                          child: Center(child: Text(widget.details["total"])))
                    ]),
                    TableRow(children: [
                      const TableCell(
                          child: Center(
                        child: Text(
                          "Advance",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                      TableCell(
                          child: Center(
                              child: Text((double.parse(
                                          widget.details["total"].toString()) /
                                      1.75)
                                  .toString())))
                    ]),
                    TableRow(children: [
                      const TableCell(
                          child: Center(
                        child: Text(
                          "Remaining",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                      TableCell(
                          child: Center(
                              child: Text(
                                  ((double.parse(widget.details["total"])) -
                                          (double.parse(widget.details["total"]
                                                  .toString()) /
                                              1.75))
                                      .toString())))
                    ]),
                  ],
                ),
              ),
            ),
            height(20),
            const Text(
              "We are only collecting Advance Payment, Remaning Account will have to pay at the of check in.",
              textAlign: TextAlign.center,
            ),
            height(10),
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 200, 200),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                "Due to heavy traffic payment gateway is down but still you can reserve your tent with us, free feel to call us on the below number and book your tent.",
                textAlign: TextAlign.center,
              ),
            ),
            height(10),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      nextScreen(context, PDFExample());
                    },
                    child: const Text("Pay Advancce"))),
            height(20),
          ],
        )),
      ),
    );
  }
}
