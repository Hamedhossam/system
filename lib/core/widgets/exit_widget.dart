import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExitWidget extends StatelessWidget {
  const ExitWidget({
    super.key,
  });
  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit"),
          content: Text("Do you want to exit?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                SystemNavigator.pop(); // Close the app
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Implement exit functionality here, if needed
                // For example, you can call SystemNavigator.pop();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 380.0.h),
      child: IconButton(
        icon: const Icon(
          Icons.logout_rounded,
          size: 40,
        ),
        onPressed: () => _showExitDialog(context),
      ),
    );
  }
}
