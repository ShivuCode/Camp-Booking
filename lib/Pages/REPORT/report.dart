import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/Services/export.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Models/customer_model.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _formDate = '';
  String _toDate = '';
  int page = 1;
  bool stop = false;
  List<Customer> customers = [];
  List<Customer> filterData = [];
  final ScrollController _scrollControler = ScrollController();

  filter() async {
    if (_formDate.isNotEmpty && _toDate.isNotEmpty) {
      stop = false;
      filterData = [];

      final data = await ApiService.findByFromToDate(_formDate, _toDate, page);
      if (data.isNotEmpty) {
        for (var element in data) {
          setState(() {
            filterData.add(Customer.fromJson(element));
          });
        }
      } else {
        stop = true;
        page = 1;
      }
    } else {
      final data = await ApiService.fetchDataPage(page, 14);
      if (data.isNotEmpty) {
        for (var element in data['items']) {
          setState(() {
            filterData.add(Customer.fromJson(element));
          });
        }
      } else {
        stop = true;
        page = 1;
      }
    }
  }

  @override
  void initState() {
    _scrollControler.addListener(scrollController);
    filter();
    super.initState();
  }

  @override
  void dispose() {
    _scrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Download file in Excel"),
                        height(5),
                        ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(120, 40)),
                                backgroundColor:
                                    MaterialStateProperty.all(mainColor)),
                            onPressed: () {
                              Export.excel(customers);
                            },
                            child: const Text("Download")),
                        height(15),
                        const Text("Download file in Pdf"),
                        height(5),
                        ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(120, 40)),
                                backgroundColor:
                                    MaterialStateProperty.all(mainColor)),
                            onPressed: () {
                              Export.pdf(customers);
                            },
                            child: const Text("Download"))
                      ],
                    ),
                    actions: [
                      TextButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(mainColor),
                              minimumSize:
                                  MaterialStateProperty.all(const Size(80, 36)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      side: BorderSide(color: mainColor)))),
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"))
                    ],
                  ));
        },
        child: const Icon(Icons.download),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text("From: ",
                      style: TextStyle(
                          fontSize: size < 320 ? 10 : 13,
                          fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _formDate.isEmpty
                            ? DateTime.now()
                            : DateTime.parse(_formDate),
                        firstDate: DateTime(2003),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && _formDate != picked) {
                        setState(() {
                          DateFormat format = DateFormat("yyyy-MM-dd");
                          _formDate = format.format(picked);
                        });
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(10),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15)),
                      minimumSize: MaterialStateProperty.all(Size(
                          size > 600 ? 100 : size * 0.18,
                          size < 320 ? 36 : 45)),
                      maximumSize:
                          MaterialStateProperty.all(const Size(140, 45)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    child: Text(
                      _formDate.isEmpty ? 'Select Date' : _formDate,
                      style: TextStyle(fontSize: size < 320 ? 10 : 13),
                    ),
                  ),
                  width(10),
                  Text("To: ",
                      style: TextStyle(
                          fontSize: size < 320 ? 10 : 13,
                          fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _toDate.isEmpty
                            ? DateTime.now()
                            : DateTime.parse(_toDate),
                        firstDate: DateTime(2003),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && _toDate != picked) {
                        setState(() {
                          DateFormat format = DateFormat("yyyy-MM-dd");
                          _toDate = format.format(picked);
                        });
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(10),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15)),
                      minimumSize: MaterialStateProperty.all(Size(
                          size > 600 ? 100 : size * 0.18,
                          size < 320 ? 36 : 45)),
                      maximumSize:
                          MaterialStateProperty.all(const Size(140, 45)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    child: Text(
                      _toDate.isEmpty ? 'Select Date' : _toDate,
                      style: TextStyle(fontSize: size < 320 ? 10 : 13),
                    ),
                  ),
                  width(10),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(mainColor),
                          minimumSize: MaterialStateProperty.all(Size(
                              size > 600 ? 100 : size * 0.18,
                              size < 320 ? 36 : 45)),
                          maximumSize:
                              MaterialStateProperty.all(const Size(140, 45))),
                      onPressed: () {
                        filter();
                      },
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: size < 320 ? 10 : 13),
                      ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              alignment:
                  filterData.isEmpty ? Alignment.center : Alignment.topLeft,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8)),
              child: ScrollConfiguration(
                behavior: ScrollGlowEffect(),
                child: SingleChildScrollView(
                  controller: _scrollControler,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: filterData.isEmpty
                        ? const Text(
                            "No Data Founded",
                            textAlign: TextAlign.center,
                          )
                        : DataTable(
                            columns: colums(),
                            rows: rows(),
                          ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void scrollController() {
    if (!stop) {
      // ignore: unrelated_type_equality_checks
      if (_scrollControler.position.pixels ==
          _scrollControler.position.maxScrollExtent) {
        page += 1;
        filter();
      }
    }
  }

  colums() {
    final header = [
      "Id",
      "Name",
      "Mobile",
      "Email",
      "Address",
      "Booking Date",
      "Adults",
      "Childs",
      "Veg Count",
      "Non-veg Count",
      "Fee",
      "Total",
      "Advance",
      "Remaining"
    ];
    return List.generate(
        header.length,
        (index) => DataColumn(
                label: Text(
              header[index],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )));
  }

  rows() {
    return List.generate(
        filterData.length,
        (index) => DataRow(cells: [
              DataCell(text(filterData[index].id.toString())),
              DataCell(text(
                  "${filterData[index].name.substring(0, 1).toUpperCase()}${filterData[index].name.substring(1).toLowerCase()}")),
              DataCell(text(filterData[index].mobNo)),
              DataCell(text(filterData[index].email)),
              DataCell(text(filterData[index].address)),
              DataCell(text(filterData[index].bookingDate.split('T').first)),
              DataCell(text(filterData[index].adult.toString())),
              DataCell(text(filterData[index].child.toString())),
              DataCell(text(filterData[index].vegPeopleCount.toString())),
              DataCell(text(filterData[index].nonVegPeopleCount.toString())),
              DataCell(text(filterData[index].price.toString())),
              DataCell(text(
                  ((filterData[index].price * filterData[index].adult) +
                          ((filterData[index].price * 0.45) *
                              filterData[index].child))
                      .toString())),
              DataCell(text(filterData[index].advAmt.toString())),
              DataCell(text(
                  (((filterData[index].price * filterData[index].adult) +
                              ((filterData[index].price * 0.45) *
                                  filterData[index].child)) -
                          filterData[index].advAmt)
                      .toString()))
            ]));
  }

  text(value) {
    return Text(value,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400));
  }
}
