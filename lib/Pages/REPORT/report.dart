import 'package:camp_booking/Services/api.dart';
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
  List<Customer> customers = [];
  List<Customer> filterData = [];
  fetchData() async {
    final data = await ApiService.fetchData();
    for (var element in data) {
      setState(() {
        customers.add(Customer.fromJson(element));
      });
    }
    filterData = customers.toList();
  }

  filter() {
    if (_formDate.isNotEmpty && _toDate.isNotEmpty) {
      filterData = [];
      setState(() {
        filterData.addAll(customers.where((element) =>
            DateTime.parse(element.bookingDate)
                .isAfter(DateTime.parse(_formDate)) &&
            DateTime.parse(element.bookingDate)
                .isBefore(DateTime.parse(_toDate))));
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
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text("From: ",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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
                    minimumSize: MaterialStateProperty.all(const Size(120, 45)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  child: Text(
                    _formDate.isEmpty ? 'Select Date' : _formDate,
                  ),
                ),
                width(10),
                const Text("To: ",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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
                    minimumSize: MaterialStateProperty.all(const Size(120, 45)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  child: Text(
                    _toDate.isEmpty ? 'Select Date' : _toDate,
                  ),
                ),
                width(10),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor),
                        minimumSize:
                            MaterialStateProperty.all(const Size(120, 45))),
                    onPressed: () {
                      filter();
                    },
                    child: const Text("Search"))
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
            child: SingleChildScrollView(
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
          ))
        ],
      ),
    );
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
