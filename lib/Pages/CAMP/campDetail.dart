import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';

import '../../Models/camp_model.dart';
import '../../Models/customer_model.dart';

// ignore: must_be_immutable
class CampDetail extends StatefulWidget {
  Camp? camp;
  CampDetail({super.key, this.camp});

  @override
  State<CampDetail> createState() => _CampDetailState();
}

class _CampDetailState extends State<CampDetail> {
  List<Customer> customers = [];
  List<Customer> searchCustomer = [];
  fetchData() async {
    final data = await ApiService.fetchData();
    for (var element in data) {
      setState(() {
        customers.add(Customer.fromJson(element));
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(widget.camp!.titleImageUrl),
                      fit: BoxFit.cover)),
            ),
            height(10),
            Text(widget.camp!.campName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const Text(
                "Beautiful Couple Camping With Decoration light, food & support.",
                style: TextStyle(fontSize: 14)),
            height(5),
            Text(
              " ₹${widget.camp!.campFee}.0",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            height(10),
            const Text("Food and Beverages",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            height(5),
            const Text(
                "Breakfast Included\nBbq Marination Non-Veg @ ₹560\nBbq Marination Veg @ ₹730\nCamping Stoves @ ₹560\nBbq Grill And Coal @ ₹850\nTea And Snacks @ ₹170"),
            height(20),
            const Text("Customers Which are Booked This Camp.."),
            height(10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(columns: header(), rows: rows())),
            )
          ]),
        ),
      )),
    );
  }

  header() {
    final header = ["ID", "NAME", "MOBILE", "ADVANCE"];
    return List.generate(
        header.length,
        (index) => DataColumn(
                label: Text(
              header[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
  }

  rows() {
    return List.generate(
        customers.length,
        (index) => DataRow(cells: [
              DataCell(Text(customers[index].id.toString())),
              DataCell(Text(customers[index].name)),
              DataCell(Text(customers[index].mobNo)),
              DataCell(Text(customers[index].advAmt.toString()))
            ]));
  }
}
