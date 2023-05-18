import 'package:camp_booking/Services/ApiService.dart';
import 'package:camp_booking/Pages/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

var myAppBar = AppBar(
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
);

Widget myDrawer(context) {
  return Drawer(
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
                    pos: 0,
                  ),
                  tabletScaffold: TabletHomeScreen(
                    pos: 0,
                  ),
                  laptopScaffold: LaptopHomeScreen(
                    pos: 0,
                  )));
        },
        leading: const Icon(Icons.person),
        title: const Text("C U S T O M E R"),
      ),
      const ListTile(
        leading: Icon(Icons.search),
        title: Text("S E A R C H"),
      ),
      ListTile(
        onTap: () {},
        leading: const Icon(Icons.logout),
        title: const Text("L O G O U T"),
      ),
    ]),
  );
}

//list of camps details
List camps = [
  {
    "image":
        "https://s-ec.bstatic.com/images/hotel/max1024x768/214/21475806.jpg",
    "name": "Alpine camps",
    "price": 1024.0,
    "child": 499.0
  },
  {
    "name": "Ganga View Camp",
    "image":
        "https://ui.cltpstatic.com/places/hotels/3167/316797/images/tents_w.jpg",
    "price": 1299.0,
    "child": 498.0
  },
  {
    "name": "Ac Cottage",
    "image":
        "https://t-ec.bstatic.com/images/hotel/max1280x900/163/163487480.jpg",
    "price": 2405.0,
    "child": 1050.0
  },
  {
    "image":
        "https://s-ec.bstatic.com/images/hotel/max1024x768/214/21475806.jpg",
    "name": "Alpine camps",
    "price": 1024.0,
    "child": 499.0
  },
  {
    "name": "Ganga View Camp",
    "image":
        "https://ui.cltpstatic.com/places/hotels/3167/316797/images/tents_w.jpg",
    "price": 1299.0,
    "child": 498.0
  },
  {
    "name": "Ac Cottage",
    "image":
        "https://t-ec.bstatic.com/images/hotel/max1280x900/163/163487480.jpg",
    "price": 2405.0,
    "child": 1050.0
  },
];

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
