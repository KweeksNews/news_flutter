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

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class IdentityDataSource {
  Future<Map<String, String>> getIdentity();

  Future<void> setIdentity(Map<String, String> identity);
}

const themeMode = 'theme_mode';

@LazySingleton(as: IdentityDataSource)
class IdentityDataSourceImpl implements IdentityDataSource {
  final Box box;

  IdentityDataSourceImpl({
    required this.box,
  });

  @override
  Future<Map<String, String>> getIdentity() async {
    final Map? identity = box.get('identity') as Map?;

    if ((identity?.containsKey('name') ?? false) &&
        (identity?.containsKey('email') ?? false)) {
      return Map.from(identity!);
    } else {
      return {
        'name': '',
        'email': '',
      };
    }
  }

  @override
  Future<void> setIdentity(Map<String, String> identity) async {
    return box.put('identity', identity);
  }
}
