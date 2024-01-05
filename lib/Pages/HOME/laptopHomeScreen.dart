// ignore: file_names
import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Pages/CAMP/addCamp.dart';
import 'package:camp_booking/Pages/CAMP/editCamp.dart';

import 'package:camp_booking/Pages/REPORT/report.dart';
import 'package:camp_booking/Pages/SEARCH/search.dart';
import 'package:camp_booking/Pages/VENDOR/editVendor.dart';
import 'package:camp_booking/Pages/VENDOR/form.dart';

import 'package:camp_booking/Services/database.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../../Models/vendor_model.dart';
import '../../Widgets/booking.dart';
import '../CAMP/home.dart';

// ignore: must_be_immutable
class LaptopHomeScreen extends StatefulWidget {
  String? pos;
  Camp? camp;
  Customer? customer;
  Vendor? vendor;
  LaptopHomeScreen(
      {super.key, this.pos, this.camp, this.customer, this.vendor});

  @override
  State<LaptopHomeScreen> createState() => _LaptopHomeScreenState();
}

class _LaptopHomeScreenState extends State<LaptopHomeScreen> {
  int id = 0;

  role() async {
    id = await DbHelper.roleId();
    setState(() {});
    if (kDebugMode) {
      print("get id $id");
    }
  }

  @override
  void initState() {
    role();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pos == 'booking') {
      if (widget.camp != null) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Row(
              children: [
                myDrawer(context, id),
                const VerticalDivider(
                  width: 0.1,
                  color: Colors.grey,
                ),
                Expanded(child: BookingPage(camp: widget.camp)),
              ],
            ));
      } else {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Row(
              children: [
                myDrawer(context, id),
                const VerticalDivider(
                  width: 0.1,
                  color: Colors.grey,
                ),
                Expanded(child: BookingPage(customer: widget.customer)),
              ],
            ));
      }
    } else if (widget.pos == 'search') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context, id),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: Invoice()),
        ],
      ));
    } else if (widget.pos == 'report') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context, id),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: Report())
        ],
      ));
    } else if (widget.pos == 'vendorForm') {
      if (widget.vendor == null) {
        return Scaffold(
            body: Row(
          children: [
            myDrawer(context, id),
            const VerticalDivider(
              width: 0.1,
              color: Colors.grey,
            ),
            Expanded(child: VendorForm())
          ],
        ));
      } else {
        return Scaffold(
            body: Row(
          children: [
            myDrawer(context, id),
            const VerticalDivider(
              width: 0.1,
              color: Colors.grey,
            ),
            Expanded(child: VendorForm(vendor: widget.vendor))
          ],
        ));
      }
    } else if (widget.pos == 'editVendor') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context, id),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: EditVendor())
        ],
      ));
    } else if (widget.pos == 'addCamp') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context, id),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          Expanded(child: AddCamp())
        ],
      ));
    } else if (widget.pos == 'editCamp') {
      if (widget.camp == null) {
        return Scaffold(
            body: Row(
          children: [
            myDrawer(context, id),
            const VerticalDivider(
              width: 0.1,
              color: Colors.grey,
            ),
            const Expanded(child: EditCamps())
          ],
        ));
      } else {
        return Scaffold(
            body: Row(
          children: [
            myDrawer(context, id),
            const VerticalDivider(
              width: 0.1,
              color: Colors.grey,
            ),
            Expanded(child: AddCamp(camp: widget.camp))
          ],
        ));
      }
    } else {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context, id),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: campTile())
        ],
      ));
    }
  }
}
