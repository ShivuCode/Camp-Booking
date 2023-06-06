import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/constant.dart';
import '../../Widgets/invoice.dart';
import 'package:flutter/material.dart';

class MobileInvoice extends StatelessWidget {
  Customer customer;
  MobileInvoice({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: myDrawer(context),
      body: InvoicePageWidget(customer: customer),
    );
  }
}
