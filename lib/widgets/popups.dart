import 'package:flutter/material.dart';
import 'package:shippi/styles/fonts.dart';
import 'package:shippi/styles/styles.dart';
import 'dart:html' as html;

void ShowSmtpSetupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Styles.brandBackgroundColor,

        // title: Text('SMTP Setup Instructions'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Steps to SMTP Setup',
                style: AppTextStyles.heading1,
              ),
              SizedBox(height: 10),
              Text(
                'Step 1 : Generate the Password from your Gmail account\n'
                'Before generating, make sure you see 2-step verification set to ON?\n'
                'If yes, Generate password here: ',
                style: AppTextStyles.regular,
              ),
              InkWell(
                  child: Text(
                    'https://myaccount.google.com/apppasswords',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    html.window.open(
                        'https://myaccount.google.com/apppasswords', 'new tab');
                  }),
              SizedBox(height: 10),
              Text(
                'Copy the password',
                style: AppTextStyles.regular,
              ),
              SizedBox(height: 10),
              Text(
                'Step 2 : Go back to the SMTP setup page on Udayah.in\n'
                'Add username as your Gmail address\n'
                'Add the password you copied from the App Password\n'
                'Save',
                style: AppTextStyles.regular,
              ),
              SizedBox(height: 10),
              Text(
                'Step 3: Choose any of the email addresses from the companies list\n'
                'Add a Subject, Attach the resume and body\n'
                'Before sending, click on the Test Button (It will send a test email using your configured SMTP details)\n'
                'Once everything looks good, send it to HR\n'
                'Hurrayyyy! You did it!',
                style: AppTextStyles.regular,
              ),
              SizedBox(height: 10),
              Text(
                'Please give us feedback at: udayah.in.reach@gmail.com',
                style: AppTextStyles.regular,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

void showPopLandingPage(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Styles.brandBackgroundColor,
        title: Text(
          title,
          style: AppTextStyles.heading1,
        ),
        content: SingleChildScrollView(
          child: title == 'About Us'
              ? Text.rich(
                  TextSpan(
                    text:
                        'At Udayah, we are redefining the job search experience for modern professionals and students alike. Our mission is to empower both job hunters and students with cutting-edge tools that simplify the search process and increase their chances of success.\n\n',
                    style: AppTextStyles.regular,
                    children: [
                      TextSpan(
                          text: 'Who We Are:\n', style: AppTextStyles.regular),
                      TextSpan(
                        text:
                            'Udayah is an early-stage startup, currently run by a dedicated solopreneur with a deep understanding of the challenges faced by job seekers and students entering the workforce. We\'re committed to providing innovative solutions that cater to the needs of both groups in today\'s competitive landscape.\n\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(
                          text: 'Our Vision:\n', style: AppTextStyles.regular),
                      TextSpan(
                        text:
                            'We envision a world where finding the right job or internship is a streamlined, stress-free experience. By leveraging advanced technologies, we aim to bridge the gap between job seekers, students, and employers, making the search process more efficient and effective.\n\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(
                          text: 'Our Tools:\n', style: AppTextStyles.regular),
                      TextSpan(
                        text:
                            '• One-Click Cold Mailing: Easily connect with potential employers or internship providers by sending cold emails directly from our website with just one click.\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(
                        text:
                            '• AI-Powered Resume Builder: Coming soon, our AI-driven resume builder will help you craft a standout resume tailored to your desired job or internship.\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(
                        text:
                            '• AI ATS Scoring: Soon to be released, our AI-powered ATS score checker will ensure your resume passes through automated screening systems with ease.\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(
                        text:
                            '• AI Cold-Mail Templates: Also on the way, our AI-generated templates will help you craft the perfect cold email to catch the attention of recruiters or internship coordinators.\n\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(
                          text: 'Security Commitment:\n',
                          style: AppTextStyles.regular),
                      TextSpan(
                        text:
                            'We take your privacy and security seriously. When you set up your SMTP details on our site, rest assured that your information is securely stored with 256-bit encryption. We guarantee that your data will never be shared with any third parties.\n\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(
                          text: 'Join Our Community:\n',
                          style: AppTextStyles.regular),
                      TextSpan(
                        text:
                            'Whether you\'re a job seeker or a student preparing to enter the workforce, Udayah is here to support you. Leverage our innovative tools to navigate the job market with confidence and efficiency. Let Udayah help you turn your career and academic aspirations into reality.\n\n',
                        style: AppTextStyles.regular,
                      ),
                      TextSpan(text: 'Udayah', style: AppTextStyles.regular),
                      TextSpan(
                        text:
                            ' – Where your career and internship journey begins.',
                        style: AppTextStyles.regular,
                      ),
                    ],
                  ),
                )
              : title == 'Terms & Conditions'
                  ? Text.rich(
                      TextSpan(
                        style: AppTextStyles.regular,
                        text:
                            'Welcome to Udayah. These Terms and Conditions outline the rules and regulations for the use of our services.\n\n',
                        children: [
                          TextSpan(
                              text: 'Acceptance of Terms\n',
                              style: AppTextStyles.regular),
                          TextSpan(
                            text:
                                'By accessing or using our services, you agree to comply with these Terms and Conditions. If you do not agree with any part of these terms, you should not use our services.\n\n',
                            style: AppTextStyles.regular,
                          ),
                          TextSpan(
                              text: 'Changes to Terms\n',
                              style: AppTextStyles.regular),
                          TextSpan(
                            text:
                                'We reserve the right to modify these terms at any time. It is your responsibility to review these terms periodically. Your continued use of the services constitutes your acceptance of any changes.\n\n',
                            style: AppTextStyles.regular,
                          ),
                          TextSpan(
                              text: 'User Responsibilities\n',
                              style: AppTextStyles.regular),
                          TextSpan(
                            text:
                                'You agree to use our services only for lawful purposes and in a manner that does not infringe on the rights of others. Any harmful, abusive, or illegal use of our services, as defined under Indian law, is strictly prohibited. You are responsible for maintaining the confidentiality of your account information and for all activities under your account.\n\n',
                            style: AppTextStyles.regular,
                          ),
                          TextSpan(
                              text: 'Limitation of Liability\n',
                              style: AppTextStyles.regular),
                          TextSpan(
                            text:
                                'Udayah is not liable for any damages or losses arising from the use of our services. Our services are provided on an "as is" basis without warranties of any kind. You acknowledge that any reliance on the services is at your own risk.\n\n',
                            style: AppTextStyles.regular,
                          ),
                          TextSpan(
                              text: 'Free Service Disclaimer\n',
                              style: AppTextStyles.regular),
                          TextSpan(
                            text:
                                'As of now, Udayah is free to use. However, we reserve the right to introduce paid services in the future, with or without prior notice. Your continued use of the services after the introduction of any paid services will constitute your acceptance of such changes.\n\n',
                            style: AppTextStyles.regular,
                          ),
                          TextSpan(
                              text: 'Data Security\n',
                              style: AppTextStyles.regular),
                          TextSpan(
                            text:
                                'We are committed to ensuring that your data is secure with us. All sensitive information, including SMTP details, is securely stored with 256-bit encryption. We will never share your data with third parties without your explicit consent.\n\n',
                            style: AppTextStyles.regular,
                          ),
                          TextSpan(
                              text: 'Governing Law\n',
                              style: AppTextStyles.regular),
                          TextSpan(
                            text:
                                'These Terms and Conditions are governed by and construed in accordance with the laws of India. Any disputes arising from these terms will be resolved in the courts of India.\n\n',
                            style: AppTextStyles.regular,
                          ),
                        ],
                      ),
                    )
                  : title == 'Refund Policy'
                      ? Text.rich(
                          TextSpan(
                            style: AppTextStyles.regular,
                            text:
                                'At Udayah, we strive to provide high-quality services. However, if you have any concerns about our services, please review our refund policy.\n\n',
                            children: [
                              TextSpan(
                                  text: 'Eligibility for Refund\n',
                                  style: AppTextStyles.regular),
                              TextSpan(
                                text:
                                    'If Udayah transitions to paid services in the future, please note that all purchases will be valid for one year from the date of purchase. Refunds will not be available once the purchase is made.\n\n',
                                style: AppTextStyles.regular,
                              ),
                              TextSpan(
                                  text: 'Non-Refundable Services\n',
                                  style: AppTextStyles.regular),
                              TextSpan(
                                text:
                                    'All services provided by Udayah, including but not limited to AI-powered tools, resume builders, and email templates, are non-refundable. Please consider your purchase carefully, as we do not offer refunds under any circumstances.\n\n',
                                style: AppTextStyles.regular,
                              ),
                              TextSpan(
                                  text: 'Contact Us\n',
                                  style: AppTextStyles.regular),
                              TextSpan(
                                text:
                                    'For any questions or concerns regarding our refund policy, please reach out to our support team. We are here to assist you with any inquiries.\n\n',
                                style: AppTextStyles.regular,
                              ),
                            ],
                          ),
                        )
                      : title == 'Privacy Policy'
                          ? Text.rich(
                              TextSpan(
                                style: AppTextStyles.regular,
                                text:
                                    'Your privacy is important to us. This Privacy Policy explains how Udayah collects, uses, and protects your personal information.\n\n',
                                children: [
                                  TextSpan(
                                    text: 'Information We Collect\n',
                                    style: AppTextStyles.regular
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We collect personal information that you provide to us directly, such as your name, email address, and SMTP details. We may also collect information about your use of our services, including your interactions with our platform.\n\n',
                                    style: AppTextStyles.regular,
                                  ),
                                  TextSpan(
                                    text: 'How We Use Your Information\n',
                                    style: AppTextStyles.regular
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We use your information to provide and enhance our services, process transactions, and communicate with you. Rest assured, we do not sell or rent your personal information to third parties under any circumstances.\n\n',
                                    style: AppTextStyles.regular,
                                  ),
                                  TextSpan(
                                    text: 'Data Security\n',
                                    style: AppTextStyles.regular
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We implement industry-standard measures to protect your personal information from unauthorized access, disclosure, or destruction. Your data, including SMTP details, is securely stored with 256-bit encryption, ensuring your privacy is safeguarded.\n\n',
                                    style: AppTextStyles.regular,
                                  ),
                                  TextSpan(
                                    text: 'Changes to Privacy Policy\n',
                                    style: AppTextStyles.regular
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any significant changes by posting the updated policy on our website.\n\n',
                                    style: AppTextStyles.regular,
                                  ),
                                  TextSpan(
                                    text: 'Contact Us\n',
                                    style: AppTextStyles.regular
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'If you have any questions or concerns about our Privacy Policy, please contact us. We are committed to addressing any issues you may have regarding your privacy.\n\n',
                                    style: AppTextStyles.regular,
                                  ),
                                ],
                              ),
                            )
                          : title == 'Not Refundable'
                              ? Text(
                                  'Please note that all services provided by Udayah are non-refundable. This includes but is not limited to custom-made or personalized services, as well as any services rendered after the initial purchase. Once a purchase is made, no refunds will be issued under any circumstances.',
                                  style: AppTextStyles.regular,
                                )
                              : title == 'Contact Us'
                                  ? RichText(
                                      text: TextSpan(
                                        text:
                                            'We are here to help you. If you have any questions, concerns, or feedback, please feel free to contact us:\n\n',
                                        style: AppTextStyles.regular,
                                        children: [
                                          TextSpan(
                                            text: '- **Email:** ',
                                            style: AppTextStyles.regular,
                                          ),
                                          TextSpan(
                                            text:
                                                'udayah.in.reach@gmail.com\n',
                                            style: AppTextStyles.regular,
                                          ),
                                          // TextSpan(
                                          //   text: '- **Phone:** ',
                                          //   style: AppTextStyles.regular,
                                          // ),
                                          // TextSpan(
                                          //   text: '+1 (555) 123-4567\n',
                                          //   style: AppTextStyles.regular,
                                          // ),
                                          // TextSpan(
                                          //   text: '- **Address:** ',
                                          //   style: AppTextStyles.regular,
                                          // ),
                                          // TextSpan(
                                          //   text:
                                          //       '123 Startup Street, Bengaluru, Karnataka, India\n\n',
                                          //   style: AppTextStyles.regular,
                                          // ),
                                          // TextSpan(
                                          //   text:
                                          //       'Our support team is available Monday to Friday, 9 AM to 6 PM IST, to assist you with any inquiries.',
                                          //   style: AppTextStyles.regular,
                                          // ),
                                        ],
                                      ),
                                    )
                                  : Text(
                                      'This is the $title content. Here you can add detailed information about $title.',
                                      style: AppTextStyles.regular,
                                    ),
        ),
        actions: [
          TextButton(
            child: Text('Close', style: AppTextStyles.regular),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void ShowLogoutDialog(BuildContext context, VoidCallback onPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Styles.brandBackgroundColor,
        title: Text('Logout', style: AppTextStyles.regular),
        content: Text('Are you sure you want to log out?', style: AppTextStyles.regular),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel', style: AppTextStyles.regular),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Logout', style: AppTextStyles.regular),
            onPressed: onPressed
          ),
        ],
      );
    },
  );
}
