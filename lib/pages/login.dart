import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shippi/provider/auth.dart';
import 'package:shippi/styles/fonts.dart';
import 'package:shippi/styles/styles.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: Styles.brandingDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title Text with modern font and spacing
            SizedBox(height: 20),
            // Subtitle Text with subtle color
            Text(
              'Welcome to Udayah',
              style: AppTextStyles.heading1,
              textAlign: TextAlign.center,
            ),
            Text(
              'We’re excited to help you take the next step in your career. Happy job hunting!',
              style: AppTextStyles.regular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Google Sign-In Button with modern design
            GestureDetector(
              onTap: () {
                authProvider.signInWithGoogle(context);
                // Handle Google Sign-In
                // GoRouter.of(context).go('/dashboard');
              },
              child: Container(
                width: 280,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/google-icon.png",
                      height: 24,
                      width: 23,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
              Text(
              'By continuing, you agree to our Terms and Conditions and Privacy Policy.',
              style: AppTextStyles.lightItalic,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
