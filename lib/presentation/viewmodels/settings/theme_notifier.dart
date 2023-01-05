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
import 'package:injectable/injectable.dart';

import '../../../application/settings/get_theme.dart';
import '../../../application/settings/set_theme.dart';
import '../../../domain/enums/state_exception_type.dart';
import 'notifier.dart';

@injectable
class ThemeNotifier extends StateNotifier<ThemeState> {
  final GetTheme _getTheme;
  final SetTheme _setTheme;

  ThemeNotifier(
    this._getTheme,
    this._setTheme,
  ) : super(const ThemeLoading(themeMode: ThemeMode.system));

  Future<void> get() async {
    final failureOrThemeMode = await _getTheme();

    if (mounted) {
      failureOrThemeMode.fold(
        (failure) {
          state = ThemeException(
            themeMode: state.themeMode,
            type: StateExceptionType.failedToRetrieveSettings,
          );
        },
        (themeMode) {
          state = ThemeLoaded(
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
          state = ThemeException(
            themeMode: state.themeMode,
            type: StateExceptionType.failedToChangeSettings,
          );
        },
        (themeMode) {
          state = ThemeLoaded(
            themeMode: themeMode,
          );
        },
      );
    }
  }
}
