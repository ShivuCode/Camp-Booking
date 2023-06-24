// // // ignore: file_names
// import 'dart:convert';

// import 'dart:html' as html;

// import 'package:flutter/foundation.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// saveWeb(pdfBytes, filename) async {
//   // Download document
//   html.AnchorElement(
//       href:
//           "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(pdfBytes)}")
//     ..setAttribute("download", "$filename.pdf")
//     ..click();

//   Fluttertoast.showToast(msg: "Downloaded");
//   if (kDebugMode) {
//     print("web download complete");
//   }
// }
