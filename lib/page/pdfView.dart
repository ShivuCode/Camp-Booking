import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// ignore: must_be_immutable
class PdfViewer extends StatelessWidget {
  String path;
  PdfViewer({super.key,required this.path});
  @override
  Widget build(BuildContext context) {
    return PDFView(
      fitEachPage: true,
      filePath: path,
    );
  }
}
