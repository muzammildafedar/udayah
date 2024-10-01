import 'package:flutter/material.dart';
import 'package:udayah/styles/fonts.dart';
import 'package:udayah/styles/styles.dart';

void ShowCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Styles.brandBackgroundColor,
          title: Text("Alert !", style: AppTextStyles.regular,),
          content: Text(message,style: AppTextStyles.regular,),
          actions: [
            TextButton(
              child: Text("OK", style: AppTextStyles.regular,),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }