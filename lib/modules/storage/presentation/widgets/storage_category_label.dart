import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/storage/presentation/logic/adding_brand_cubit/add_brand_cubit.dart';
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
                  return EditBrandsBottomSheet(category: tittle);
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
    required this.category,
    super.key,
  });
  final String category;
  @override
  State<EditBrandsBottomSheet> createState() => _EditBrandsBottomSheetState();
}

class _EditBrandsBottomSheetState extends State<EditBrandsBottomSheet> {
  late List<String> brands;
  GlobalKey<FormState> formKey = GlobalKey();
  String? imagePath;
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        imagePath =
            result.files.single.path!; // Get the path of the selected image
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddBrandCubit>(context).getBrands();
    switch (widget.category) {
      case "Shoes(Men)":
        brands = BlocProvider.of<AddBrandCubit>(context).menBrands;
        break;
      case "Shoes(Women)":
        brands = BlocProvider.of<AddBrandCubit>(context).womenBrands;
        break;
      case "Bags":
        brands = BlocProvider.of<AddBrandCubit>(context).bagsBrands;
        break;
      case "Accessories":
        brands = BlocProvider.of<AddBrandCubit>(context).accessoriesBrands;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Label(tittle: "${widget.category} Brands")],
          ),
          const HorizentalLine(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                childAspectRatio: 1.2, // Adjust to change item height/width
              ),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 30.h,
                      backgroundColor: Colors.white,
                      child: Image.file(File(wordBeforeLast(brands[index]))),
                    ),
                    Text(
                      removeLastTwoWords(brands[index]),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 30.h,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            final TextEditingController brandNameController =
                                TextEditingController();
                            brandNameController.text =
                                removeLastTwoWords(brands[index]);
                            imagePath = wordBeforeLast(brands[index]);
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 400.h,
                                  width: 400.w,
                                  child: BlocConsumer<AddBrandCubit,
                                      AddBrandState>(
                                    listener: (context, state) async {
                                      if (state is AddBrandSuccess) {
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(customizedSnackBar(
                                                "Brand Edited ✅ "));
                                      }
                                      if (state is AddBrandFail) {
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                customizedSnackBar("Error ❌"));
                                      }
                                    },
                                    builder: (context, state) {
                                      // Future<void> pickImage() async {
                                      //   FilePickerResult? result =
                                      //       await FilePicker.platform.pickFiles(
                                      //     type: FileType.image,
                                      //   );

                                      //   if (result != null) {
                                      //     setState(() {
                                      //       imagePath = result.files.single
                                      //           .path!; // Get the path of the selected image
                                      //     });
                                      //   }
                                      // }

                                      return Form(
                                        key: formKey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Edit Brand",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 16.h),
                                                Text(
                                                  "of : > ${widget.category} <",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 8.h),
                                                CustomizedTextField(
                                                  controller:
                                                      brandNameController,
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
                                                  onPressed: pickImage,
                                                  child: const Text(
                                                      'Upload Image'),
                                                ),
                                                if (imagePath != null) ...[
                                                  const SizedBox(height: 16),
                                                  Image.file(File(imagePath!),
                                                      height: 100
                                                          .h), // Display selected image
                                                ],
                                                SizedBox(height: 8.h),
                                                CustomizedButton(
                                                  tittle: "Submit",
                                                  myColor: Colors.blue,
                                                  onTap: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      editTheBrand(
                                                        context,
                                                        index,
                                                        brandNameController:
                                                            brandNameController,
                                                        imagePath: imagePath,
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
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            size: 30.h,
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await BlocProvider.of<AddBrandCubit>(context)
                                .deleteBrand(brandName: brands[index]);
                            // ignore: use_build_context_synchronously
                            BlocProvider.of<AddBrandCubit>(context).getBrands();
                            switch (widget.category) {
                              case "Shoes(Men)":
                                // ignore: use_build_context_synchronously
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .menBrands;
                                break;
                              case "Shoes(Women)":
                                // ignore: use_build_context_synchronously
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .womenBrands;
                                break;
                              case "Bags":
                                // ignore: use_build_context_synchronously
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .bagsBrands;
                                break;
                              case "Accessories":
                                // ignore: use_build_context_synchronously
                                brands = BlocProvider.of<AddBrandCubit>(context)
                                    .accessoriesBrands;
                                break;
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void editTheBrand(BuildContext context, int index,
      {required TextEditingController brandNameController, String? imagePath}) {
    BlocProvider.of<AddBrandCubit>(context).editBrand(
      brandName: removeLastTwoWords(brands[index]),
      newBrandName: brandNameController.text,
      newImagePath: imagePath ?? wordBeforeLast(brands[index]),
      category: widget.category,
    );
    BlocProvider.of<AddBrandCubit>(context).getBrands();
    switch (widget.category) {
      case "Shoes(Men)":
        brands = BlocProvider.of<AddBrandCubit>(context).menBrands;
        break;
      case "Shoes(Women)":
        brands = BlocProvider.of<AddBrandCubit>(context).womenBrands;
        break;
      case "Bags":
        brands = BlocProvider.of<AddBrandCubit>(context).bagsBrands;
        break;
      case "Accessories":
        brands = BlocProvider.of<AddBrandCubit>(context).accessoriesBrands;
        break;
    }
    setState(() {});
  }
}
