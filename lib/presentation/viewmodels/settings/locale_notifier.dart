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

import '../../../application/settings/get_locale.dart';
import '../../../application/settings/set_locale.dart';
import '../../../domain/enums/state_exception_type.dart';
import 'notifier.dart';

@injectable
class LocaleNotifier extends StateNotifier<LocaleState> {
  final GetLocale _getLocale;
  final SetLocale _setLocale;

  LocaleNotifier(
    this._getLocale,
    this._setLocale,
  ) : super(const LocaleLoading(locale: Locale('id')));

  Future<void> get() async {
    final failureOrLocale = await _getLocale();

    if (mounted) {
      failureOrLocale.fold(
        (failure) {
          state = LocaleException(
            locale: state.locale,
            type: StateExceptionType.failedToRetrieveSettings,
          );
        },
        (locale) {
          state = LocaleLoaded(
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
          state = LocaleException(
            locale: state.locale,
            type: StateExceptionType.failedToChangeSettings,
          );
        },
        (locale) {
          state = LocaleLoaded(
            locale: locale,
          );
        },
      );
    }
  }
}
