import 'package:flutter/material.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/modules/storage/presentation/widgets/add_product_view.dart';

class StorageCategoryLabel extends StatelessWidget {
  const StorageCategoryLabel({
    super.key,
    required this.tittle,
    required this.image,
  });
  final String tittle, image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 30,
          ),
        ),
        Label(tittle: tittle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return const AddProductView();
                },
              );
            },
            child: const Text(
              'Add product',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
