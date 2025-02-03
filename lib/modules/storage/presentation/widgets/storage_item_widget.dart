import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/shopping_products_cubit/shopping_products_cubit.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';

class StorageItemWidget extends StatelessWidget {
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('⚠️ Do you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                productModel.delete();
                BlocProvider.of<StorageProductsCubit>(context).getAllProducts();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
          backgroundColor: Colors.white, // Dark background color
          // titleTextStyle: const TextStyle(color: Colors.white),
          // contentTextStyle: const TextStyle(color: Colors.white),
        );
      },
    );
  }

  PersistentBottomSheetController _editProduct(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: productModel.name);
    TextEditingController availablePicesController =
        TextEditingController(text: productModel.availablePieces.toString());
    TextEditingController priceController =
        TextEditingController(text: productModel.price);
    return showBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return EditProductBottomSheet(
            nameController: nameController,
            availablePicesController: availablePicesController,
            priceController: priceController,
            productModel: productModel);
      },
    );
  }

  const StorageItemWidget({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: (productModel.availablePieces <= 1)
                    ? Colors.red
                    : Colors.green,
                width: 2.w),
            borderRadius: BorderRadius.circular(10)),
        child: Card(
          color: const Color.fromARGB(255, 235, 233, 233),
          elevation: 4.0,
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: 300.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(File(productModel.imagePath)),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                productModel.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(height: 5.h),
              //! id Section
              Row(
                children: [
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 230.w,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "Id                  : (${productModel.id})",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
              //! Availabe Sizes Section
              Row(
                children: [
                  SizedBox(width: 5.w),
                  (productModel.availablePieces < 1)
                      ? SizedBox(
                          width: 230.w,
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "( SOLD OUT ! )",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 230.w,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            "Available Pices : ${productModel.availablePieces.toString()}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                ],
              ),
              //! Price Section
              Row(
                children: [
                  SizedBox(
                    width: 230.w,
                    child: Row(
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "Price               : ",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "${productModel.price} LE",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  productModel.availablePieces == 0
                      ? const SizedBox()
                      : ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: () {
                            _editProduct(context);
                          },
                          child: Text(
                            'edit',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 50.w,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    child: Text(
                      'delete',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProductBottomSheet extends StatefulWidget {
  const EditProductBottomSheet({
    super.key,
    required this.nameController,
    required this.availablePicesController,
    required this.priceController,
    required this.productModel,
  });
  final TextEditingController nameController;
  final TextEditingController availablePicesController;
  final TextEditingController priceController;
  final ProductModel productModel;

  @override
  State<EditProductBottomSheet> createState() => _EditProductBottomSheetState();
}

class _EditProductBottomSheetState extends State<EditProductBottomSheet> {
  String _imagePath = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePath = widget.productModel.imagePath;
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 1050.h,
        width: 500.w,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Upload Image'),
              ),
              ...[
                SizedBox(height: 16.h),
                Image.file(File(_imagePath),
                    height: 100.h), // Display selected image
              ],
              SizedBox(height: 16.h),
              CustomizedTextField(
                onChanged: (value) => widget.productModel.name = value,
                tittle: "name",
                maxLines: 1,
                controller: widget.nameController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomizedTextField(
                tittle: "available Pices",
                maxLines: 1,
                controller: widget.availablePicesController,
                onChanged: (value) => setState(() {
                  if (value.isEmpty) {
                    widget.productModel.availablePieces = 0;
                  } else {
                    widget.productModel.availablePieces = int.parse(value);
                    if (widget.productModel.availablePieces >
                        widget.productModel.availableSizes!.length) {
                      List<String> sizes = List.generate(
                        widget.productModel.availablePieces -
                            widget.productModel.availableSizes!.length,
                        (index) => '0',
                      );
                      widget.productModel.availableSizes!.addAll(sizes);
                    }
                  }
                }),
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomizedTextField(
                tittle: "price",
                maxLines: 1,
                controller: widget.priceController,
                onChanged: (value) => widget.productModel.price = value,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              const Label(tittle: "Set sizes"),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.productModel.availablePieces,
                  itemBuilder: (context, index) {
                    TextEditingController sizeController =
                        TextEditingController();
                    sizeController.text =
                        widget.productModel.availableSizes![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: sizeController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "field is required";
                          }
                          return null;
                        },
                        onSaved: (value) => widget
                            .productModel.availableSizes![index] = value ?? '0',
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Only allow digits
                        ],
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: "size ${index + 1}",
                          labelStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        maxLines: 1,
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // widget.productModel.imagePath = _imagePath;
                    // Navigator.pop(context);
                    widget.productModel.imagePath = _imagePath;
                    List<int> sortedNumbers = widget
                        .productModel.availableSizes!
                        .map(int.parse)
                        .toList()
                      ..sort();
                    widget.productModel.availableSizes =
                        sortedNumbers.map((e) => e.toString()).toList();
                    await widget.productModel.save();
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<StorageProductsCubit>(context)
                        .getAllProducts();
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<ShoppingProductsCubit>(context)
                        .getAllProducts();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
