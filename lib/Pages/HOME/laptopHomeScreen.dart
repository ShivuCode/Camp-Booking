// ignore: file_names
import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Models/customer_model.dart';

import 'package:camp_booking/Pages/REPORT/report.dart';
import 'package:camp_booking/Pages/SEARCH/search.dart';
import 'package:camp_booking/Pages/VENDOR/form.dart';
import 'package:camp_booking/Pages/VENDOR/mainPage.dart';
import 'package:camp_booking/constant.dart';

import 'package:flutter/material.dart';

import '../../Widgets/booking.dart';
import '../CAMP/campTile.dart';

// ignore: must_be_immutable
class LaptopHomeScreen extends StatelessWidget {
  String? pos;
  Camp? camp;
  Customer? customer;
  LaptopHomeScreen({super.key, this.pos, this.camp, this.customer});

  @override
  Widget build(BuildContext context) {
    if (pos == 'booking') {
      if (camp != null) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Row(
              children: [
                myDrawer(context),
                const VerticalDivider(
                  width: 0.1,
                  color: Colors.grey,
                ),
                Expanded(child: BookingPage(camp: camp)),
              ],
            ));
      } else {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Row(
              children: [
                myDrawer(context),
                const VerticalDivider(
                  width: 0.1,
                  color: Colors.grey,
                ),
                Expanded(child: BookingPage(customer: customer)),
              ],
            ));
      }
    } else if (pos == 'search') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: Invoice()),
        ],
      ));
    } else if (pos == 'report') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: Report())
        ],
      ));
    } else if (pos == 'vendor') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: MainScreen()),
        ],
      ));
    } else if (pos == 'vendorForm') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: VendorForm())
        ],
      ));
    } else {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context),
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
