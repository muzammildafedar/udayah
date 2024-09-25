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
                  style: AppTextStyles.heading1Black,
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
