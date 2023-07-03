import 'dart:async';

import 'package:camp_booking/Models/camp_model.dart';

import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:camp_booking/Services/api.dart';

import 'package:camp_booking/Widgets/skelton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';
import '../../constant.dart';

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
  int slidePage = 1;
  late Timer _timer;
  int page = 1;
  bool searchtab = false;
  bool search = false;
  bool isLoad = false;
  bool stop = false;
  List<Camp> searchList = [];
  final ScrollController _scrollController = ScrollController();
  List<Camp> campList = [];
  fetchData() async {
    try {
      if (page == 1) {
        setState(() {
          campList = [];
        });
      }
      final data = await ApiService.fetchCampData(page, 4);
      if (data.isNotEmpty) {
        for (final element in data['items']) {
          // print(element['titleImageUrl']);
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

  testing() async {
    while (true) {
      try {
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          _pageController.animateToPage(
            slidePage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });
      } catch (e) {
      } finally {
        if (slidePage != campList.length - 1) {
          setState(() {
            slidePage = slidePage + 1;
          });
        } else {
          setState(() {
            slidePage = 0;
          });
        }
      }
    }
  }

  @override
  void initState() {
    fetchData();
    _pageController = PageController(viewportFraction: 0.5);
    testing();
    _scrollController.addListener(scrollController);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  void scrollController() async {
    if (!stop) {
      // ignore: unrelated_type_equality_checks
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        fetchData();
      }
    }
  }

  void findCamp(value) {
    final data = campList.where((camp) => camp.campLocation
        .toLowerCase()
        .contains(value.toString().toLowerCase()));
    if (data.isNotEmpty) {
      searchList = [];
      searchList.addAll(data);
    } else {
      setState(() {
        search = false;
      });
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
              const Text("Where do you want to go?"),
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
                            hintText: 'Search'),
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
                      reverse: true,
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
              Center(
                  child: isLoad
                      ? campSkelton(size)
                      : camp(context, size, campList))
            ]),
          ),
        ),
      ),
    );
  }
}

campo(context, i, page, List<Camp> campList) => GestureDetector(
      onTap: () => nextScreen(
          context,
          ResponsiveLayout(
              mobileScaffold: MobileHomeScreen(
                pos: 'booking',
                camp: campList[i],
              ),
              tabletScaffold:
                  TabletHomeScreen(pos: 'booking', camp: campList[i]),
              laptopScaffold:
                  LaptopHomeScreen(pos: 'booking', camp: campList[i]))),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: page == i ? 200 : 190,
        height: page == i ? 260 : 240,
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
                onError: (exception, stackTrace) => {},
                image: NetworkImage(
                    "https://pawnacamp.in/Content/img/Camp/${campList[i].titleImageUrl}"),
                fit: BoxFit.cover)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      campList[i].campName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              height(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    campList[i].campLocation,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "-- Rs ${campList[i].campFee}",
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

Widget camp(context, double size, List<Camp> campList) {
  return Wrap(
      children: List.generate(
          campList.length,
          (i) => Container(
              padding: const EdgeInsets.all(5),
              width: size > 600 ? 200 : size * 0.47,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: size > 600 ? 200 : size * 0.45,
                    height: size > 600 ? 200 : size * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            onError: (exception, stackTrace) => {},
                            image: NetworkImage(
                                "https://pawnacamp.in/Content/img/Camp/${campList[i].titleImageUrl}"),
                            fit: BoxFit.cover)),
                  ),
                  height(5),
                  Text(
                    campList[i].campName,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(campList[i].campLocation,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w400))),
                      Text("--Rs.${campList[i].campFee}",
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))
                    ],
                  ),
                  height(5),
                  ElevatedButton(
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(mainColor),
                          minimumSize:
                              MaterialStateProperty.all(const Size(100, 35))),
                      child: const Text("Book Now")),
                  height(5)
                ],
              ))));
}
