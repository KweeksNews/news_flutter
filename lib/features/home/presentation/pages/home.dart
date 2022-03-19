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

import '../../../../core/config/config.dart';
import '../../../../providers.dart';
import '../widgets/contents_tab.dart';

class Home extends ConsumerWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeState = ref.watch(themeProvider);

    return DefaultTabController(
      length: CONFIG.categories.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Image(
            image: AssetImage(
              themeState == ThemeMode.dark
                  ? 'assets/img/dark/icon.png'
                  : 'assets/img/light/icon.png',
            ),
            width: 170,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TabBar(
                isScrollable: true,
                tabs: List.generate(CONFIG.categories.length, (index) {
                  final List<String> cat = CONFIG.categories[index];
                  final String name = cat[0];

                  return Container(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(CONFIG.categories.length, (index) {
            final List<String> cat = CONFIG.categories[index];
            final String categoryId = cat[1];

            return ContentsTab(
              categoryId: categoryId,
            );
          }),
        ),
      ),
    );
  }
}
