import 'package:camp_booking/Pages/CAMP/campDetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/camp_model.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../../Services/api.dart';
import '../../constant.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';
import '../Home/mobileHomeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Camp> campList = [];
  bool isCardScratched = false;
  bool isRegister = false;
  isRegisterCheck() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    bool y = sf.getBool('isRegister') ?? false;

    setState(() {
      isRegister = y;
    });
  }

  fetchData() async {
    final data = await ApiService.fetchCampData(1, 8);
    for (var element in data['items']) {
      setState(() {
        campList.add(Camp.fromJson(element));
      });
    }
  }

  @override
  void initState() {
    isRegisterCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> messages = [
      "Hello!",
      "How are you?",
      "This is a test message.",
      "Flutter is awesome!",
    ];
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {},
        child: const Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.maxFinite, 50))),
                  onPressed: () {
                    if (isRegister) {
                      nextScreen(
                          context,
                          ResponsiveLayout(
                              mobileScaffold: MobileHomeScreen(
                                pos: 'addCamp',
                              ),
                              tabletScaffold: TabletHomeScreen(
                                pos: 'addCamp',
                              ),
                              laptopScaffold: LaptopHomeScreen(
                                pos: 'addCamp',
                              )));
                    } else {
                      nextReplacement(
                          context,
                          ResponsiveLayout(
                              mobileScaffold: MobileHomeScreen(
                                pos: "vendorForm",
                              ),
                              tabletScaffold:
                                  TabletHomeScreen(pos: "vendorForm"),
                              laptopScaffold:
                                  LaptopHomeScreen(pos: "vendorForm")));
                    }
                  },
                  child: Text(isRegister ? " + Add Camp" : "Registration")),
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
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: mainColor,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
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
            isRegister
                ? Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                        campList.length,
                        (i) => GestureDetector(
                              onTap: () {
                                nextScreen(
                                    context, CampDetail(camp: campList[i]));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: size > 600 ? 210 : size * 0.445,
                                      height: size > 600 ? 210 : size * 0.445,
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  campList[i].titleImageUrl),
                                              fit: BoxFit.cover)),
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(3))),
                                        child: Text(
                                          "Rs. ${campList[i].campFee}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      )),
                                ],
                              ),
                            )))
                : const Center(
                    child: Text("You are not register vendor...."),
                  )
          ]),
        ),
      ),
    );
  }
}
