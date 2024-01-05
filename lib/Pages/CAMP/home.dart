import 'dart:async';

import 'package:camp_booking/Models/camp_model.dart';

import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/Widgets/animatedText.dart';

import 'package:camp_booking/Widgets/skelton.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import 'card.dart';

// ignore: camel_case_types
class campTile extends StatefulWidget {
  const campTile({super.key});

  @override
  State<campTile> createState() => _campTileState();
}

// ignore: camel_case_types
class _campTileState extends State<campTile>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late PageController _pageController;
  int slidePage = 2;
  int page = 1;
  bool searchtab = false;
  bool search = false;
  bool isLoad = false;
  bool stop = false;
  Timer? timer;
  List<Camp> searchList = [];
  final ScrollController _scrollController = ScrollController();
  List<Camp> campList = [];
  fetchData() async {
    try {
      final data = await ApiService.fetchCampData(page, 4);
      if (data.isNotEmpty) {
        for (final element in data['items']) {
          setState(() {
            campList.add(Camp.fromJson(element));
          });
        }
      } else {
        stop = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void slide() {
    timer = Timer(const Duration(seconds: 5), () {
      if (slidePage >= campList.length - 1) {
        slidePage = 0;
      } else {
        slidePage += 1;
      }
      setState(() {
        _pageController.animateToPage(slidePage,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      });
      slide();
    });
  }

  @override
  void initState() {
    fetchData();
    _pageController =
        PageController(viewportFraction: 0.8, initialPage: slidePage);
    slide();
    _scrollController.addListener(scrollController);
    // MyNotification.showNotification(
    //     "Welcome!", "Welcome to Pawna Camp Booking app");
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    _pageController.dispose();
    super.dispose();
    _scrollController.dispose();
  }

  void scrollController() async {
    if (!stop) {
      // ignore: unrelated_type_equality_checks
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page += 1;
        fetchData();
      }
    }
  }

  void findCamp(value) async {
    try {
      final data = await ApiService.fetchCampBySearchName(value);
      if (data.isNotEmpty) {
        searchList = [];
        for (final element in data['items']) {
          setState(() {
            searchList.add(Camp.fromJson(element));
          });
        }
      } else {
        searchList = [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollGlowEffect(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              height(15),
              const Text(
                "Camp with peace of mind.",
                style: TextStyle(fontSize: 28, color: mainColor),
              ),
              AnimatedText(
                text: "Where do you want to go?",
              ),
              height(10),
              Container(
                height: 45,
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
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            setState(() {
                              search = true;
                            });
                            findCamp(_searchController.text);
                          }
                        },
                        controller: _searchController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: mainColor,
                            hintText: 'Ex. New Special, Couple etc.'),
                      ),
                    ),
                    Container(
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
                    )
                  ],
                ),
              ),
              height(20),
              Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () => setState(() {
                                searchtab = !searchtab;
                              }),
                          child: const Text("Popular")),
                      height(4),
                      if (!searchtab)
                        Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: LinearGradient(colors: [
                                mainColor.withOpacity(0.6),
                                Colors.blueAccent.shade200
                              ])),
                        )
                    ],
                  ),
                  width(10),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () => setState(() {
                                searchtab = !searchtab;
                              }),
                          child: const Text("Search")),
                      height(4),
                      if (searchtab)
                        Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: LinearGradient(colors: [
                                mainColor.withOpacity(0.6),
                                Colors.blueAccent.shade200
                              ])),
                        )
                    ],
                  ),
                ],
              ),
              height(20),
              SizedBox(
                  height: 250,
                  child: PageView.builder(
                      onPageChanged: ((value) => setState(() {
                            page = value;
                          })),
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          searchtab ? searchList.length : campList.length,
                      itemBuilder: (_, i) {
                        if (searchtab) {
                          return campo(_, i, page, searchList);
                        } else {
                          return campo(_, i, page, campList);
                        }
                      })),
              height(20),
              const Text(
                "Recommended",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              height(5),
              isLoad ? campSkelton(size) : camp(context, size, campList)
            ]),
          ),
        ),
      ),
    );
  }
}
