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
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeDataSource {
  Future<ThemeMode> getTheme();

  Future<bool> setTheme(ThemeMode mode);
}

const themeMode = 'theme_mode';

@LazySingleton(as: ThemeDataSource)
class ThemeDataSourceImpl implements ThemeDataSource {
  final SharedPreferences sharedPreferences;

  ThemeDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<ThemeMode> getTheme() async {
    final String? mode = sharedPreferences.getString(themeMode);

    switch (mode) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<bool> setTheme(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.system:
        return sharedPreferences.setString(themeMode, 'system');
      case ThemeMode.light:
        return sharedPreferences.setString(themeMode, 'light');
      case ThemeMode.dark:
        return sharedPreferences.setString(themeMode, 'dark');
      default:
        return sharedPreferences.setString(themeMode, 'system');
    }
  }
}
