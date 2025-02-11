import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/storage/presentation/logic/adding_brand_cubit/add_brand_cubit.dart';
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
  // final TextEditingController _numberOfSizesController =
  //     TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final List<String> _categories = [
    'Shoes(Men)',
    'Shoes(Women)',
    'Bags',
    'Accessories'
  ];
  List<String?> availableSizes = [];
  String? _selectedCategory = "Shoes(Men)";
  int selectedBrand = 0;
  String? _selectedBrand = "Addidas";
  String? _imagePath;
  List<String> brands = [];
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

  String removeLastTwoWords(String input) {
    // Split the string into words
    List<String> words = input.split(' ');

    // Check if there are at least two words
    if (words.length <= 2) {
      return ''; // Return an empty string if there are not enough words
    }

    // Remove the last two words and join the remaining words back into a string
    return words.sublist(0, words.length - 2).join(' ');
  }

  String getFirstWord(String input) {
    // Split the string by spaces
    List<String> words = input.split(' ');

    // Check if the list has at least one word
    if (words.isNotEmpty) {
      return words[0]; // Return the first word
    } else {
      return "Shoes(Men)"; // Return an empty string if no words are found
    }
  }

  String wordBeforeLast(String input) {
    // Split the string into words
    List<String> words = input.split(' ');

    // Check if there are at least two words
    if (words.length < 2) {
      return ''; // Return an empty string if there are not enough words
    }

    // Return the word before the last
    return words[words.length - 2];
  }

  String getSecondWord(String input) {
    // Split the string by spaces
    List<String> words = input.split(' ');

    // Check if the list has at least one word
    if (words.isNotEmpty) {
      return words[1]; // Return the first word
    } else {
      return ''; // Return an empty string if no words are found
    }
  }

  void _addProduct(List<String?> availableSizes, ProductModel product) {
    BlocProvider.of<AddingProductCubit>(context).addProduct(product);
    BlocProvider.of<StorageProductsCubit>(context).getAllProducts();
    // log("the list of sizes is ${availableSizes.length}");
  }

  @override
  void initState() {
    super.initState();
    var random = Random();
    int autoId = 100000 + random.nextInt(900000);
    _idController.text = autoId.toString();
    BlocProvider.of<AddBrandCubit>(context).getBrands();
    brands = BlocProvider.of<AddBrandCubit>(context).menBrands;
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
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
              .showSnackBar(customizedSnackBar("product Added ✅ "));
        }
        if (state is AddingProductFailure) {
          await Future.delayed(const Duration(seconds: 1));

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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                    SizedBox(height: 16.h.h),
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
                    SizedBox(height: 16.h),
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
                      tittle: 'number of pieces and sizes',
                      controller: _numberOfPiecesController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Only allow digits
                      ],
                    ),
                    SizedBox(height: 16.h),
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
                    SizedBox(height: 16.h),
                    //** category and brands **//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          underline: Container(
                            height: 2.h,
                            color:
                                Colors.blueAccent, // Customize underline color
                          ),
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.blueAccent), // Customize icon color
                          dropdownColor:
                              Colors.white, // Dropdown background color
                          value: _selectedCategory,
                          hint: const Text('Select Category'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                              if (_selectedCategory == ("Shoes(Men)")) {
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .menBrands;
                              } else if (_selectedCategory ==
                                  ("Shoes(Women)")) {
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .womenBrands;
                              } else if (_selectedCategory == ("Bags")) {
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .bagsBrands;
                              } else {
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .accessoriesBrands;
                              }
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
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 205, 202, 202),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          height: 100.h,
                          width: 650.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: brands.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  selectedBrand = index;
                                  _selectedBrand =
                                      removeLastTwoWords(brands[index]);
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: selectedBrand == index
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          backgroundImage: FileImage(File(
                                              wordBeforeLast(brands[index]))),
                                        ),
                                        Text(
                                          getFirstWord(brands[index]),
                                          style: TextStyle(
                                              color: selectedBrand == index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    //** image **//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Upload Image'),
                        ),
                        if (_imagePath != null) ...[
                          SizedBox(height: 16.h),
                          Image.file(File(_imagePath!),
                              height: 100.h), // Display selected image
                        ],
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
                                    availableSizes.length = int.parse(
                                        _numberOfPiecesController.text);
                                    _addProduct(
                                      availableSizes,
                                      ProductModel(
                                        availableSizes: List.filled(
                                            growable: true,
                                            int.parse(
                                                _numberOfPiecesController.text),
                                            "0"),
                                        numAvailableSizes: int.parse(
                                            _numberOfPiecesController.text),
                                        name: _nameController.text,
                                        category:
                                            _selectedCategory ?? "Shoes(Men)",
                                        id: _idController.text,
                                        imagePath: _imagePath ??
                                            "D:/Programing/flutter/motors/assets/icons/00.png",
                                        price: _priceController.text,
                                        availablePieces: int.parse(
                                            _numberOfPiecesController.text),
                                        brand: _selectedBrand ?? "Addidas",
                                        priceAfterDiscount:
                                            _priceController.text,
                                        discountPercentage: '0',
                                        discountAmount: '0',
                                        isPercentage: false,
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
                      ],
                    ),
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
      style: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    backgroundColor: Colors.black87, // Optional: custom background color
    duration: const Duration(seconds: 2), // Duration for the SnackBar
  );
}
