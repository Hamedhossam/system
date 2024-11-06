import 'package:flutter/material.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/modules/storage/presentation/widgets/available_items_list_view.dart';
import 'package:motors/modules/storage/presentation/widgets/storage_category_label.dart';
import 'package:motors/modules/storage/presentation/widgets/storage_tittle_widget.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StorageTittleWidget(),
            HorizentalLine(),
            StorageCategoryLabel(
                tittle: 'Shoes(Men)', image: 'assets/images/shoes_men.jpg'),
            AvailableItemsListView(),
            StorageCategoryLabel(
                tittle: 'Shoes(Women)', image: 'assets/images/shoes_women.jpg'),
            AvailableItemsListView(),
            StorageCategoryLabel(
                tittle: 'Bags', image: 'assets/images/bags.jpg'),
            AvailableItemsListView(),
            StorageCategoryLabel(
                tittle: 'Accessories', image: 'assets/images/accessories2.jpg'),
            AvailableItemsListView(),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
