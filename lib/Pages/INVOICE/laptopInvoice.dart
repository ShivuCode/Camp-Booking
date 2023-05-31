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
      backgroundColor: Colors.white,
      body: Row(children: [
        myDrawer(context),
        const VerticalDivider(
          thickness: 0.1,
          color: Colors.grey,
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: InvoicePageWidget(customer: customer),
        ))
      ]),
    );
  }
}
