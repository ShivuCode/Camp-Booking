import 'package:camp_booking/constant.dart';
import 'package:camp_booking/widget/bookingPageWidget.dart';
import 'package:camp_booking/widget/campt.dart';
import 'package:flutter/material.dart';

class LaptopHomeScreen extends StatelessWidget {
  int? pos;
  LaptopHomeScreen({super.key,this.pos});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(children: [
        myDrawer(context),
        Expanded(
            child:
              pos==0? const BookingPage() : campTile(context, size - 310, true))
      ]),
    );
  }
}
