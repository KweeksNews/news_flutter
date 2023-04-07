// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/l10n.dart';

class NavBar extends StatelessWidget {
  final Widget child;

  const NavBar({
    super.key,
    required this.child,
  });

  int _getSelectedIndex(
    BuildContext context,
  ) {
    final String location = GoRouter.of(context).location;
    if (location.startsWith('/search')) {
      return 1;
    } else if (location.startsWith('/saved-posts')) {
      return 2;
    } else if (location.startsWith('/settings')) {
      return 3;
    } else {
      return 0;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: AppLocalizations.of(context).navBarHomeLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: const Icon(Icons.search_rounded),
            label: AppLocalizations.of(context).navBarSearchLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bookmarks_outlined),
            selectedIcon: const Icon(Icons.bookmarks_rounded),
            label: AppLocalizations.of(context).navBarSavedPostsLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.menu_outlined),
            selectedIcon: const Icon(Icons.menu_rounded),
            label: AppLocalizations.of(context).navBarSettingsLabel,
          ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _getSelectedIndex(context),
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/search');
              break;
            case 2:
              context.go('/saved-posts');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
      ),
    );
  }
}
