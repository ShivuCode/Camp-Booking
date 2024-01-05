import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Models/camp_model.dart';
import '../../constant.dart';

// ignore: must_be_immutable
class CampDetail extends StatelessWidget {
  Camp camp;
  CampDetail({super.key, required this.camp});
  List headings = [
    "Camping Cost",
    "Timing",
    "Sharing Tent",
    "Snacks",
    "Barbeque",
    "Dinner",
    "Campfire",
    "Music",
    "Toilets",
    "Car Parking",
    "Breakfast",
    "Activities	",
    "Boating ",
    "WiFi	",
    "BathRoom	"
  ];
  List values = [
    " per person , Discounted Price as mentioned above",
    "4PM to next day 11AM", // Add a comma here
    "2/3/4 person sharing tents",
    "Tea, Pakoda",
    "200 grams per person (veg/nonveg)",
    "Unlimited Veg and Nonveg",
    "Yes, common",
    "Dj Speaker",
    "Yes, common",
    "Yes",
    "Tea, coffee,Bread, Jam, Poha, Anda bhurji ,Etc. ",
    "Cricket, Football, Badminton, Carrom, Volleyball,Archery and more ",
    "Extra cost",
    "No",
    "Yes, common"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.screenWidth > 900
              ? context.screenWidth * 0.6
              : double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                camp.titleImageUrl.contains("/Content/Uploads")
                    ? "https://PawnacampAppProd.titwi.in/${camp.titleImageUrl}"
                    : "https://PawnacampAppProd.titwi.in/content/camp/${camp.titleImageUrl}",
                fit: BoxFit.cover,
                height: context.screenWidth > 900 ? 350 : 250,
                width: double.infinity,
              ),
              height(5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        "Pawna lake camping is the greatest place for making your holiday special, which is near Pune and Lonavala within 26 km of Radious. our camping is offering comfortable tents, clean bathrooms, campfires, and delicious meals, allowing you to fully enjoy nature without sacrificing comfort. Join us at Pawna Camp for a memorable lakeside camping experience like no other!"),
                    height(5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        camp.campName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    height(5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          FontAwesomeIcons.locationDot,
                          size: 15,
                          color: mainColor,
                        ),
                        width(5),
                        Text(camp.campLocation,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    height(5),
                    Text("Rs.${camp.campFee}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              DataTable(
                headingRowColor: MaterialStateProperty.all(Vx.green50),
                columns: [
                  const DataColumn(label: Text("Inclusions")),
                  DataColumn(label: Text(camp.campName))
                ],
                rows: List.generate(
                  values.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text(headings[index])),
                      DataCell(Text(values[index])),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
