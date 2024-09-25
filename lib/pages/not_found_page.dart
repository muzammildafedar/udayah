import 'package:flutter/material.dart';
import 'package:shippi/styles/styles.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Styles.brandBackgroundColor,
      body: Center(
        child: Text('Page not found'),
      ),
    );
  }
}
