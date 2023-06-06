import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import '../Pages/HOME/laptopHomeScreen.dart';
import '../Pages/HOME/mobileHomeScreen.dart';
import '../Pages/HOME/tabletHomeScreen.dart';
import '../constant.dart';

Widget campTile(context, double size) {
  return Scaffold(
    body: Container(
        child: size < 670
            ? ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                itemCount: camps.length,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () => nextScreen(
                        context,
                        ResponsiveLayout(
                            mobileScaffold: MobileHomeScreen(pos: 'booking'),
                            tabletScaffold: TabletHomeScreen(pos: 'booking'),
                            laptopScaffold: LaptopHomeScreen(pos: 'booking'))),
                    child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 3)
                            ],
                            image: DecorationImage(
                                image: NetworkImage(camps[i]['image']),
                                fit: BoxFit.cover)),
                        alignment: Alignment.bottomLeft,
                        width: size * 0.85,
                        height: size * 0.7,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.white),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              height(10),
                              const Row(
                                children: [
                                  Text(
                                    "100% recommend ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.circle,
                                    size: 4,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    " 11 reviews",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              height(10),
                              Text(
                                camps[i]["name"],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              height(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.grey, size: 15),
                                      width(5),
                                      Text(camps[i]["location"].toString())
                                    ],
                                  ),
                                  Text(
                                    "₹${camps[i]["price"]} / unit",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              height(10)
                            ],
                          ),
                        )),
                  );
                })
            : GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisCount: size < 800 ? 2 : 3,
                childAspectRatio: size < 800 ? 4 / 3 : 3 / 3,
                crossAxisSpacing: 5,
                children: List.generate(
                    camps.length,
                    (i) => GestureDetector(
                          onTap: () => nextScreen(
                              context,
                              ResponsiveLayout(
                                  mobileScaffold:
                                      MobileHomeScreen(pos: 'booking'),
                                  tabletScaffold:
                                      TabletHomeScreen(pos: 'booking'),
                                  laptopScaffold:
                                      LaptopHomeScreen(pos: 'booking'))),
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 2,
                                        blurRadius: 5)
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(camps[i]['image']),
                                      fit: BoxFit.cover)),
                              alignment: Alignment.bottomLeft,
                              width: size * 0.85,
                              height: size * 0.8,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    height(10),
                                    const Row(
                                      children: [
                                        Text(
                                          "100% recommend ",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.circle,
                                          size: 4,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                          " 11 reviews",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    height(10),
                                    Text(
                                      camps[i]["name"],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    height(15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on,
                                                color: Colors.grey, size: 15),
                                            width(5),
                                            Text(
                                                camps[i]["location"].toString())
                                          ],
                                        ),
                                        Text(
                                          "₹${camps[i]["price"]} / unit",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    height(10)
                                  ],
                                ),
                              )),
                        )),
              )),
  );
}
