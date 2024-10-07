import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udayah/firebase_options.dart';
import 'package:udayah/provider/auth.dart';
import 'package:udayah/provider/companies.dart';
import 'package:udayah/provider/hr_emails.dart';
import 'package:udayah/provider/mailer.dart';
import 'package:udayah/provider/navigation.dart';
import 'package:udayah/provider/smtp.dart';
import 'package:udayah/routes/router.dart';
import 'package:udayah/styles/fonts.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<activeTabIndexProvider>(
        //     create: (_) => activeTabIndexProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SmtpProvider()),
        ChangeNotifierProvider(create: (_) => ActiveTabIndexProvider()),
        ChangeNotifierProvider(create: (_) => CompaniesProvider()),
        ChangeNotifierProvider(create: (_) => EmailProvider()),
        ChangeNotifierProvider(create: (_) => HrEmailProvider()),

      ],
      child: MaterialApp.router(
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false,  
        title: "Udayah | AI-Powered Tools for Job Hunters", 

        theme: ThemeData(
          textTheme: TextTheme(
            // displayLarge: AppTextStyles.bold.copyWith(fontSize: 32),
            // bodyLarge: AppTextStyles.regular,
            // bodyMedium: AppTextStyles.light,
            // bodySmall: AppTextStyles.italic,
            // labelLarge: AppTextStyles.semiBold.copyWith(fontSize: 18),
            // Define other text styles as needed
          ),
        ),
      ),
    );
  }
}
