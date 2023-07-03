import 'dart:async';

import 'package:camp_booking/Models/customer_model.dart';

import 'package:camp_booking/Widgets/skelton.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Models/camp_model.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../../Services/api.dart';
import '../../Services/pdf.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';
import '../pdfView.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  late Camp camp;
  List<Customer> customers = [];
  List<Customer> temp = [];
  final scrollController = ScrollController();
  final _searchController = TextEditingController();
  int page = 1;
  bool isLoad = true;
  bool showNoContent = false;
  bool showMore = false;
  bool stop = false;
  void fetchData() async {
    final data = await ApiService.fetchDataPage(page, 5);
    if (data.isNotEmpty) {
      for (var element in data['items']) {
        setState(() {
          customers.add(Customer.fromJson(element));
        });
      }
      temp = customers;
    } else {
      setState(() {
        stop = true;
      });
    }
  }

  @override
  void initState() {
    fetchCamp();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoad = false;
      });
    });
    scrollController.addListener(_scrollController);
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
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
                ? Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.9,
                        height: size.height * 0.5,
                        child: const Text("No Content")),
                  )
                : isLoad
                    ? Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollGlowEffect(),
                          child: SingleChildScrollView(
                            child: Column(
                                children: List.generate(
                                    5, (index) => ListSkeleton())),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollGlowEffect(),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: scrollController,
                              itemCount: showMore
                                  ? customers.length + 1
                                  : customers.length,
                              itemBuilder: (_, i) {
                                if (i < customers.length) {
                                  final total =
                                      (customers[i].price * customers[i].adult +
                                          ((customers[i].price * 0.45) *
                                              customers[i].child));

                                  return Container(
                                    width: size.width > 600 ? 270 : 270,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    onError: (exception,
                                                            stackTrace) =>
                                                        {},
                                                    image: NetworkImage(
                                                        camp.titleImageUrl),
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14)),
                                                height(3),
                                                Text(customers[i].name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14)),
                                                height(8),
                                                const Text(
                                                  "Beautiful Couple Camping With Decoration light, food & support.",
                                                  softWrap: true,
                                                ),
                                                height(10),
                                                Text("Total: ₹ $total",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                        mobileScaffold:
                                                            MobileHomeScreen(
                                                          pos: 'booking',
                                                          customer:
                                                              customers[i],
                                                        ),
                                                        tabletScaffold:
                                                            TabletHomeScreen(
                                                                pos: 'booking',
                                                                customer:
                                                                    customers[
                                                                        i]),
                                                        laptopScaffold:
                                                            LaptopHomeScreen(
                                                                pos: 'booking',
                                                                customer:
                                                                    customers[
                                                                        i])));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: mainColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  minimumSize:
                                                      const Size(120, 35)),
                                              child: const Text('Edit'),
                                            )),
                                            width(5),
                                            Expanded(
                                                child: ElevatedButton(
                                              onPressed: () async {
                                                String path = await PdfService
                                                    .generatePDF(customers[i]);

                                                if (path.isNotEmpty) {
                                                  // ignore: use_build_context_synchronously
                                                  nextScreen(context,
                                                      PdfViewer(path: path));
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: mainColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  minimumSize:
                                                      const Size(120, 35)),
                                              child: const Text('View Invoice'),
                                            ))
                                          ],
                                        ),
                                        height(5),
                                        const Divider(),
                                      ],
                                    ),
                                  );
                                } else {
                                  const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.grey));
                                }
                                return null;
                              }),
                        ),
                      )
          ])),
    );
  }

  void _scrollController() {
    if (!stop) {
      // ignore: unrelated_type_equality_checks
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page += 1;
        setState(() {
          showMore = true;
        });
        fetchData();
        setState(() {
          showMore = false;
        });
      }
    }
  }

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

  void fetchCamp() async {
    final data = await ApiService.fetchCampById(2);
    setState(() {
      camp = Camp.fromJson(data);
    });
  }
}
