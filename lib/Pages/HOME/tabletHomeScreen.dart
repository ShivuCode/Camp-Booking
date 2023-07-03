import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Models/customer_model.dart';

import 'package:camp_booking/Pages/REPORT/report.dart';
import 'package:camp_booking/Pages/VENDOR/form.dart';
import 'package:camp_booking/Pages/VENDOR/mainPage.dart';
import 'package:camp_booking/constant.dart';
import '../../Widgets/booking.dart';

import '../CAMP/addCamp.dart';
import '../CAMP/campTile.dart';
import 'package:flutter/material.dart';

import '../SEARCH/search.dart';

// ignore: must_be_immutable
class TabletHomeScreen extends StatelessWidget {
  String? pos;
  Camp? camp;
  Customer? customer;
  TabletHomeScreen({super.key, this.pos, this.camp, this.customer});

  @override
  Widget build(BuildContext context) {
    if (pos == 'booking') {
      if (camp != null) {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context),
            body: BookingPage(camp: camp));
      } else {
        return Scaffold(
            appBar: appBar(context),
            drawer: myDrawer(context),
            body: BookingPage(customer: customer));
      }
    } else if (pos == 'search') {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: const Invoice());
    } else if (pos == 'report') {
      return Scaffold(
        appBar: appBar(context),
        drawer: myDrawer(context),
        body: const Report(),
      );
    } else if (pos == 'vendor') {
      return Scaffold(
        appBar: appBar(context),
        drawer: myDrawer(context),
        body: const MainScreen(),
      );
    } else if (pos == 'vendorForm') {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: const VendorForm());
    } else if (pos == 'addCamp') {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: const AddCamp());
    } else {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: const campTile());
    }
  }
}
