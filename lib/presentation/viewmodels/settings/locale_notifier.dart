// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/settings/get_locale.dart';
import '../../../application/settings/set_locale.dart';
import 'notifier.dart';

@injectable
class LocaleNotifier extends StateNotifier<LocaleState> {
  final GetLocale _getLocale;
  final SetLocale _setLocale;

  LocaleNotifier(
    this._getLocale,
    this._setLocale,
  ) : super(const LocaleState.loading(locale: Locale('id')));

  Future<void> get() async {
    final failureOrLocale = await _getLocale();

    if (mounted) {
      failureOrLocale.fold(
        (failure) {
          state = LocaleState.failedToRetrieveSettings(
            locale: state.locale,
          );
        },
        (locale) {
          state = LocaleState.loaded(
            locale: locale,
          );
        },
      );
    }
  }

  Future<void> set({
    required String languageCode,
  }) async {
    final failureOrLocale = await _setLocale(
      languageCode: languageCode,
    );

    if (mounted) {
      failureOrLocale.fold(
        (failure) {
          state = LocaleState.failedToRetrieveSettings(
            locale: state.locale,
          );
        },
        (locale) {
          state = LocaleState.loaded(
            locale: locale,
          );
        },
      );
    }
  }
}
