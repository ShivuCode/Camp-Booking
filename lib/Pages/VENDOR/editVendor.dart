import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Models/vendor_model.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';

class EditVendor extends StatefulWidget {
  const EditVendor({super.key});

  @override
  State<EditVendor> createState() => _EditVendorState();
}

class _EditVendorState extends State<EditVendor> {
  List<Vendor> vendors = [];
  List<Vendor> searchVen = [];
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool stop = false;
  fetchData() async {
    try {
      final data = await ApiService.fetchVendor(page, 9);
      if (data.isNotEmpty) {
        for (var element in data['items']) {
          setState(() {
            vendors.add(Vendor.fromJson(element));
          });
        }
      } else {
        setState(() {
          stop = true;
        });
      }
    } catch (e) {
      myToast(context, e);
    }
  }

  serchVendor(String name) {
    setState(() {
      searchVen = searchVen = vendors
          .where((element) => element.organizationName.contains(name))
          .toList();
    });
  }

  @override
  void initState() {
    fetchData();
    scrollController.addListener(_scrollController);
    super.initState();
  }

  _scrollController() {
    if (!stop) {
      // ignore: unrelated_type_equality_checks
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page += 1;
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 45,
            child: TextField(
                onChanged: (value) => serchVendor(value),
                decoration: InputDecoration(
                    iconColor: mainColor,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: mainColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: mainColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: mainColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Type....',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 15,
                    )))),
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollGlowEffect(),
            child: ListView.separated(
                controller: scrollController,
                itemBuilder: (_, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: mainColor,
                          child: Padding(
                            padding: EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  color: mainColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                vendors[i].organizationName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              height(3),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.envelope,
                                    size: 10,
                                    color: Colors.grey,
                                  ),
                                  width(3),
                                  Text(
                                    vendors[i].email,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.earth,
                                    size: 10,
                                    color: Colors.grey,
                                  ),
                                  width(5),
                                  Text(
                                    vendors[i].website,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            nextReplacement(
                                context,
                                ResponsiveLayout(
                                    mobileScaffold: MobileHomeScreen(
                                        pos: 'vendorForm', vendor: vendors[i]),
                                    tabletScaffold: TabletHomeScreen(
                                        pos: 'vendorForm', vendor: vendors[i]),
                                    laptopScaffold: LaptopHomeScreen(
                                        pos: 'vendorForm',
                                        vendor: vendors[i])));
                          },
                          icon: const Icon(Icons.edit, size: 15),
                          splashRadius: 15,
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, i) => height(10),
                itemCount: vendors.length),
          ),
        )
      ],
    );
  }
}
