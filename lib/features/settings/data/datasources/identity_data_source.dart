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

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IdentityDataSource {
  Future<Map<String, String>> getIdentity();

  Future<bool> setIdentity(Map<String, String> identity);
}

const themeMode = 'theme_mode';

@LazySingleton(as: IdentityDataSource)
class IdentityDataSourceImpl implements IdentityDataSource {
  final SharedPreferences sharedPreferences;

  IdentityDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Map<String, String>> getIdentity() async {
    final String? identity = sharedPreferences.getString('identity');

    if (identity?.isNotEmpty ?? false) {
      return jsonDecode(identity!) as Map<String, String>;
    } else {
      return {
        'name': '',
        'email': '',
      };
    }
  }

  @override
  Future<bool> setIdentity(Map<String, String> identity) async {
    return sharedPreferences.setString('identity_name', jsonEncode(identity));
  }
}
