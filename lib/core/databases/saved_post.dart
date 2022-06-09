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

import 'package:drift/drift.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';

class SavedPosts extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get slug => text()();
  TextColumn get title => text()();
  TextColumn get image => text()();
  TextColumn get video => text()();
  TextColumn get author => text().map(const UserConverter())();
  TextColumn get categories => text().map(const CategoriesConverter())();

  @override
  Set<Column<dynamic>> get primaryKey => {id};
}
