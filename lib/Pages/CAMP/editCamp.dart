import 'package:camp_booking/Services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Models/camp_model.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../../constant.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';

class EditCamps extends StatefulWidget {
  const EditCamps({super.key});

  @override
  State<EditCamps> createState() => _EditCampsState();
}

class _EditCampsState extends State<EditCamps> {
  List<Camp> camps = [];
  List<Camp> searchList = [];
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool stop = false;
  fetchData() async {
    final data = await ApiService.fetchCampData(page, 8);
    if (data.isNotEmpty) {
      print(data);
      for (final element in data['items']) {
        setState(() {
          camps.add(Camp.fromJson(element));
        });
      }
    } else {
      stop = true;
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
  void initState() {
    fetchData();
    scrollController.addListener(_scroll);
    super.initState();
  }

  _scroll() {
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
    double size = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
      behavior: ScrollGlowEffect(),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 45,
                child: TextField(
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
            Wrap(
                runSpacing: 5,
                spacing: 5,
                children: List.generate(
                    camps.length,
                    (i) => SizedBox(
                          width: size > 600 ? 210 : size * 0.445,
                          height: size > 600 ? 210 : size * 0.445,
                          child: Stack(children: [
                            Container(
                                alignment: Alignment.bottomRight,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        onError: (exception, stackTrace) {},
                                        image: NetworkImage(camps[i]
                                                .titleImageUrl
                                                .contains("/Content/Uploads")
                                            ? "https://PawnacampAppProd.titwi.in/${camps[i].titleImageUrl}"
                                            : "https://PawnacampAppProd.titwi.in/content/camp/${camps[i].titleImageUrl}"),
                                        fit: BoxFit.cover)),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(3))),
                                  child: Text(
                                    "Rs. ${camps[i].campFee}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                )),
                            InkWell(
                              onTap: () => nextScreen(
                                  context,
                                  ResponsiveLayout(
                                      mobileScaffold: MobileHomeScreen(
                                        pos: 'editCamp',
                                        camp: camps[i],
                                      ),
                                      tabletScaffold: TabletHomeScreen(
                                          pos: 'editCamp', camp: camps[i]),
                                      laptopScaffold: LaptopHomeScreen(
                                          pos: 'editCamp', camp: camps[i]))),
                              child: Container(
                                  margin: const EdgeInsets.all(4),
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 10,
                                    color: Colors.white,
                                  )),
                            )
                          ]),
                        )))
          ],
        ),
      ),
    );
  }
}
