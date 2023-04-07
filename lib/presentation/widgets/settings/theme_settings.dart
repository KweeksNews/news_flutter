// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers.dart';
import '../../l10n/generated/l10n.dart';

class ThemeSettingsDialog extends ConsumerWidget {
  const ThemeSettingsDialog({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final ThemeMode themeState = ref.watch(themeProvider).themeMode;

    return SimpleDialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      titlePadding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
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
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          leading: Container(
            constraints: const BoxConstraints(
              minWidth: 40,
              maxWidth: 40,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.light_mode_rounded,
            ),
          ),
          title: Text(
            AppLocalizations.of(context).optionThemeLight,
          ),
          onTap: () {
            ref.read(themeProvider.notifier).set(
                  mode: ThemeMode.light,
                );
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
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          leading: Container(
            constraints: const BoxConstraints(
              minWidth: 40,
              maxWidth: 40,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.dark_mode_rounded,
            ),
          ),
          title: Text(
            AppLocalizations.of(context).optionThemeDark,
          ),
          onTap: () {
            ref.read(themeProvider.notifier).set(
                  mode: ThemeMode.dark,
                );
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
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          leading: Container(
            constraints: const BoxConstraints(
              minWidth: 40,
              maxWidth: 40,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.settings_suggest_rounded,
            ),
          ),
          title: Text(
            AppLocalizations.of(context).optionThemeSystem,
          ),
          onTap: () {
            ref.read(themeProvider.notifier).set(
                  mode: ThemeMode.system,
                );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
