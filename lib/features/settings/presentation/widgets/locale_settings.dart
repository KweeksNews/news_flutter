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

import '../../../../core/l10n/l10n.dart';
import '../../../../providers.dart';

class LocaleSettingsDialog extends ConsumerWidget {
  const LocaleSettingsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, watch, child) {
        final Locale localeState = ref.watch(localeProvider);

        return SimpleDialog(
          backgroundColor: Theme.of(context).cardTheme.color,
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          titlePadding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          title: Center(
            child: Text(
              AppLocalizations.of(context).settingLanguageTitle,
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
          ),
          children: <Widget>[
            ListTile(
              selected: localeState.languageCode == 'id',
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              tileColor: Theme.of(context).cardTheme.color,
              selectedTileColor: Theme.of(context).canvasColor,
              contentPadding: const EdgeInsets.only(left: 15),
              title: Text(
                'Bahasa Indonesia',
                style: Theme.of(context).primaryTextTheme.headline5,
              ),
              onTap: () {
                ref.read(localeProvider.notifier).set('id');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              selected: localeState.languageCode == 'en',
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              tileColor: Theme.of(context).cardTheme.color,
              selectedTileColor: Theme.of(context).canvasColor,
              contentPadding: const EdgeInsets.only(left: 15),
              title: Text(
                'English',
                style: Theme.of(context).primaryTextTheme.headline5,
              ),
              onTap: () {
                ref.read(localeProvider.notifier).set('en');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
