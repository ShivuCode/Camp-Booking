import 'package:camp_booking/constant.dart';
import 'package:camp_booking/widget/bookingPageWidget.dart';
import 'package:camp_booking/widget/campt.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MobileHomeScreen extends StatelessWidget {
  int? pos;
  MobileHomeScreen({super.key, this.pos});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: myAppBar,
      drawer: myDrawer(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: pos == 0 ? const BookingPage(): campTile(context, size, false),
      ),
    );
  }
}
