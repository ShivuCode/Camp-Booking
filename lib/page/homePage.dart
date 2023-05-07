import 'package:camp_booking/page/bookingPage.dart';
import 'package:flutter/material.dart';

import '../constants/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Lao Camping",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white),
        body: size < 670
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: camps.length,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookingPage(camp: camps[i]))),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Image.network(
                              camps[i]["image"],
                              width: size * 0.75,
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
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => BookingPage(camp: camps[i]))),
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Image.network(
                                    camps[i]["image"],
                                    width: size * 0.75,
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
              ));
  }
}
