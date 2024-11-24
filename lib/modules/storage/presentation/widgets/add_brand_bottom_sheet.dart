import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/screens/home_screen.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/storage/presentation/logic/adding_brand_cubit/add_brand_cubit.dart';
import 'package:motors/modules/storage/presentation/widgets/add_product_view.dart';

class AddBrandBottomSheet extends StatefulWidget {
  const AddBrandBottomSheet({
    required this.category,
    super.key,
  });
  final String category;
  @override
  State<AddBrandBottomSheet> createState() => _AddBrandBottomSheetState();
}

class _AddBrandBottomSheetState extends State<AddBrandBottomSheet> {
  String? _imagePath;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imagePath =
            result.files.single.path; // Get the path of the selected image
      });
    }
  }

  TextEditingController _brandNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      width: 400.w,
      child: BlocConsumer<AddBrandCubit, AddBrandState>(
        listener: (context, state) async {
          if (state is AddBrandSuccess) {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
                .showSnackBar(customizedSnackBar("Brand Added ✅ "));
          }
          if (state is AddBrandFail) {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(customizedSnackBar("Error ❌"));
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Add New Brand",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "To : > ${widget.category} <",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    CustomizedTextField(
                      controller: _brandNameController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "please add brand name";
                        } else {
                          return null;
                        }
                      },
                      tittle: "Brand Name",
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Upload Image'),
                    ),
                    if (_imagePath != null) ...[
                      const SizedBox(height: 16),
                      Image.file(File(_imagePath!),
                          height: 100.h), // Display selected image
                    ],
                    SizedBox(height: 8.h),
                    CustomizedButton(
                      tittle: "Add Brand",
                      myColor: Colors.blue,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AddBrandCubit>(context).addBrand(
                            category: widget.category,
                            brandName: _brandNameController.text,
                            imagePath: _imagePath ??
                                "D:/Programing/flutter/motors/assets/icons/00.png",
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
