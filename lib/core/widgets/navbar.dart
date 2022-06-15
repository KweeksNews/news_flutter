/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home.dart';
import '../../features/saved_posts/presentation/pages/saved_posts.dart';
import '../../features/search/presentation/pages/search.dart';
import '../../features/settings/presentation/pages/settings.dart';
import '../../injection.dart';
import '../l10n/generated/l10n.dart';

class NavBar extends StatefulWidget {
  final int index;
  final GoRouterState state;

  const NavBar({
    super.key,
    required this.index,
    required this.state,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late final PageController _pageController;
  late int _index;

  @override
  void initState() {
    super.initState();

    _index = widget.index;

    _pageController = PageController(
      initialPage: _index,
    );
  }

  @override
  void didUpdateWidget(
    covariant NavBar oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (widget.index != _index) {
      _index = widget.index;

      _pageController.jumpToPage(_index);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (_) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        children: <Widget>[
          const Home(),
          const Search(),
          SavedPosts(
            key: getIt<GlobalKey<SavedPostsPageState>>(
              instanceName: 'savedPostsPageKey',
            ),
          ),
          const Settings(),
        ],
      ),
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
        selectedIndex: _index,
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
