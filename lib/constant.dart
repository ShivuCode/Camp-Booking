import 'package:camp_booking/Pages/BOOKED/booked.dart';
import 'package:camp_booking/Pages/USER/createUser.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Models/vendor_model.dart';

const mainColor = Color(0xFF0ECB7B);
// Color mainColor = Colors.orange.shade600;
List<Vendor> vendorList = [];

myToast(context, msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 4),
    ));

AppBar appBar(context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 5, right: 10),
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

myDrawer(context, id) {
  if (kDebugMode) {
    print("Comming id $id");
  }
  return Drawer(
    width: 300,
    child: ListView(children: [
      const DrawerHeader(
          child: Icon(
        Icons.favorite,
        size: 30,
      )),
      ListTile(
        onTap: () {
          nextReplacement(context, home);
        },
        leading: const Icon(
          FontAwesomeIcons.house,
          size: 16,
        ),
        title: const Text("H O M E"),
      ),
      if (id == 1 || id == 2)
        ListTile(
          onTap: () {
            nextReplacement(context, search);
          },
          leading: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 16,
          ),
          title: const Text("S E A R C H"),
        ),
      if (id == 1)
        ListTile(
          onTap: () {
            nextReplacement(context, addVendor);
          },
          leading: const Icon(
            Icons.people_alt_outlined,
            size: 16,
          ),
          title: const Text("A D D  V E N D O R"),
        ),
      if (id == 1)
        ListTile(
          onTap: () {
            nextReplacement(context, editVendor);
          },
          leading: const Icon(
            Icons.people_alt_outlined,
            size: 16,
          ),
          title: const Text("E D I T  V E N D O R"),
        ),
      if (id == 1 || id == 2)
        ListTile(
          onTap: () {
            nextReplacement(context, addCamp);
          },
          leading: const Icon(
            Icons.people_alt_outlined,
            size: 16,
          ),
          title: const Text("A D D  C A M P"),
        ),
      if (id == 1 || id == 2)
        ListTile(
          onTap: () {
            nextReplacement(context, editCamp);
          },
          leading: const Icon(
            Icons.people_alt_outlined,
            size: 16,
          ),
          title: const Text("E D I T  C A M P"),
        ),
      if (id == 1 || id == 2)
        ListTile(
          onTap: () {
            nextReplacement(context, report);
          },
          leading: const Icon(
            FontAwesomeIcons.notesMedical,
            size: 16,
          ),
          title: const Text("R E P O R T"),
        ),
      if (id == 3)
        ListTile(
          title: const Text('H I S T O R Y'),
          leading: const Icon(
            FontAwesomeIcons.history,
            size: 16,
          ),
          onTap: () => nextReplacement(context, const HistoryPage()),
        ),
      if (id == 1)
        ListTile(
          title: const Text('U S E R'),
          leading: const Icon(
            FontAwesomeIcons.person,
            size: 16,
          ),
          onTap: () => nextReplacement(context, const CreateUserPage()),
        ),
      ListTile(
        onTap: () {
          ApiService.logout(context);
        },
        leading: const Icon(
          FontAwesomeIcons.rightFromBracket,
          size: 16,
        ),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: mainColor, width: 1.3)),
      label: Text(hint),
      labelStyle: const TextStyle(color: Colors.grey),
      focusColor: mainColor);
  return decoration;
}

class ScrollGlowEffect extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
