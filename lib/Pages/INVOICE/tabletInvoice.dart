import '../../Widgets/invoicePageWidget.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

// ignore: must_be_immutable
class TabletInvoice extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var details;
  TabletInvoice({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer(context),
      body: InvoicePageWidget(details: details),
    );
  }
}
