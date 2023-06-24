import 'dart:io';

import 'package:camp_booking/Models/customer_model.dart';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class Export {
  static void excel(List<Customer> customers) async {
    var excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];
    sheet.headerFooter;

    for (int i = 0; i < customers.length; i++) {
      double total = (customers[i].price * customers[i].adult) +
          ((customers[i].price * 0.45) * customers[i].child);
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
          .value = customers[i].id.toString();
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
          .value = customers[i].name;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
          .value = customers[i].mobNo;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
          .value = customers[i].address;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
          .value = customers[i].email;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
          .value = customers[i].bookingDate;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
          .value = customers[i].adult.toString();
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i))
          .value = customers[i].child.toString();
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i))
          .value = customers[i].vegPeopleCount.toString();
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i))
          .value = customers[i].nonVegPeopleCount.toString();
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i))
          .value = customers[i].price;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i))
          .value = total;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i))
          .value = customers[i].advAmt;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i))
          .value = total - customers[i].advAmt;
    }
    if (kIsWeb) {
      excel.save(fileName: 'invoice.xlsx');
      Fluttertoast.showToast(msg: "Downloaded");
    } else {
      if (await Permission.storage.request().isGranted) {
        var fileBytes = excel.save(fileName: 'data.xlsx');
        final directory = (await getExternalStorageDirectories(
                type: StorageDirectory.downloads))!
            .first;
        File file = File("${directory.path}/data.xlsx");
        file.writeAsBytes(fileBytes!);
        Fluttertoast.showToast(msg: "Downloaded");
      } else {
        Fluttertoast.showToast(msg: "Required Permission");
      }
    }
  }

//exporting data in pdf format
  static void pdf(List<Customer> customers) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
        margin: const EdgeInsets.all(10),
        build: (_) => [
              SizedBox(height: 30),
              builtTable(customers),
            ]));
    if (kIsWeb) {
      pdf.save();
      Fluttertoast.showToast(msg: "Downloaded");
    } else {
      if (await Permission.storage.request().isGranted) {
        final directory = (await getExternalStorageDirectories(
                type: StorageDirectory.downloads))!
            .first;
        File file = File("${directory.path}/data.pdf");
        file.writeAsBytes(await pdf.save());
        Fluttertoast.showToast(msg: "Downloaded");
      } else {
        Fluttertoast.showToast(msg: "Required Permission");
      }
    }
  }
}

builtTable(List<Customer> customers) {
  final header = [
    'ID',
    "NAME",
    "MOBILE",
    "EMAIL",
    "ADDRESS",
    "ADULT",
    "CHILD",
    "VEG/NON-VEG",
    "FEE",
    "TOTAL",
    "ADVANCE",
    "REMAINING"
  ];
  List<List<dynamic>> data = List.generate(
      customers.length,
      (i) => [
            customers[i].id.toString(),
            customers[i].name,
            customers[i].mobNo,
            customers[i].email,
            customers[i].address,
            customers[i].adult.toString(),
            customers[i].child.toString(),
            "${customers[i].vegPeopleCount},${customers[i].nonVegPeopleCount}",
            customers[i].price,
            ((customers[i].price * customers[i].adult) +
                    ((customers[i].price * 0.45) * customers[i].child))
                .toString(),
            customers[i].advAmt,
            (((customers[i].price * customers[i].adult) +
                        ((customers[i].price * 0.45) * customers[i].child)) -
                    (customers[i].price))
                .toString()
          ]).toList();
  return Table.fromTextArray(
      data: data,
      cellStyle: const TextStyle(fontSize: 8),
      headerDecoration: const BoxDecoration(color: PdfColors.blueGrey200),
      columnWidths: {
        0: const FixedColumnWidth(100),
        1: const FixedColumnWidth(180),
        2: const FixedColumnWidth(180),
        3: const FixedColumnWidth(300),
        4: const FixedColumnWidth(150),
        5: const FixedColumnWidth(120),
        6: const FixedColumnWidth(120),
        7: const FixedColumnWidth(120),
        8: const FixedColumnWidth(120),
        9: const FixedColumnWidth(120),
        10: const FixedColumnWidth(130),
        11: const FixedColumnWidth(130),
      },
      headers: header,
      headerStyle: TextStyle(fontSize: 6, fontWeight: FontWeight.bold));
}
