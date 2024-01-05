import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// ignore: must_be_immutable
class PdfViewer extends StatelessWidget {
  String path;
  PdfViewer({super.key, required this.path});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              splashRadius: 23,
              onPressed: () {
                // ignore: deprecated_member_use
                Share.shareFiles([path], text: "Invoice of Booking Camp");
              },
              icon: const Icon(Icons.share, color: Colors.black))
        ],
      ),
      body: PDFView(
        fitEachPage: true,
        filePath: path,
      ),
    );
  }
}
