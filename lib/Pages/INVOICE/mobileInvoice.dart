import 'package:camp_booking/constant.dart';
import '../../Widgets/invoicePageWidget.dart';
import 'package:flutter/material.dart';

class MobileInvoice extends StatelessWidget {
  var details;
  MobileInvoice({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer(context),
      body: InvoicePageWidget(details: details),
    );
  }
}
