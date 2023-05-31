import 'package:camp_booking/constant.dart';
import '../../Widgets/bookingPageWidget.dart';
import '../../Widgets/campt.dart';
import 'package:flutter/material.dart';

import '../SEARCH/search.dart';

class TabletHomeScreen extends StatelessWidget {
  String? pos;

  TabletHomeScreen({super.key, this.pos});


  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (pos == 'booking') {
      return Scaffold(appBar: myAppBar,drawer: myDrawer(context),body: const BookingPage());
    } else if (pos == 'search') {
      return  Scaffold(appBar: myAppBar,drawer: myDrawer(context),
          body: const SearchPage());
    } else {
      return Scaffold(appBar: myAppBar,drawer: myDrawer(context),
          body: campTile(context, size, false));
    }
  }
}
