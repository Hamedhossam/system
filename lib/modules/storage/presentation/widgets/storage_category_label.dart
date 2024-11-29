import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/storage/presentation/widgets/add_brand_bottom_sheet.dart';
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
            child: Text(
              'Add product',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue)),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) {
                return AddBrandBottomSheet(category: tittle);
              },
            );
          },
          child: Text(
            'New Brand',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
                  return const EditBrandsBottomSheet();
                },
              );
            },
            child: Text(
              'edit Brands',
              style: TextStyle(
                fontSize: 16.sp,
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

class EditBrandsBottomSheet extends StatefulWidget {
  const EditBrandsBottomSheet({
    super.key,
  });

  @override
  State<EditBrandsBottomSheet> createState() => _EditBrandsBottomSheetState();
}

class _EditBrandsBottomSheetState extends State<EditBrandsBottomSheet> {
  String _imagePath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imagePath =
            result.files.single.path!; // Get the path of the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text("the next update ISA"),
      ),
    );
  }
}
