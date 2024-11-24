import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.image,
    required this.onTap,
    required this.tittle,
  });
  final String image;
  final String tittle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      hoverColor: Colors.white,
      onPressed: onTap,
      icon: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(image),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "$tittle 👆🏻",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
