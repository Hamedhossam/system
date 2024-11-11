import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:motors/core/widgets/text_field.dart';

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

  void _addProduct(List<String?> availableSizes) {
    log("the list of sizes is ${availableSizes.length}");
  }

  @override
  Widget build(BuildContext context) {
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
                  FilteringTextInputFormatter.digitsOnly, // Only allow digits
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
                  FilteringTextInputFormatter.digitsOnly, // Only allow digits
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
                  FilteringTextInputFormatter.digitsOnly, // Only allow digits
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
                  FilteringTextInputFormatter.digitsOnly, // Only allow digits
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
                items:
                    _categories.map<DropdownMenuItem<String>>((String value) {
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
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          availableSizes.length =
                              int.parse(_numberOfSizesController.text);
                          _addProduct(availableSizes);
                        }
                      },
                      child: const Text(
                        'Add product',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                          