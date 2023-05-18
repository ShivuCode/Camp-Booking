import 'package:camp_booking/constant.dart';
import '../../Widgets/bookingPageWidget.dart';
import '../../Widgets/campt.dart';
import 'package:flutter/material.dart';

class TabletHomeScreen extends StatelessWidget {
  int? pos;

  TabletHomeScreen({super.key, this.pos});


  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar,
      extendBodyBehindAppBar: true,
      drawer: myDrawer(context),
      body: pos == 0 ?const  BookingPage(): campTile(context, size, false),
    );
  }
}
