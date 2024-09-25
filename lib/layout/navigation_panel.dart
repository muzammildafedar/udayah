import 'package:provider/provider.dart';
import 'package:shippi/models/enums/navigation_items.dart';
import 'package:shippi/provider/auth.dart';
import 'package:shippi/provider/navigation.dart';
import 'package:shippi/responsive.dart';
import 'package:shippi/widgets/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:shippi/widgets/popups.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  const NavigationPanel({Key? key, required this.axis}) : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  @override
  Widget build(BuildContext context) {
    int activeTab = Provider.of<ActiveTabIndexProvider>(context, listen: true)
        .fetchCurrentTabIndex;
    final activeTabProvider =
        Provider.of<ActiveTabIndexProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);
   void logout() {
      authProvider.signOut(context);
      activeTabProvider.setActiveTabIndex(0);
    }

    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
          : const EdgeInsets.all(10),
      child: widget.axis == Axis.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: NavigationItems.values
                      .map(
                        (e) => NavigationButton(
                          onPressed: () {
                            activeTabProvider.setActiveTabIndex(e.index);
                            if (activeTabProvider.fetchCurrentTabIndex >= 2) {
                               activeTabProvider.setActiveTabIndex(e.index - 1);
                              ShowLogoutDialog(context, logout);
                            }
                          },
                          icon: e.icon,
                          isActive: e.index == activeTab ? true : false,
                        ),
                      )
                      .toList(),
                ),
                Container()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: NavigationItems.values
                      .map(
                        (e) => NavigationButton(
                          onPressed: () {
                            activeTabProvider.setActiveTabIndex(e.index);
                            if (activeTabProvider.fetchCurrentTabIndex >= 2) {
                               activeTabProvider.setActiveTabIndex(e.index - 1);
                              ShowLogoutDialog(context, logout);
                            }
                          },
                          icon: e.icon,
                          isActive: e.index == activeTab ? true : false,
                        ),
                      )
                      .toList(),
                ),
                Container()
              ],
            ),
    );
  }
}
