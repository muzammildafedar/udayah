import 'package:provider/provider.dart';
import 'package:udayah/models/enums/navigation_items.dart';
import 'package:udayah/provider/auth.dart';
import 'package:udayah/provider/navigation.dart';
import 'package:udayah/responsive.dart';
import 'package:udayah/widgets/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:udayah/widgets/popups.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  const NavigationPanel({Key? key, required this.axis}) : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  @override
  Widget build(BuildContext context) {
    int activeTab = Provider.of<ActiveTabIndexProvider>(context, listen: true).fetchCurrentTabIndex;
    final activeTabProvider = Provider.of<ActiveTabIndexProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);
    
    void logout() {
      authProvider.signOut(context);
      activeTabProvider.setActiveTabIndex(0);
    }

    Widget buildNavigationButton(NavigationItems item) {
      return NavigationButton(
        onPressed: () {
          activeTabProvider.setActiveTabIndex(item.index);
          if (activeTabProvider.fetchCurrentTabIndex == 3) {
            activeTabProvider.setActiveTabIndex(item.index - 1);
            ShowLogoutDialog(context, logout);
          }
        },
        icon: item.icon,  // Directly pass the IconData
        isActive: item.index == activeTab,
      );
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
              mainAxisAlignment: MainAxisAlignment.center,  // Center items vertically
              children: NavigationItems.values
                  .map((e) => buildNavigationButton(e))
                  .toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,  // Center items horizontally
              children: NavigationItems.values
                  .map((e) => buildNavigationButton(e))
                  .toList(),
            ),
    );
  }
}
