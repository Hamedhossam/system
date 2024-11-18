import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PillScreen extends StatelessWidget {
  const PillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Back"),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, "In Store"),
      ),
    );
  }
}

Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.nunitoExtraLight();
  const String storeIconPath = 'assets/icons/00.png'; // Path to your icon
  final ByteData imageData = await rootBundle.load(storeIconPath);
  final Uint8List imageBytes = imageData.buffer.asUint8List();
  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Column(
          children: [
            pw.SizedBox(
              width: double.infinity,
              child: pw.FittedBox(
                child: pw.Text(title, style: pw.TextStyle(font: font)),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Flexible(
              child:
                  pw.Image(pw.MemoryImage(imageBytes), width: 100, height: 100),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
