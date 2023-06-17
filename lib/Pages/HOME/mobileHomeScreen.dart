import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/constant.dart';
import '../../Models/camp_model.dart';
import '../../Widgets/booking.dart';
import 'package:flutter/material.dart';
import '../CAMP/campt.dart';
import '../SEARCH/search.dart';

// ignore: must_be_immutable
class MobileHomeScreen extends StatelessWidget {
  String? pos;
  Camp? camp;
  Customer? customer;
  MobileHomeScreen({super.key, this.pos, this.camp, this.customer});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
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
    } else {
      return Scaffold(
          appBar: appBar(context),
          drawer: myDrawer(context),
          body: const campTile());
    }
  }
}
