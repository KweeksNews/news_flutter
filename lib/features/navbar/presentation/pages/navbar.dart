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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers.dart';
import '../../../contents/presentation/pages/contents.dart';
import '../../../saved_posts/presentation/pages/saved_posts.dart';
import '../../../search/presentation/pages/search.dart';
import '../../../settings/presentation/pages/settings.dart';

class NavBar extends StatelessWidget {
  final List<Widget> _pages = [
    const Content(),
    const Search(),
    const SavedPosts(),
    const Settings(),
  ];

  NavBar();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final int index = watch(navBarProvider);

        return Scaffold(
          body: Center(
            child: _pages.elementAt(index),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).cardTheme.shadowColor!,
                  blurRadius: 5,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                selectedItemColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                unselectedItemColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded),
                    label: 'Cari',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmarks_rounded),
                    label: 'Kiriman Tersimpan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_rounded),
                    label: 'Pengaturan',
                  ),
                ],
                currentIndex: index,
                onTap: context.read(navBarProvider.notifier).setPage,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        );
      },
    );
  }
}
