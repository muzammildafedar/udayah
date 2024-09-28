import 'package:shippi/responsive.dart';
import 'package:shippi/styles/fonts.dart';
import 'package:shippi/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:shippi/widgets/video.dart';

class CategoryBox extends StatelessWidget {
  final List<Widget> children;
  final Widget? suffix;
  final String title;

  const CategoryBox({
    Key? key,
    this.suffix,
    required this.children,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Styles.defaultBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(Styles.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Check if it's mobile or desktop and apply appropriate style
                Text(
                  title,
                  style: Responsive.isMobile(context)
                      ? AppTextStyles.heading1BlackMobile
                      : AppTextStyles.heading1Black,
                ),
                suffix ?? Container(),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
