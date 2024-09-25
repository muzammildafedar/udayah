import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shippi/layout/app_layout.dart';
import 'package:shippi/provider/auth.dart';
import 'package:shippi/provider/navigation.dart';
import 'package:shippi/responsive.dart';
import 'package:shippi/widgets/companies_list.dart';
import 'package:shippi/widgets/smtp_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> screens = [
    CompaniesList(),
    SmtpSetup(),
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
                    child: _.fetchCurrentTabIndex >= 2
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
