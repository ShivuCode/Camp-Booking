import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFExample extends StatefulWidget {
  @override
  _PDFExampleState createState() => _PDFExampleState();
}

class _PDFExampleState extends State<PDFExample> {
  final pdf = pw.Document();

  void generatePDF() {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text("Hello World"),
        ),
      ),
    );
  }

  Future<File> savePDF() async {
    final directory = await getExternalStorageDirectory();
    final path = directory!.path;
    final file = File("$path/example.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Generate PDF"),
              onPressed: () {
                generatePDF();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Save PDF"),
              onPressed: () async {
                File file = await savePDF();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("PDF saved to ${file.path}"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
