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
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/error/exceptions.dart';

abstract class LocaleLocalDataSource {
  Future<Locale> getLocale();

  Future<Locale> setLocale(String languageCode);
}

@LazySingleton(as: LocaleLocalDataSource)
class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  final Box<dynamic> _box;

  LocaleLocalDataSourceImpl(
    @Named('settingsBox') this._box,
  );

  @override
  Future<Locale> getLocale() async {
    final String? languageCode = _box.get('languageCode') as String?;

    switch (languageCode) {
      case 'en':
      case 'id':
        return Locale(languageCode!);
      default:
        throw ConfigException();
    }
  }

  @override
  Future<Locale> setLocale(
    String languageCode,
  ) async {
    switch (languageCode) {
      case 'en':
      case 'id':
        await _box.put('languageCode', languageCode);

        return Locale(languageCode);
      default:
        throw ConfigException();
    }
  }
}
