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
  String? _selectedCategory;
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

  void _addProduct() {
    log("message");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomizedTextField(
              tittle: 'Product Name',
              maxLines: 1,
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            CustomizedTextField(
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
              items: _categories.map<DropdownMenuItem<String>>((String value) {
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
                      (int.parse(_numberOfSizesController.text) > 0)
                          ? showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 400,
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: int.parse(
                                                _numberOfSizesController.text),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly, // Only allow digits
                                                  ],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        "size ${index + 1}",
                                                    labelStyle: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    border: const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.blue)),
                                          onPressed: _addProduct,
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : _addProduct();
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
    );
  }
}
