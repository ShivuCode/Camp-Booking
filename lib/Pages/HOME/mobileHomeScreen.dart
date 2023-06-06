import 'package:camp_booking/constant.dart';
import '../../Widgets/booking.dart';
import 'package:flutter/material.dart';

import '../../Widgets/campt.dart';
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
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: const BookingPage());
    } else if (pos == 'search') {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: const SearchPage());
    } else {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: campTile(context, size));
    }
  }
}
