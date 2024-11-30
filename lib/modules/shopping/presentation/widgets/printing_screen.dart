import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/modules/orders/logic/orders_cubit/orders_cubit.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PillScreen extends StatelessWidget {
  const PillScreen({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Back"),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf("Order", orderModel, context),
      ),
    );
  }
}

String removeFirstTwoWords(String input) {
  // Split the string into words
  List<String> words = input.split(' ');

  // Check if the list has more than two words
  if (words.length <= 2) {
    return ''; // Return an empty string if there are two or fewer words
  }

  // Return the remaining words as a single string
  return words.sublist(2).join(' ');
}

String getFirstWord(String input) {
  // Split the string by whitespace and return the last element
  return input.split(' ').first;
}

Future<Uint8List> loadImage(String path) async {
  final ByteData data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}

Future<Uint8List> _generatePdf(
    String title, OrderModel order, BuildContext context) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  // final font = await PdfGoogleFonts.nunitoExtraLight();
  // List<ProductModel> allProducts =
  //     BlocProvider.of<StorageProductsCubit>(context).allProducts;
  const String storeIconPath = 'assets/icons/00.png'; // Path to your icon
  final ByteData imageData = await rootBundle.load(storeIconPath);
  imageData.buffer.asUint8List();
  final Uint8List image1 = await loadImage("assets/images/logo.png");
  final Uint8List image2 = await loadImage("assets/images/QrCode.png");
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      //PdfPageFormat(7.5 / 2.54 * 72, 23 / 2.54 * 72),
      build: (_) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            // Logo
            pw.Image(pw.MemoryImage(image1), height: 200, width: 200),
            // Address
            pw.Text(
                "Saeed St, after Sedqi intersecion under Adams Cafe - 1st coridor on the left ",
                textAlign: pw.TextAlign.center),
            pw.Text("[ Tanta - 3111 ]", textAlign: pw.TextAlign.center),
            pw.Text("Mobile : 01550062911", textAlign: pw.TextAlign.center),
            pw.SizedBox(height: 10),
            // Horizontal line
            pw.Divider(),
            pw.SizedBox(height: 10),
            // Client details
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text('Order ID :  ${order.id}'),
            ),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text('Client Name :  ${order.clientName}'),
            ),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text('Mobile :  ${order.clientPhone}'),
            ),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text('Sales Manager :  Bassam Ehab'),
            ),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text('Date :  ${order.date}'),
            ),
            pw.SizedBox(height: 10),
            // Horizontal line
            pw.Divider(),
            // Table
            pw.Padding(
              padding: const pw.EdgeInsets.only(
                right: 9,
              ),
              child: pw.Table(
                columnWidths: const {
                  // 0: pw.FixedColumnWidth(20), // ID column width
                  0: pw.FixedColumnWidth(40), // Product Name column width
                  1: pw.FixedColumnWidth(20), // Price column width
                  2: pw.FixedColumnWidth(20), // Discount column width
                  3: pw.FixedColumnWidth(20), // Total column width
                },
                border: pw.TableBorder.all(),
                children: [
                  // Header row
                  pw.TableRow(children: [
                    // pw.Padding(
                    //     padding: const pw.EdgeInsets.all(8), child: pw.Text('#')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Products Details',
                          style: const pw.TextStyle(fontSize: 8),
                        )),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Price',
                          style: const pw.TextStyle(fontSize: 8),
                        )),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Disc%',
                          style: const pw.TextStyle(fontSize: 8),
                        )),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Total',
                          style: const pw.TextStyle(fontSize: 8),
                        )),
                  ]),
                  // Data rows
                  ...List.generate(order.products.length, (index) {
                    return pw.TableRow(children: [
                      // pw.Padding(
                      //   padding: const pw.EdgeInsets.all(8),
                      //   child: pw.Text((index + 1).toString()),
                      // ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          order.products[index],
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          "${(double.parse(getFirstWord(order.products[index])) * double.parse(BlocProvider.of<StorageProductsCubit>(context).getPrice(removeFirstTwoWords(order.products[index])))).toString()} LE",
                          style: const pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          BlocProvider.of<StorageProductsCubit>(context)
                              .getDiscount(
                                  removeFirstTwoWords(order.products[index])),
                          style: const pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          BlocProvider.of<StorageProductsCubit>(context)
                              .getPriceAfterDiscount(
                                  removeFirstTwoWords(order.products[index])),
                          style: const pw.TextStyle(fontSize: 7),
                        ),
                      ),
                    ]);
                  }),
                ],
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Total cost :  ${BlocProvider.of<OrdersCubit>(context).getTotalCost(order.id)} LE   ',
                style: const pw.TextStyle(fontSize: 8),
              ),
            ),
            pw.SizedBox(height: 10),
            // Horizontal line
            pw.Divider(),
            pw.SizedBox(height: 10),
            // Center text
            pw.Center(
                child: pw.Text(
                    textAlign: pw.TextAlign.center,
                    '" Returns are accepted within 7 days of the purchase date "')),
            // Images from assets
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Image(
                  pw.MemoryImage(image2),
                  height: 100,
                  width: 100,
                ),
              ],
            ),
            pw.Text(
              textAlign: pw.TextAlign.center,
              'Developed by Alpha Softwares (0106387697)',
              style: pw.TextStyle(fontSize: 8.sp),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
