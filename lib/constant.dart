import 'package:camp_booking/Pages/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:camp_booking/Services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBar(context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10, top: 10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                maximumSize: const Size(150, 40),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              ApiService.logout(context);
            },
            child: const Text("L o g O u t")),
      ),
    ],
  );
}

Widget myDrawer(context) {
  return Drawer(
    width: 300,
    child: Column(children: [
      const DrawerHeader(
          child: Icon(
        Icons.favorite,
        size: 30,
      )),
      ListTile(
        onTap: () {
          nextReplacement(
              context,
              ResponsiveLayout(
                  mobileScaffold: MobileHomeScreen(),
                  tabletScaffold: TabletHomeScreen(),
                  laptopScaffold: LaptopHomeScreen()));
        },
        leading: const Icon(Icons.home),
        title: const Text("H O M E"),
      ),
      ListTile(
        onTap: () {
          nextReplacement(
              context,
              ResponsiveLayout(
                  mobileScaffold: MobileHomeScreen(
                    pos: 'booking',
                  ),
                  tabletScaffold: TabletHomeScreen(
                    pos: 'booking',
                  ),
                  laptopScaffold: LaptopHomeScreen(
                    pos: 'booking',
                  )));
        },
        leading: const Icon(Icons.person),
        title: const Text("C U S T O M E R"),
      ),
      ListTile(
        onTap: () {
          nextReplacement(
              context,
              ResponsiveLayout(
                  mobileScaffold: MobileHomeScreen(
                    pos: 'search',
                  ),
                  tabletScaffold: TabletHomeScreen(
                    pos: 'search',
                  ),
                  laptopScaffold: LaptopHomeScreen(
                    pos: 'search',
                  )));
        },
        leading: const Icon(Icons.search),
        title: const Text("S E A R C H"),
      ),
      ListTile(
        onTap: () {
          ApiService.logout(context);
        },
        leading: const Icon(Icons.logout),
        title: const Text("L O G O U T"),
      ),
    ]),
  );
}

Widget height(double h) {
  return SizedBox(
    height: h,
  );
}

Widget width(double h) {
  return SizedBox(
    width: h,
  );
}

nextScreen(context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

nextReplacement(context, page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}

//Login field design
dec(String hint) {
  InputDecoration decoration = InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white);
  return decoration;
}

//field title of form
fieldTitle(String title) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54),
      ),
      height(5)
    ],
  );
}

//fields decoration
fieldDec(String hint) {
  InputDecoration decoration = InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey)),
  );
  return decoration;
}
