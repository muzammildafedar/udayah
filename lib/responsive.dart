import 'package:flutter/material.dart';
import 'package:udayah/styles/styles.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 650) {
         return Container(
            alignment: Alignment.center,
            height: double.infinity,
            decoration: Styles.brandingDecoration,
            child: desktop,
          );
        } else {
           return Container(
            alignment: Alignment.center,
            height: double.infinity,
            decoration: Styles.brandingDecoration,
            child: mobile,
          );
        }
      },
    );
  }
}
