import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:motors/core/widgets/text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final List<String> _categories = [
    'Shoes(Men)',
    'Shoes(Women)',
    'Bags',
    'Accessories'
  ];
  String? _selectedCategory;
  String? _imagePath;
  List<String> _availableSizes = [];

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
    // Logic to save product details
    // You can save it to a database or state management solution
    log('Product Name: ${_nameController.text}');
    log('Price: ${_priceController.text}');
    log('ID: ${_idController.text}');
    log('Category: $_selectedCategory');
    log('Image Path: $_imagePath');
    log('Available Sizes: $_availableSizes');
    // You can navigate back to the main screen or show a success message
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const CustomizedTextField(tittle: 'Product Name', maxLines: 1),
          const SizedBox(height: 16),

          CustomizedTextField(
            tittle: 'ID',
            maxLines: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Only allow digits
            ],
          ),
          const SizedBox(height: 16),

          CustomizedTextField(
            tittle: 'Price',
            maxLines: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Only allow digits
            ],
          ),
          const SizedBox(height: 16),

          // TextField(
          //   controller: _nameController,
          //   decoration: const InputDecoration(labelText: 'Product Name'),
          // ),
          // TextField(
          //   controller: _idController,
          //   decoration: const InputDecoration(labelText: 'Product ID'),
          // ),
          // TextField(
          //   controller: _priceController,
          //   decoration: const InputDecoration(labelText: 'Price'),
          //   keyboardType: TextInputType.number,
          // ),

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
          // // CircleAvatar for image preview
          // CircleAvatar(
          //   backgroundColor: const Color.fromARGB(255, 204, 203, 203),
          //   radius: 80, // Adjust the radius as needed
          //   backgroundImage:
          //       _imagePath != null ? FileImage(File(_imagePath!)) : null,
          // ),
          // const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Upload Image'),
          ),
          if (_imagePath != null) ...[
            const SizedBox(height: 16),
            Image.file(File(_imagePath!),
                height: 100), // Display selected image
          ],
          // Add a TextField for available sizes if needed
          // Example for sizes input
          TextField(
            decoration: const InputDecoration(
                labelText: 'Available Sizes (comma-separated)'),
            onChanged: (value) {
              _availableSizes =
                  value.split(',').map((size) => size.trim()).toList();
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: _addProduct,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
