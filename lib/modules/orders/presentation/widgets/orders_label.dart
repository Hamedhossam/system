import 'package:flutter/material.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/core/widgets/text_field.dart';

class OrdersLabel extends StatelessWidget {
  const OrdersLabel({
    super.key,
    required this.tittle,
  });
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        SizedBox(width: 150, child: Label(tittle: tittle)),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: SizedBox(
            width: 200,
            child: CustomizedTextField(tittle: "Search with id", maxLines: 1),
          ),
        )
      ]),
    );
  }
}
