import 'package:camp_booking/constant.dart';

import 'package:flutter/material.dart';

import '../../Models/customer_model.dart';
import '../../Widgets/invoicePageWidget.dart';

class LaptopInvoice extends StatelessWidget {
  Customer customer;
  LaptopInvoice({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        myDrawer(context),
        Expanded(child: InvoicePageWidget(customer: customer))
      ]),
    );
  }
}
