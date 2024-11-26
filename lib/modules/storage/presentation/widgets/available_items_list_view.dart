import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/storage/presentation/widgets/storage_item_widget.dart';

class AvailableItemsListView extends StatelessWidget {
  const AvailableItemsListView({
    required this.products,
    super.key,
  });
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 400.h,
          width: 1450.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return StorageItemWidget(
                productModel: products[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
