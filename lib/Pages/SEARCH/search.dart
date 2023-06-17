import 'dart:async';

import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Pages/CAMP/campList.dart';
import 'package:camp_booking/Pages/pdfView.dart';
import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:camp_booking/Services/pdf.dart';
import 'package:camp_booking/Widgets/skelton.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Models/camp_model.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../../Services/ApiService.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  Camp camp = campList[3];
  List<Customer> customers = [];
  List<Customer> temp = [];

  TextEditingController _searchController = TextEditingController();
  int page = 0;
  bool isLoad = true;
  bool showNoContent = false;
  void fetchData() async {
    final data = await ApiService.fetchDataPage(page);
    for (var element in data) {
      setState(() {
        customers.add(Customer.fromJson(element));
      });
    }
    temp = customers;
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoad = false;
      });
    });
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          setState(() {
            showNoContent = false;
          });
          if (_searchController.text.isNotEmpty) {
            chechData(_searchController.text);
          } else {
            customers = temp;
          }
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("All Camp Bookings",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
            height(10),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: mainColor, width: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (v) {
                        setState(() {
                          showNoContent = false;
                        });
                      },
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: mainColor,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_searchController.text.isNotEmpty) {
                        chechData(_searchController.text.trim());
                      } else {
                        customers = temp;
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6)),
                      ),
                      child: const Icon(
                        Icons.line_axis,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            height(10),
            showNoContent
                ? Container(
                    alignment: Alignment.center,
                    width: size.width * 0.9,
                    height: size.height * 0.7,
                    child: const Text("No Content"))
                : isLoad
                    ? ResponsiveForm.responsiveForm(
                        children: List.generate(5, (index) => ListSkeleton()))
                    : ResponsiveForm.responsiveForm(
                        children: List.generate(customers.length, (i) {
                        final total = (customers[i].price * customers[i].adult +
                            ((customers[i].price * 0.45) * customers[i].child));

                        return Container(
                          width: 270,
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Column(
                            children: [
                              Row(children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          onError: (exception, stackTrace) =>
                                              {},
                                          image: NetworkImage(camp.imageUrl),
                                          fit: BoxFit.cover)),
                                ),
                                width(8),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("id: ${customers[i].id}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14)),
                                      height(3),
                                      Text(customers[i].name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14)),
                                      height(8),
                                      const Text(
                                        "Beautiful Couple Camping With Decoration light, food & support.",
                                        softWrap: true,
                                      ),
                                      height(10),
                                      Text("Total: ₹ $total",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black))
                                    ],
                                  ),
                                )
                              ]),
                              height(10),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      nextReplacement(
                                          context,
                                          ResponsiveLayout(
                                              mobileScaffold: MobileHomeScreen(
                                                pos: 'booking',
                                                customer: customers[i],
                                              ),
                                              tabletScaffold: TabletHomeScreen(
                                                  pos: 'booking',
                                                  customer: customers[i]),
                                              laptopScaffold: LaptopHomeScreen(
                                                  pos: 'booking',
                                                  customer: customers[i])));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        minimumSize: const Size(120, 35)),
                                    child: const Text('Edit'),
                                  )),
                                  width(5),
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () async {
                                      String path =
                                          await PdfService.generatePDF(
                                              customers[i]);
                                      nextScreen(
                                          context, PdfViewer(path: path));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        minimumSize: const Size(120, 35)),
                                    child: const Text('View Invoice'),
                                  ))
                                ],
                              ),
                              height(5),
                              const Divider(),
                            ],
                          ),
                        );
                      }))
          ]),
        ),
      ),
    ));
  }

  // void scrollController() {
  //   if (_scrollController.position.hasPixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     page = page + 1;
  //     ApiService.fetchDataPage(page);
  //   }
  // }

  void chechData(value) async {
    setState(() {
      isLoad = true;
    });

    int? intValue = int.tryParse(value);
    double? doubleValue = double.tryParse(value);

    if (intValue != null) {
      final data = await ApiService.findByID(intValue);
      if (data.isNotEmpty) {
        customers = [];
        customers.add(Customer.fromJson(data));
      } else {
        showNoContent = true;
      }
    } else if (doubleValue != null) {
    } else {
      final data = await ApiService.findByName(value);
      if (data.isNotEmpty) {
        customers = [];
        customers.add(Customer.fromJson(data[0]));
      } else {
        showNoContent = true;
      }
    }
    setState(() {
      isLoad = !isLoad;
    });
  }
}
