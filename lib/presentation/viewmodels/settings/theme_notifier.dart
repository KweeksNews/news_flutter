// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/settings/get_theme.dart';
import '../../../application/settings/set_theme.dart';
import 'notifier.dart';

@injectable
class ThemeNotifier extends StateNotifier<ThemeState> {
  final GetTheme _getTheme;
  final SetTheme _setTheme;

  ThemeNotifier(
    this._getTheme,
    this._setTheme,
  ) : super(const ThemeState.loading(themeMode: ThemeMode.system));

  Future<void> get() async {
    final failureOrThemeMode = await _getTheme();

    if (mounted) {
      failureOrThemeMode.fold(
        (failure) {
          state = ThemeState.failedToRetrieveSettings(
            themeMode: state.themeMode,
          );
        },
        (themeMode) {
          state = ThemeState.loaded(
            themeMode: themeMode,
          );
        },
      );
    }
  }

  Future<void> set({
    required ThemeMode mode,
  }) async {
    final failureOrThemeMode = await _setTheme(
      mode: mode,
    );

    if (mounted) {
      failureOrThemeMode.fold(
        (failure) {
          state = ThemeState.failedToRetrieveSettings(
            themeMode: state.themeMode,
          );
        },
        (themeMode) {
          state = ThemeState.loaded(
            themeMode: themeMode,
          );
        },
      );
    }
  }
}
