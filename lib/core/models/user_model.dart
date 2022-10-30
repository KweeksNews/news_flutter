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
import 'package:html_unescape/html_unescape.dart';

import '../entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.description,
    required super.avatar,
  });

  factory UserModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return UserModel(
      id: data['databaseId'] as int,
      slug: data['slug'] as String,
      name: HtmlUnescape().convert(data['name'] as String),
      description: data['description'] as String? ?? '',
      avatar: data['avatar']['url'] as String,
    );
  }

  factory UserModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return UserModel(
      id: data['id'] as int,
      slug: data['slug'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      avatar: data['avatar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'avatar': avatar,
    };
  }
}

class UserConverter extends TypeConverter<User, String> {
  const UserConverter();

  @override
  User fromSql(
    String fromDb,
  ) {
    return UserModel.fromJson(
      jsonDecode(fromDb) as Map<String, dynamic>,
    );
  }

  @override
  String toSql(
    User value,
  ) {
    return jsonEncode(
      UserModel(
        id: value.id,
        slug: value.slug,
        avatar: value.avatar,
        description: value.description,
        name: value.name,
      ).toJson(),
    );
  }
}
