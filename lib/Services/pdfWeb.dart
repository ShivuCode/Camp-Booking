// // ignore: file_names
// import 'dart:convert';

// import 'package:url_launcher/url_launcher.dart';
// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;
// import 'package:flutter/foundation.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart';

saveWeb(pdfBytes, filename) async {
  print("yes");
  try {
    final directory =
        (await getExternalStorageDirectories(type: StorageDirectory.downloads))
            ?.first;
    ;
    File file = File("${directory!.path}/$filename.pdf");
    await file.writeAsBytes(pdfBytes);
    print("Lol");
  } catch (e) {
    print("Nahi");
  }
  // // Download document
  // html.AnchorElement(
  //     href:
  //         "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(pdfBytes)}")
  //   ..setAttribute("download", "invoice.pdf")
  //   ..click();
  // if (kDebugMode) {
  //   print("web download complete");
  // }
  // String url =
  //     "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(pdfBytes)}";
  // if (await canLaunch(url)) {
  //   await launch(url, forceSafariVC: false, forceWebView: false);
  // } else {
  //   // Handle error, such as showing an error message
  //   print('Could not launch $url');
  // }
}

// void shareWeb() async {}
