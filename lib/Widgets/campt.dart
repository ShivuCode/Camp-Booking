import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import '../Pages/HOME/laptopHomeScreen.dart';
import '../Pages/HOME/mobileHomeScreen.dart';
import '../Pages/HOME/tabletHomeScreen.dart';
import '../constant.dart';

Widget campTile(context, double size, bool showAppBar) {
  return Scaffold(
    appBar: (showAppBar)
        ? AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 40)),
                    onPressed: () {},
                    child: Text(
                      "Edit Customer".toUpperCase(),
                      style: const TextStyle(letterSpacing: 2),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 40)),
                    onPressed: () {},
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: Text(
                      "Share".toUpperCase(),
                      style: const TextStyle(letterSpacing: 2),
                    )),
              ),
            ],
          )
        : null,
    body: Container(
        child: size < 670
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: camps.length,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () => nextScreen(
                        context,
                        ResponsiveLayout(
                            mobileScaffold: MobileHomeScreen(pos: 0),
                            tabletScaffold: TabletHomeScreen(pos: 0),
                            laptopScaffold: LaptopHomeScreen(pos: 0))),
                    child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Image.network(
                              camps[i]["image"],
                              width: size * 0.8,
                              height: size * 0.5,
                              fit: BoxFit.fill,
                            ),
                            height(10),
                            Text(
                              camps[i]["name"],
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "₹ ${camps[i]["price"]} per person",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  );
                })
            : GridView.count(
                crossAxisCount: size < 800 ? 2 : 3,
                childAspectRatio: size < 800 ? 4 / 3 : 3 / 3,
                children: List.generate(
                    camps.length,
                    (i) => GestureDetector(
                          onTap: () {
                            print("hii");
                            nextReplacement(
                                context,
                                ResponsiveLayout(
                                    mobileScaffold: MobileHomeScreen(pos: 0),
                                    tabletScaffold: TabletHomeScreen(pos: 0),
                                    laptopScaffold: LaptopHomeScreen(pos: 0)));
                            print("yooo");
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Image.network(
                                    camps[i]["image"],
                                    width: size * 0.6,
                                    height: size * 0.25,
                                    fit: BoxFit.fill,
                                  ),
                                  height(10),
                                  Text(
                                    camps[i]["name"],
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "₹ ${camps[i]["price"]} per person",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )),
                        )),
              )),
  );
}
