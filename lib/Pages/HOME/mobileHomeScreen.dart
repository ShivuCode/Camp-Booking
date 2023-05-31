import 'package:camp_booking/Widgets/invoicePageWidget.dart';
import 'package:camp_booking/constant.dart';
import '../../Widgets/bookingPageWidget.dart';
import '../../Widgets/campt.dart';
import 'package:flutter/material.dart';

import '../SEARCH/search.dart';

// ignore: must_be_immutable
class MobileHomeScreen extends StatelessWidget {
  String? pos;
  MobileHomeScreen({super.key, this.pos});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (pos == 'booking') {
      return Scaffold(
          appBar: myAppBar, drawer: myDrawer(context), body: BookingPage());
    } else if (pos == 'search') {
      return Scaffold(
          appBar: myAppBar, drawer: myDrawer(context), body: SearchPage());
    } else {
      return Scaffold(
          appBar: myAppBar,
          drawer: myDrawer(context),
          body: campTile(context, size, false));
    }
  }
}
