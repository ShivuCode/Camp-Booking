import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Models/vendor_model.dart';
import 'package:camp_booking/Pages/CAMP/editCamp.dart';

import 'package:camp_booking/Pages/REPORT/report.dart';
import 'package:camp_booking/Pages/VENDOR/form.dart';

import 'package:camp_booking/constant.dart';
import 'package:flutter/foundation.dart';
import '../../Services/database.dart';
import '../../Widgets/booking.dart';

import '../CAMP/addCamp.dart';
import '../CAMP/home.dart';
import 'package:flutter/material.dart';

import '../SEARCH/search.dart';
import '../VENDOR/editVendor.dart';

// ignore: must_be_immutable
class TabletHomeScreen extends StatefulWidget {
  String? pos;
  Camp? camp;
  Customer? customer;
  Vendor? vendor;
  TabletHomeScreen(
      {super.key, this.pos, this.camp, this.customer, this.vendor});

  @override
  State<TabletHomeScreen> createState() => _TabletHomeScreenState();
}

class _TabletHomeScreenState extends State<TabletHomeScreen> {
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
    super.initState();
    role();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pos == 'booking') {
      if (widget.camp != null) {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context, id),
            body: BookingPage(camp: widget.camp));
      } else {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context, id),
            body: BookingPage(customer: widget.customer));
      }
    } else if (widget.pos == 'search') {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context, id),
          body: const Invoice());
    } else if (widget.pos == 'report') {
      return Scaffold(
        appBar: appBar(context),
        drawer: myDrawer(context, id),
        body: const Report(),
      );
    } else if (widget.pos == 'vendorForm') {
      if (widget.vendor == null) {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context, id),
            body: VendorForm());
      } else {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context, id),
            body: VendorForm(vendor: widget.vendor));
      }
    } else if (widget.pos == 'editVendor') {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context, id),
          body: const EditVendor());
    } else if (widget.pos == 'addCamp') {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context, id),
          body: AddCamp());
    } else if (widget.pos == 'editCamp') {
      if (widget.camp == null) {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context, id),
            body: const EditCamps());
      } else {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context, id),
            body: AddCamp(camp: widget.camp));
      }
    } else {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context, id),
          body: const campTile());
    }
  }
}
