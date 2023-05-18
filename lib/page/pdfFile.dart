import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Function to generate the PDF file
Future<List<int>> generatePdf() async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text('Hello, world!', style: pw.TextStyle(fontSize: 24)),
      );
    },
  ));

  return pdf.save();
}

class PdfGeneratorPage extends StatefulWidget {
  const PdfGeneratorPage({Key? key}) : super(key: key);

  @override
  _PdfGeneratorPageState createState() => _PdfGeneratorPageState();
}

class _PdfGeneratorPageState extends State<PdfGeneratorPage> {
  bool _isLoading = false;
  String _message = '';

  // Function to save and open the PDF file
  Future<void> _saveAndOpenPdf() async {
    setState(() {
      _isLoading = true;
      _message = 'Generating PDF...';
    });

    // Generate the PDF file
    final pdfBytes = await generatePdf();

    // Save the PDF file to the device
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/example.pdf');
    await file.writeAsBytes(pdfBytes);

    setState(() {
      _isLoading = false;
      _message = 'PDF generated successfully';
    });

    // Open the PDF file using the default PDF viewer on the device
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _saveAndOpenPdf,
                child: Text('Generate PDF'),
              ),
            SizedBox(height: 16),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
