import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:udayah/responsive.dart';
import 'package:udayah/styles/fonts.dart';
import 'package:udayah/styles/styles.dart';
import 'package:udayah/widgets/popups.dart';
import 'package:udayah/widgets/video.dart';
import 'dart:html' as html;

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background and main content
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            decoration: Styles.brandingDecoration,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height:
                            isMobile ? 120 : 40), // Space for the sticky bar

                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildWelcomeText(context, isMobile),
                              _buildPriceCard(context, isMobile),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 2,
                                child: _buildWelcomeText(context, isMobile),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: _buildPriceCard(context, isMobile),
                              ),
                              SizedBox(width: 60),
                            ],
                          ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: isMobile ? 10 : 30.0,
                      runSpacing: isMobile ? 10 : 0,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildMenuButton(context, 'Terms & Conditions'),
                        // _buildMenuButton(context, 'Refund Policy'),
                        _buildMenuButton(context, 'About Us'),
                        _buildMenuButton(context, 'Privacy Policy'),
                        _buildMenuButton(context, 'Contact Us'),
                      ],
                    ),
                    SizedBox(height: 20),

                    Text(
                      'Made with love in Bangalore ❤️',
                      style: AppTextStyles.extraBold,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 60), // Space at the bottom
                  ],
                ),
              ),
            ),
          ),

          // Sticky Announcement Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Color(0xFF8A4FFF),
                  child: Center(
                    child: Text(
                        '🚀 This will be the early release of Udayah. Sign up now to get exclusive access!',
                        style: AppTextStyles.regular),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(BuildContext context, bool isMobile) {
    return Container(
      width: isMobile ? 250 : 150,
      // height: 100,
      // alignment: Alignment.center,
      padding: EdgeInsets.all(isMobile ? 15 : 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF292948), Color(0xFF3C3C74)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Features', style: AppTextStyles.heading3),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text:
                  'Our platform offers a range of powerful features designed to streamline your job search and enhance your career prospects:\n\n',
              style: AppTextStyles.regular,
              children: [
                TextSpan(
                  text: '• ',
                  style: AppTextStyles.regular
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      '4000+ Verified HR email addresses (and still growing)\n',
                  style: AppTextStyles.regular
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '• ',
                  style: AppTextStyles.regular
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Contribute HR emails and support others in their job search\n',
                  style: AppTextStyles.regular,
                ),
                TextSpan(
                  text: '• ',
                  style: AppTextStyles.regular
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Send emails directly to HR using your Gmail SMTP\n',
                  style: AppTextStyles.regular,
                ),
                TextSpan(
                  text: '• ',
                  style: AppTextStyles.regular
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'AI ATS Scanner (releasing soon)\n',
                  style: AppTextStyles.regular,
                ),
                TextSpan(
                  text: '• ',
                  style: AppTextStyles.regular
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'AI Resume Maker (releasing soon)\n',
                  style: AppTextStyles.regular,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/login');

                // Handle "Get Started" button press
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 18 : 20,
                    horizontal: isMobile ? 40 : 60),
                backgroundColor: Styles.brandBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Styles.brandBackgroundColor,
                elevation: 10,
              ),
              child: Text(
                'Get Started',
                style: AppTextStyles.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Unlock Your Career Potential with Our Cutting-Edge Tools.',
          style: AppTextStyles.heading1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 25),
        Text(
          'Are you ready to take your job search to the next level? Our platform is designed to empower job hunters like you with the most advanced tools and resources available. Whether you’re looking for your next career move or aiming to stand out in a competitive job market, we’ve got you covered.',
          style: AppTextStyles.heading4,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Styles.brandBackgroundColor, // Set the background color
          ),
          onPressed: () {
            html.window
                .open('https://github.com/muzammildafedar/udayah', 'new tab');
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return VideoPopup(videoId: 'kXHiIxx2atA');  // Replace with your YouTube video ID
            //   },
            // );
          },
          child: Text(
            'Become a Contributor',
            style: AppTextStyles.regular,
          ),
        ),
        // Menu with pop-ups
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Styles.brandBackgroundColor)),
      child: GestureDetector(
        onTap: () {
          // _showSmtpSetupDialog()
          showPopLandingPage(context, title);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(title, style: AppTextStyles.regular),
        ),
      ),
    );
  }
}
