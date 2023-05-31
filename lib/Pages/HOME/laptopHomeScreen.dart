import 'package:camp_booking/Pages/SEARCH/search.dart';
import 'package:camp_booking/Widgets/invoicePageWidget.dart';
import 'package:camp_booking/constant.dart';

import 'package:flutter/material.dart';

import '../../Widgets/bookingPageWidget.dart';
import '../../Widgets/campt.dart';

class LaptopHomeScreen extends StatelessWidget {
  String? pos;
  LaptopHomeScreen({super.key, this.pos});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (pos == 'booking') {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Row(
            children: [
              myDrawer(context),
              const VerticalDivider(
                width: 0.1,
                color: Colors.grey,
              ),
              const Expanded(child: BookingPage()),
            ],
          ));
    } else if (pos == 'search') {
      return Scaffold(
          body: Row(
        children: [
          myDrawer(context),
          const VerticalDivider(
            width: 0.1,
            color: Colors.grey,
          ),
          const Expanded(child: SearchPage()),
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
          Expanded(child: campTile(context, size - 310, true))
        ],
      ));
    }
  }
}
