import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.tittle,
    required this.image,
  });
  final String tittle;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(image),
          ),
        ),
        Text(
          tittle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
