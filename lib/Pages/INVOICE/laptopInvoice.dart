import 'package:camp_booking/constant.dart';

import 'package:flutter/material.dart';

import '../../Widgets/invoicePageWidget.dart';

class LaptopInvoice extends StatelessWidget {
  var details;
  LaptopInvoice({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        myDrawer(context),
        Expanded(child: InvoicePageWidget(details: details))
      ]),
    );
  }
}
