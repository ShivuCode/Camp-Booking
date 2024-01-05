import 'package:camp_booking/Models/vendor_model.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/Services/database.dart';
import 'package:camp_booking/Services/pdfDownload.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../Models/customer_model.dart';

class PdfService {
  static String filename = '';
  static Future<String> generatePDF(context, Customer customer) async {
    filename = customer.name;
    int id = await DbHelper.getId();
    final data = await ApiService.fetchVendorId(id);
    Vendor vendor = Vendor.fromJson(data);
    bool vendorForm = false;
    if (await ApiService.venderExists(id) && vendor.ownerName.isNotEmpty) {
      vendorForm = true;
    }
    final pdf = Document();
    pdf.addPage(MultiPage(
      header: (context) => header(customer, vendor, vendorForm),
      footer: (context) => footer(vendor, vendorForm),
      build: (context) => [
        SizedBox(height: 30),
        formTo(customer, vendor, vendorForm),
        SizedBox(height: 30),
        builtItemTable(customer),
        Divider(),
        SizedBox(height: 10),
        Row(children: [
          Expanded(child: builtTerms()),
          Expanded(child: builtTotal(customer)),
          SizedBox(width: 5)
        ]),
        SizedBox(height: 10),
        builtNote(customer.noteSection),
        SizedBox(height: 20),
      ],
    ));
    if (kIsWeb) {
      pdf.save();
      return '';
    } else {
      return await downloadPdf(context, filename, pdf);
    }
  }
}

header(Customer customer, Vendor vendor, vendorForm) => Container(
    alignment: Alignment.center,
    child: Column(children: [
      Text(vendorForm ? vendor.organizationName : "Pawna Camp",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      Text(
          vendorForm
              ? vendor.address
              : "Biling Address:S. No 59, at. Ambegaon, Beside PawnaNagar, Lonavala Rd, O,Pawna Nagar, Pune, Maharastra, 410406",
          style: const TextStyle(fontSize: 8)),
      SizedBox(height: 10),
      builtBarcode(customer, vendor, vendorForm),
      Divider()
    ]));

footer(Vendor vendor, bool venform) => venform
    ? Container(
        child: Column(children: [
        Divider(color: PdfColors.black, thickness: 0.3),
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Website link: "),
          Text(vendor.website, style: const TextStyle(color: PdfColors.blue))
        ]),
        Text("Contact: ${vendor.mobile}")
      ]))
    : Container(
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

builtBarcode(Customer cust, Vendor ven, vendorform) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text("Invoice of Booking",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(vendorform ? ven.email : "Email: contact@pawnacamp.in"),
                Text(vendorform ? ven.mobile : "Mobile: +91 9922664660")
              ])),
          SizedBox(width: 20),
          Expanded(
              child: Row(children: [
            BarcodeWidget(
                data:
                    'Customer: ${cust.name}\nAdults: ${cust.adult}\nPaid: ${cust.advAmt}\nRemaining Amount: ${((cust.adult * cust.price) + (cust.child * (cust.price / 2))) - cust.advAmt}\nCustomer No. ${cust.mobNo}\nOwrner:${ven.ownerName}',
                barcode: Barcode.qrCode(),
                width: 50,
                height: 50),
            SizedBox(width: 10),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text("Date:",
                      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"),
                  text("Order Id:", "PO49326423942"),
                  text('', ''),
                  text('', ''),
                  text('', ''),
                ])
          ]))
        ]);

formTo(Customer customer, Vendor vendor, vendorForm) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: builtFrom(vendor, vendorForm)),
          SizedBox(width: 5),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text("Customer Details",
                    style:
                        TextStyle(fontBold: Font.courierBold(), fontSize: 13)),
                SizedBox(height: 5),
                text('Customer ID: ', customer.id.toString()),
                text("Customer Name: ", customer.name),
                text("Address: ", customer.address),
                text("Booking Date:", customer.bookingDate.split("T")[0]),
                text("Mobile:", customer.mobNo),
                text("Food Type",
                    "Veg:${customer.vegPeopleCount}/ Non-Veg:${customer.nonVegPeopleCount}"),
                text("Mode:", "Online"),
              ]))
        ]);

builtFrom(Vendor vendor, vendorForm) {
  if (vendorForm) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("${vendor.organizationName} :",
          style: TextStyle(fontBold: Font.courierBold(), fontSize: 13)),
      SizedBox(height: 10),
      text("Owner name: ", vendor.ownerName),
      SizedBox(height: 4),
      text("Address: ", vendor.address),
      SizedBox(height: 4),
      text("Contact: ", vendor.mobile),
      SizedBox(height: 4),
      text("Website", vendor.website),
      SizedBox(height: 4),
      text("", "")
    ]);
  } else {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("PawnaCamp:",
          style: TextStyle(fontBold: Font.courierBold(), fontSize: 13)),
      SizedBox(height: 10),
      text("Address: ",
          "Pawna Camp. S. No 59, at.Ambegaon, Beside PawnaNagar, Lonavala Rd, O,Pawna Nagar, Pune, Maharastra, 410406"),
      SizedBox(height: 4),
      text("Contact: ", "+91 9922664660"),
      SizedBox(height: 4),
      text("Website", "https://pawnacamp.in"),
      SizedBox(height: 4),
      text("", "")
    ]);
  }
}

text(label, value) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              softWrap: true,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          SizedBox(
              width: 150,
              child: Text(
                value,
                softWrap: true,
                style: const TextStyle(fontSize: 9),
              )),
          SizedBox(height: 6)
        ]);

builtItemTable(Customer customer) {
  final headers = [
    "Item",
    "Fee",
    "Adults & childs",
    "GroupType",
    "Total Amount"
  ];
  final data = [
    [
      "Tent Camping",
      customer.price.toString(),
      "${customer.adult},${customer.child + customer.freeKid}",
      customer.groupType,
      (customer.price * customer.adult +
              ((customer.price / 2) * customer.child))
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
      ((customer.price / 2) * customer.child));
  final rem =
      ((total - customer.advAmt) - customer.discount).toStringAsFixed(2);
  return Container(
      child: Row(children: [
    Spacer(flex: 6),
    Expanded(
        flex: 5,
        child: Column(children: [
          text("Total Amount", total.toString()),
          text("Advance", customer.advAmt.toString()),
          if (customer.discount > 0)
            text("Discount", customer.discount.toString()),
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
          "2) Cancelation charges will be 30% in case you cancel on last booking date.",
          style: const TextStyle(fontSize: 10)),
      SizedBox(height: 3),
      Text(
          "3) Due to any external issues if event get cancel we will refund all the booking amount.",
          style: const TextStyle(fontSize: 10)),
      SizedBox(height: 3),
      Text(
          "4) Advance amount of new year booking is non-refundable in case of cancellation.",
          style: const TextStyle(fontSize: 10))
    ]);

builtNote(String note) => note.isNotEmpty
    ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Note", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 3),
        Text(note)
      ])
    : Text("");
