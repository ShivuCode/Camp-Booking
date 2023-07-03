import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: myDrawer(context),
      body: SafeArea(
          child: ScrollConfiguration(
        behavior: ScrollGlowEffect(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          height(10),
          const Text("  Booking History", style: TextStyle(fontSize: 18)),
          height(20),
          Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        
                                        image: NetworkImage(
                                            "CoupleCamping/CoupleCamping_01.jpeg" )))),
                            width(8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Couple Camping",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                  const Text(
                                      "Beautiful Couple Camping With Decoration light, food & support.",
                                      softWrap: true,
                                      style: TextStyle(fontSize: 10)),
                                  const Text("Advance Payed: 200",
                                      style: TextStyle(fontSize: 10)),
                                  const Text("Pending Payment: 520",
                                      style: TextStyle(fontSize: 10)),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(100, 30)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  mainColor)),
                                      child: const Text("View Invoice"))
                                ],
                              ),
                            )
                          ],
                        ),
                      )))
        ]),
      )),
    );
  }
}
