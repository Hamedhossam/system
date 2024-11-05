import 'package:flutter/material.dart';

class ExitWidget extends StatelessWidget {
  const ExitWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 360.0),
      child: IconButton(
        icon: const Icon(
          Icons.logout_rounded,
          size: 40,
        ),
        onPressed: () {},
      ),
    );
  }
}
