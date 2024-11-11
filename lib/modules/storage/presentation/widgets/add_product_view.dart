import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/storage/presentation/logic/adding_product_cubit/adding_product_cubit.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _numberOfPiecesController =
      TextEditingController();
  final TextEditingController _numberOfSizesController =
      TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final List<String> _categories = [
    'Shoes(Men)',
    'Shoes(Women)',
    'Bags',
    'Accessories'
  ];
  List<String?> availableSizes = [];
  String? _selectedCategory = "Shoes(Men)";
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

  void _addProduct(List<String?> availableSizes, ProductModel product) {
    BlocProvider.of<AddingProductCubit>(context).addProduct(product);
    BlocProvider.of<StorageProductsCubit>(context).getAllProducts();
    log("the list of sizes is ${availableSizes.length}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddingProductCubit, AddingProductState>(
      listener: (context, state) async {
        if (state is AddingProductFailure) {
          const AlertDialog(
            icon: Icon(Icons.close),
          );
        }
        if (state is AddingProductSuccess) {
          await Future.delayed(const Duration(seconds: 1));
          // ignore: use_build_context_synchronously
          // ignore: use_build_context_synchronously
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
              .showSnackBar(customizedSnackBar("product Added ✅ "));
        }
        if (state is AddingProductFailure) {
          await Future.delayed(const Duration(seconds: 1));
          // ignore: use_build_context_synchronously
          // ignore: use_build_context_synchronously
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
              .showSnackBar(customizedSnackBar("Error ❌"));
        }
      },
      builder: (context, state) {
        if (state is AddingProductSuccess) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return const Text("Done ✅");
            },
          );
        } else if (state is AddingProductFailure) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return const Text("something went wrong ❌");
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomizedTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "the field is required !";
                        } else {
                          return null;
                        }
                      },
                      tittle: 'Product Name',
                      maxLines: 1,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),
                    CustomizedTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "the field is required !";
                        } else {
                          return null;
                        }
                      },
                      tittle: 'ID',
                      controller: _idController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Only allow digits
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomizedTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "the field is required !";
                        } else if (int.parse(value!) < 0) {
                          return "enter a valid number";
                        } else {
                          return null;
                        }
                      },
                      tittle: 'number of pieces',
                      controller: _numberOfPiecesController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Only allow digits
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomizedTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "the field is required !";
                        } else if (int.parse(value!) < 0) {
                          return "enter a valid number";
                        } else {
                          return null;
                        }
                      },
                      tittle: 'number of sizes',
                      controller: _numberOfSizesController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Only allow digits
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomizedTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "the field is required !";
                        } else if (int.parse(value!) < 0) {
                          return "enter a valid number";
                        } else {
                          return null;
                        }
                      },
                      tittle: 'Price',
                      controller: _priceController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Only allow digits
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent, // Customize underline color
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.blueAccent), // Customize icon color
                      dropdownColor: Colors.white, // Dropdown background color
                      value: _selectedCategory,
                      hint: const Text('Select Category'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: _categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Upload Image'),
                    ),
                    if (_imagePath != null) ...[
                      const SizedBox(height: 16),
                      Image.file(File(_imagePath!),
                          height: 100), // Display selected image
                    ],
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.blue)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                availableSizes.length =
                                    int.parse(_numberOfSizesController.text);
                                _addProduct(
                                  availableSizes,
                                  ProductModel(
                                    name: _nameController.text,
                                    category: _selectedCategory ?? "Shoes(Men)",
                                    id: _idController.text,
                                    imagePath: _imagePath ??
                                        "D:/Programing/flutter/motors/assets/icons/00.png",
                                    price: _priceController.text,
                                    availablePieces: int.parse(
                                        _numberOfPiecesController.text),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Add product',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

SnackBar customizedSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    backgroundColor: Colors.black87, // Optional: custom background color
    duration: const Duration(seconds: 2), // Duration for the SnackBar
  );
}


//! the Sizes list   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                            //   backgroundColor: Colors.white,
                            //   context: context,
                            //   builder: (context) {
                            //     return Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: SizedBox(
                            //         height: 400,
                            //         width: 300,
                            //         child: Column(
                            //           children: [
                            //             Expanded(
                            //               child: ListView.builder(
                            //                 itemCount: int.parse(
                            //                     _numberOfSizesController.text),
                            //                 itemBuilder: (context, index) {
                            //                   return Padding(
                            //                     padding:
                            //                         const EdgeInsets.all(8.0),
                            //                     child: TextFormField(
                            //                       onChanged: (value) =>
                            //                           availableSizes[index] =
                            //                               value,
                            //                       inputFormatters: <TextInputFormatter>[
                            //                         FilteringTextInputFormatter
                            //                             .digitsOnly, // Only allow digits
                            //                       ],
                            //                       style: const TextStyle(
                            //                         fontSize: 20,
                            //                         fontWeight: FontWeight.bold,
                            //                       ),
                            //                       decoration: InputDecoration(
                            //                         labelText:
                            //                             "size ${index + 1}",
                            //                         labelStyle: const TextStyle(
                            //                           fontSize: 20,
                            //                           fontWeight:
                            //                               FontWeight.bold,
                            //                         ),
                            //                         border:
                            //                             const OutlineInputBorder(
                            //                           borderRadius:
                            //                               BorderRadius.all(
                            //                             Radius.circular(8.0),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       maxLines: 1,
                            //                     ),
                            //                   );
                            //                 },
                            //               ),
                            //             ),
                            //             ElevatedButton(
                            //               style: const ButtonStyle(
                            //                 backgroundColor:
                            //                     WidgetStatePropertyAll(
                            //                         Colors.blue),
                            //               ),
                            //               onPressed: _addProductWithSizes(
                            //                   availableSizes),
                            //               child: const Text(
                            //                 "Submit",
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Colors.white),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // )
                          