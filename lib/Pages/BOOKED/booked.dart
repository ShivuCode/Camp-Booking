import 'package:camp_booking/Services/database.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';

import '../../Models/camp_model.dart';
import '../../Services/api.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Camp? camp;
  void fetchCamp() async {
    final data = await ApiService.fetchCampById(2);
    setState(() {
      camp = Camp.fromJson(data);
    });
  }

  int id = 0;
  role() async {
    id = await DbHelper.getId();
  }

  @override
  void initState() {
    fetchCamp();
    role();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: myDrawer(context, id),
        body: SafeArea(
            child: ScrollConfiguration(
                behavior: ScrollGlowEffect(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      height(10),
                      const Text("  Booking History",
                          style: TextStyle(fontSize: 18)),
                      height(20),
                      //   Expanded(
                      //       child: Container(
                      //     width: 300,
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 20, vertical: 5),
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //             height: 100,
                      //             width: 100,
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(5),
                      //                 image: DecorationImage(
                      //                     onError: (exception, stackTrace) => {},
                      //                     image: NetworkImage(
                      //                         "https://pawnacamp.in/Content/img/Camp/${camp!.titleImageUrl}"),
                      //                     fit: BoxFit.cover))),
                      //         width(8),
                      //         Expanded(
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               const Text("Couple Camping",
                      //                   style: TextStyle(
                      //                       fontSize: 14,
                      //                       fontWeight: FontWeight.w600)),
                      //               const Text(
                      //                   "Beautiful Couple Camping With Decoration light, food & support.",
                      //                   softWrap: true,
                      //                   style: TextStyle(fontSize: 10)),
                      //               const Text("Advance Payed: 200",
                      //                   style: TextStyle(fontSize: 10)),
                      //               const Text("Pending Payment: 520",
                      //                   style: TextStyle(fontSize: 10)),
                      //               height(5),
                      //               ElevatedButton(
                      //                   onPressed: () async {
                      //                     // String path = await PdfService
                      //                     //     .generatePDF(customers[i]);

                      //                     // if (path.isNotEmpty) {
                      //                     //   // ignore: use_build_context_synchronously
                      //                     //   nextScreen(context,
                      //                     //       PdfViewer(path: path));
                      //                     // }
                      //                   },
                      //                   style: ButtonStyle(
                      //                       minimumSize: MaterialStateProperty.all(
                      //                           const Size(100, 30)),
                      //                       backgroundColor:
                      //                           MaterialStateProperty.all(
                      //                               mainColor)),
                      //                   child: const Text("View Invoice"))
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ))
                    ]))));
  }
}
