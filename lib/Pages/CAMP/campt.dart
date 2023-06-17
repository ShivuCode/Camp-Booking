import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Pages/CAMP/campList.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:camp_booking/Widgets/skelton.dart';
import 'package:flutter/material.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';
import '../../constant.dart';

class campTile extends StatefulWidget {
  const campTile({super.key});

  @override
  State<campTile> createState() => _campTileState();
}

class _campTileState extends State<campTile> {
  TextEditingController _searchController = TextEditingController();
  bool search = false;
  bool isLoad = true;
  List<Camp> searchList = [];
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoad = false;
        searchList = campList;
      });
    });
    super.initState();
  }

  void findCamp(value) {
    final data = campList.where((camp) =>
        camp.location.toLowerCase().contains(value.toString().toLowerCase()));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            height(15),
            const Text(
              "Where do you want to go?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
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
            height(10),
            const Text(
              "Discover",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: isLoad
                    ? campSkelton(size)
                    : searchCamp(context, size, searchList)),
            height(20),
            const Text(
              "Recommended",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Center(child: isLoad ? campSkelton(size) : camp(context, size))
          ]),
        ),
      ),
    );
  }
}

searchCamp(context, size, searchList) => Row(
    children: List.generate(
        searchList.length,
        (i) => GestureDetector(
              onTap: () => nextScreen(
                  context,
                  ResponsiveLayout(
                      mobileScaffold: MobileHomeScreen(
                        pos: 'booking',
                        camp: searchList[i],
                      ),
                      tabletScaffold:
                          TabletHomeScreen(pos: 'booking', camp: searchList[i]),
                      laptopScaffold: LaptopHomeScreen(
                          pos: 'booking', camp: searchList[i]))),
              child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 2,
                            blurRadius: 5)
                      ],
                      image: DecorationImage(
                          onError: (exception, stackTrace) => {},
                          image: NetworkImage(searchList[i].imageUrl),
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
                          searchList[i].name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        height(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.grey, size: 15),
                                width(5),
                                Text(searchList[i].location.toString())
                              ],
                            ),
                            Text(
                              "₹${searchList[i].fee} / unit",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        height(10)
                      ],
                    ),
                  )),
            )));

Widget camp(context, double size) {
  return Wrap(
      children: List.generate(
          campList.length,
          (i) => GestureDetector(
                onTap: () => nextScreen(
                    context,
                    ResponsiveLayout(
                        mobileScaffold: MobileHomeScreen(
                          pos: 'booking',
                          camp: campList[i],
                        ),
                        tabletScaffold:
                            TabletHomeScreen(pos: 'booking', camp: campList[i]),
                        laptopScaffold: LaptopHomeScreen(
                            pos: 'booking', camp: campList[i]))),
                child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2,
                              blurRadius: 5)
                        ],
                        image: DecorationImage(
                            onError: (exception, stackTrace) => {},
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                "₹${campList[i].fee} / unit",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          height(10)
                        ],
                      ),
                    )),
              )));
}
