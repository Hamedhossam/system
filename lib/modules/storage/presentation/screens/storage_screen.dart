import 'package:flutter/material.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/modules/storage/presentation/widgets/add_product_view.dart';
import 'package:motors/modules/storage/presentation/widgets/storage_tittle_widget.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StorageTittleWidget(),
          HorizentalLine(),
        ],
      ),
    );
  }
}
