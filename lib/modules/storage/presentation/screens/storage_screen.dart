import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/screens/home_screen.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';
import 'package:motors/modules/storage/presentation/widgets/available_items_list_view.dart';
import 'package:motors/modules/storage/presentation/widgets/storage_category_label.dart';
import 'package:motors/modules/storage/presentation/widgets/storage_tittle_widget.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<StorageProductsCubit>(context).getAllProducts();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const StorageTittleWidget(),
            const HorizentalLine(),
            buildCategorySection(
                context, "Shoes(Men)", "assets/images/shoes_men.jpg"),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SizedBox(width: 600.w, child: const HorizentalLine()),
            ),
            buildCategorySection(
                context, "Shoes(Women)", "assets/images/shoes_women.jpg"),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(width: 600.w, child: const HorizentalLine()),
            ),
            buildCategorySection(context, "Bags", "assets/images/bags.jpg"),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SizedBox(width: 600.w, child: const HorizentalLine()),
            ),
            buildCategorySection(
                context, "Accessories", "assets/images/accessories2.jpg"),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget buildCategorySection(
      BuildContext context, String category, String imagePath) {
    return Column(
      children: [
        StorageCategoryLabel(tittle: category, image: imagePath),
        BlocConsumer<StorageProductsCubit, StorageProductsState>(
          listener: (BuildContext context, StorageProductsState state) {},
          builder: (context, state) {
            if (state is StorageProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StorageProductsSuccess) {
              return AvailableItemsListView(
                products: BlocProvider.of<StorageProductsCubit>(context)
                    .getProducts(category),
              );
            } else if (state is StorageProductsFailure) {
              return const Center(child: Text("There is something wrong ❌"));
            } else {
              return const Center(child: Text("No products found"));
            }
          },
        ),
      ],
    );
  }
}
