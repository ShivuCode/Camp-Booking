import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

saveAnd(pdfBytes, context, filename) async {
  try {
    Directory? downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    File file = File('${downloadsDirectory?.path}/$filename');
    await file.writeAsBytes(pdfBytes);
    Fluttertoast.showToast(msg: 'Downloaded', gravity: ToastGravity.BOTTOM);
  } catch (e) {
    Fluttertoast.showToast(msg: '$e', gravity: ToastGravity.BOTTOM);
  }
}

share(path) async {
 
  Share.shareFiles(['$path'],
      text: "Invoice of Booking Camp");
}
