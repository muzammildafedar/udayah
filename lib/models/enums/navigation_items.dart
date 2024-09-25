import 'package:flutter/material.dart';

enum NavigationItems {
  home,
  settings,
  logout
}

extension NavigationItemsExtensions on NavigationItems {
  IconData get icon {
    switch (this) {
      case NavigationItems.home:
        return Icons.home;
      case NavigationItems.settings:
        return Icons.settings;
      case NavigationItems.logout:
        return Icons.logout;
      default:
        return Icons.person;
    }
  }
}
