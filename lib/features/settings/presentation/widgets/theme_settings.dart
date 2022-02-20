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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../providers.dart';

class ThemeSettingsDialog extends ConsumerWidget {
  const ThemeSettingsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, watch, child) {
      final ThemeMode themeState = ref.watch(themeProvider);

      return SimpleDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        titlePadding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
        contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        title: Center(
          child: Text(
            'Tema',
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
        ),
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Material(
              color: themeState == ThemeMode.light
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).cardTheme.color,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.shadow,
                highlightColor: Theme.of(context).colorScheme.shadow,
                onTap: () {
                  ref.read(themeProvider.notifier).set(ThemeMode.light);
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 15),
                  leading: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FaIcon(
                      FontAwesomeIcons.sun,
                      size: 25,
                      color: themeState == ThemeMode.light
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor,
                    ),
                  ),
                  title: Text(
                    'Cerah',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Material(
              color: themeState == ThemeMode.dark
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).cardTheme.color,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.shadow,
                highlightColor: Theme.of(context).colorScheme.shadow,
                onTap: () {
                  ref.read(themeProvider.notifier).set(ThemeMode.dark);
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 15),
                  leading: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FaIcon(
                      FontAwesomeIcons.solidMoon,
                      size: 25,
                      color: themeState == ThemeMode.dark
                          ? Theme.of(context).primaryColor
                          : Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor,
                    ),
                  ),
                  title: Text(
                    'Gelap',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Material(
              color: themeState == ThemeMode.system
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).cardTheme.color,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.shadow,
                highlightColor: Theme.of(context).colorScheme.shadow,
                onTap: () {
                  ref.read(themeProvider.notifier).set(ThemeMode.system);
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 15),
                  leading: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FaIcon(
                      FontAwesomeIcons.cog,
                      size: 25,
                      color: themeState == ThemeMode.system
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor,
                    ),
                  ),
                  title: Text(
                    'Sesuai sistem',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
