// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers.dart';
import '../../../l10n/generated/l10n.dart';

class LocaleSettingsDialog extends ConsumerWidget {
  const LocaleSettingsDialog({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final Locale localeState = ref.watch(localeProvider).locale;

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
          AppLocalizations.of(context).settingLanguageTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      children: <Widget>[
        ListTile(
          selected: localeState.languageCode == 'id',
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withAlpha(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          title: const Text(
            'Bahasa Indonesia',
          ),
          onTap: () {
            ref.read(localeProvider.notifier).set(
                  languageCode: 'id',
                );
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          selected: localeState.languageCode == 'en',
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withAlpha(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          title: const Text(
            'English',
          ),
          onTap: () {
            ref.read(localeProvider.notifier).set(
                  languageCode: 'en',
                );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
