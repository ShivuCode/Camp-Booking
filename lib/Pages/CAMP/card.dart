import 'package:camp_booking/Pages/CAMP/campDetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Models/camp_model.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../../constant.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';

Widget camp(context, double size, List<Camp> campList) {
  return Wrap(
      spacing: 8,
      children: List.generate(
          campList.length,
          (i) => Card(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: size > 600 ? 420 : double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 156,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  onError: (exception, stackTrace) => {},
                                  image: NetworkImage(campList[i]
                                          .titleImageUrl
                                          .contains("/Content/Uploads")
                                      ? "https://PawnacampAppProd.titwi.in/${campList[i].titleImageUrl}"
                                      : "https://PawnacampAppProd.titwi.in/content/camp/${campList[i].titleImageUrl}"),
                                  fit: BoxFit.cover)),
                        ),
                        width(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  campList[i].campName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              height(8),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.locationDot,
                                    size: 13,
                                    color: mainColor,
                                  ),
                                  width(5),
                                  Expanded(
                                    child: Text(campList[i].campLocation,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Text("--₹${campList[i].campFee}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              height(5),
                              Wrap(
                                spacing: 0,
                                children: [
                                  const Text(
                                    "Pawna lake camping is the greatest place for making your holiday special..",
                                    softWrap: true,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  GestureDetector(
                                    onTap: () => nextScreen(
                                        context,
                                        CampDetail(
                                          camp: campList[i],
                                        )),
                                    child: const Text(
                                      "More info",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              height(10),
                              ElevatedButton(
                                  onPressed: () => nextScreen(
                                      context,
                                      ResponsiveLayout(
                                          mobileScaffold: MobileHomeScreen(
                                            pos: 'booking',
                                            camp: campList[i],
                                          ),
                                          tabletScaffold: TabletHomeScreen(
                                              pos: 'booking',
                                              camp: campList[i]),
                                          laptopScaffold: LaptopHomeScreen(
                                              pos: 'booking',
                                              camp: campList[i]))),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(mainColor),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(150, 40))),
                                  child: const Text("Book Now")),
                              height(5)
                            ],
                          ),
                        ),
                      ],
                    )),
              )));
}

campo(context, i, page, List<Camp> campList) => Container(
      margin: const EdgeInsets.all(10),
      width: page == i ? 320 : 300,
      height: page == i ? 260 : 300,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          boxShadow: [
            if (page == i)
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 4,
                blurRadius: 10,
              )
          ],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              onError: (exception, stackTrace) {},
              image: NetworkImage(campList[i]
                      .titleImageUrl
                      .contains("/Content/Uploads")
                  ? "https://PawnacampAppProd.titwi.in/${campList[i].titleImageUrl}"
                  : "https://PawnacampAppProd.titwi.in/content/camp/${campList[i].titleImageUrl}"),
              fit: BoxFit.cover)),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "100% recommended",
                  style: TextStyle(color: Colors.blue),
                ),
                width(4),
                const Icon(
                  Icons.circle,
                  color: Colors.blue,
                  size: 5,
                ),
                width(4),
                const Text(
                  "12 reviews",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            height(3),
            Row(
              children: [
                Expanded(
                  child: Text(
                    campList[i].campName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.grey,
                          size: 10,
                        ),
                        width(4),
                        Text(
                          campList[i].campLocation,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    height(2),
                    Text(
                      "Rs ${campList[i].campFee}/unit",
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor),
                        minimumSize:
                            MaterialStateProperty.all(const Size(110, 36))),
                    onPressed: () => nextScreen(
                        context,
                        ResponsiveLayout(
                            mobileScaffold: MobileHomeScreen(
                              pos: 'booking',
                              camp: campList[i],
                            ),
                            tabletScaffold: TabletHomeScreen(
                                pos: 'booking', camp: campList[i]),
                            laptopScaffold: LaptopHomeScreen(
                                pos: 'booking', camp: campList[i]))),
                    child: const Text("Book Now"))
              ],
            )
          ],
        ),
      ),
    );
