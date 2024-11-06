import 'package:flutter/material.dart';
import 'package:motors/modules/storage/presentation/widgets/storage_item_widget.dart';

class AvailableItemsListView extends StatelessWidget {
  const AvailableItemsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 350,
          width: 1450,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return const StorageItemWidget();
            },
          ),
        ),
      ],
    );
  }
}
