import 'package:udayah/responsive.dart';
import 'package:udayah/styles/fonts.dart';
import 'package:udayah/styles/styles.dart';
import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  final List<Widget> children;
  final Widget? suffix;
  final String title;
  final CrossAxisAlignment? crossAxisAlignment;

  const CategoryBox({
    super.key,
    this.suffix,
    required this.children,
    required this.title,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Styles.defaultBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          // Responsive.isMobile(context) || Responsive.isTablet(context)
          //     ? Flexible(
          //         child: Container(
          //           // padding: EdgeInsets.all(16),
          //           color: Colors.redAccent,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(Icons.warning, color: Colors.white),
          //               SizedBox(width: 8),
          //               Text(
          //                 "Please use a desktop for a better experience of \n Udayah. It will not work for tablet as of now.",
          //                 style: AppTextStyles.regular,
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     : Container(),
          Padding(
            padding: EdgeInsets.all(Styles.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Responsive.isMobile(context)
                      ? AppTextStyles.heading1BlackMobile
                      : AppTextStyles.heading1Black,
                ),
                suffix ?? Container(),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor:
                //         Styles.brandBackgroundColor, // Set the background color
                //   ),
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return VideoPopup(
                //             videoId:
                //                 'kXHiIxx2atA'); // Replace with your YouTube video ID
                //       },
                //     );
                //   },
                //   child: Text(
                //     'Discover How It Works',
                //     style: AppTextStyles.regular,
                //   ),
                // ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
