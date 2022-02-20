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

import 'package:drift/drift.dart';

import '../entities/author.dart';

class AuthorModel extends Author {
  const AuthorModel({
    required String name,
    required String avatar,
  }) : super(
          name: name,
          avatar: avatar,
        );

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: json['name'].toString(),
      avatar: json['avatar'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
    };
  }
}

class AuthorConverter extends TypeConverter<Author, String> {
  const AuthorConverter();
  @override
  Author? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    } else {
      return AuthorModel.fromJson(
        jsonDecode(fromDb) as Map<String, dynamic>,
      );
    }
  }

  @override
  String? mapToSql(Author? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(
        AuthorModel(
          avatar: value.avatar,
          name: value.name,
        ).toJson(),
      );
    }
  }
}
