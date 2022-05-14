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

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../providers.dart';

class ThemeSettingsDialog extends ConsumerWidget {
  const ThemeSettingsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final ThemeMode themeState = ref.watch(themeProvider);

    return SimpleDialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      titlePadding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      title: Center(
        child: Text(
          AppLocalizations.of(context).settingThemeTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      children: <Widget>[
        ListTile(
          selected: themeState == ThemeMode.light,
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withAlpha(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 15),
          leading: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.light_mode_rounded,
            ),
          ),
          title: Text(
            AppLocalizations.of(context).optionThemeLight,
          ),
          onTap: () {
            ref.read(themeProvider.notifier).set(ThemeMode.light);
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          selected: themeState == ThemeMode.dark,
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withAlpha(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 15),
          leading: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.dark_mode_rounded,
            ),
          ),
          title: Text(
            AppLocalizations.of(context).optionThemeDark,
          ),
          onTap: () {
            ref.read(themeProvider.notifier).set(ThemeMode.dark);
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          selected: themeState == ThemeMode.system,
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withAlpha(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 15),
          leading: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.settings_suggest_rounded,
            ),
          ),
          title: Text(
            AppLocalizations.of(context).optionThemeSystem,
          ),
          onTap: () {
            ref.read(themeProvider.notifier).set(ThemeMode.system);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
