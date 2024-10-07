import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udayah/layout/app_layout.dart';
import 'package:udayah/provider/navigation.dart';
import 'package:udayah/widgets/companies_list.dart';
import 'package:udayah/widgets/profile_page.dart';
import 'package:udayah/widgets/smtp_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> screens = [
    CompaniesList(),
    const SmtpSetup(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ActiveTabIndexProvider>(
          builder: (context, _, data) {
            return AppLayout(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Main Panel
                  Expanded(
                    flex: 5,
                    child: _.fetchCurrentTabIndex >= 3
                        ? Container()
                        : screens[_.fetchCurrentTabIndex],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
