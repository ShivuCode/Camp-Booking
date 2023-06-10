import 'package:camp_booking/Pages/CAMP/campList.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import '../Pages/HOME/laptopHomeScreen.dart';
import '../Pages/HOME/mobileHomeScreen.dart';
import '../Pages/HOME/tabletHomeScreen.dart';
import '../constant.dart';

Widget campTile(context, double size) {
  return Scaffold(
      body: Container(
    width: double.infinity,
    alignment: Alignment.center,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
          children: List.generate(
              campList.length,
              (i) => GestureDetector(
                    onTap: () => nextScreen(
                        context,
                        ResponsiveLayout(
                            mobileScaffold: MobileHomeScreen(pos: 'booking'),
                            tabletScaffold: TabletHomeScreen(pos: 'booking'),
                            laptopScaffold: LaptopHomeScreen(pos: 'booking'))),
                    child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5)
                            ],
                            image: DecorationImage(
                                image: NetworkImage(campList[i].imageUrl),
                                fit: BoxFit.cover)),
                        alignment: Alignment.bottomLeft,
                        width: size < 600 ? size * 0.9 : 270,
                        height: 300,
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
                                campList[i].name,
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
                                      Text(campList[i].location.toString())
                                    ],
                                  ),
                                  Text(
                                    "₹${campList[i].pricePerUnit} / unit",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              height(10)
                            ],
                          ),
                        )),
                  ))),
    ),
  ));
}
