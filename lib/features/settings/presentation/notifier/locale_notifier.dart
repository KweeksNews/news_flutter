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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/presentation/l10n/generated/l10n.dart';
import '../../domain/usecases/get_locale.dart';
import '../../domain/usecases/set_locale.dart';

@injectable
class LocaleNotifier extends StateNotifier<Locale> {
  final GlobalKey<NavigatorState> _rootNavigatorKey;
  final GetLocale _getLocale;
  final SetLocale _setLocale;

  LocaleNotifier(
    @factoryParam this._rootNavigatorKey,
    this._getLocale,
    this._setLocale,
  ) : super(const Locale('id'));

  Future<void> get() async {
    final failureOrLocale = await _getLocale();

    if (mounted) {
      failureOrLocale.fold(
        // TODO implement failure
        (failure) => null,
        (locale) {
          state = locale;
        },
      );
    }
  }

  Future<void> set({
    required String languageCode,
  }) async {
    final failureOrBool = await _setLocale(
      languageCode: languageCode,
    );

    if (mounted) {
      failureOrBool.fold(
        (failure) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(_rootNavigatorKey.currentContext!)
                .errorFailedToChangeLanguage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        },
        (status) {
          state = Locale(languageCode);
        },
      );
    }
  }
}
