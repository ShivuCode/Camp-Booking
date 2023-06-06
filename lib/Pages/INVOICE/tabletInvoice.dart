import 'package:camp_booking/Models/customer_model.dart';

import '../../Widgets/invoice.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

// ignore: must_be_immutable
class TabletInvoice extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  Customer customer;
  TabletInvoice({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: myDrawer(context),
      body: InvoicePageWidget(
        customer: customer,
      ),
    );
  }
}
