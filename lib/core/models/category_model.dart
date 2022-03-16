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

import '../entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required int id,
    required String slug,
    required String name,
  }) : super(
          id: id,
          slug: slug,
          name: name,
        );

  factory CategoryModel.fromGraphQlJson(
    Map<String, dynamic> data,
  ) {
    return CategoryModel(
      id: data['databaseId'] as int,
      slug: data['slug'] as String,
      name: data['name'] as String,
    );
  }

  factory CategoryModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return CategoryModel(
      id: data['id'] as int,
      slug: data['slug'] as String,
      name: data['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
    };
  }
}

class CategoriesConverter extends TypeConverter<List<Category>, String> {
  const CategoriesConverter();

  @override
  List<Category>? mapToDart(
    String? fromDb,
  ) {
    if (fromDb == null) {
      return null;
    } else {
      return List.from(
        (jsonDecode(fromDb) as List<dynamic>).cast<Map<String, dynamic>>().map(
              (Map<String, dynamic> d) => CategoryModel.fromJson(d),
            ),
      );
    }
  }

  @override
  String? mapToSql(
    List<Category>? value,
  ) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(
        List<Map<String, dynamic>>.from(
          value.map(
            (d) => CategoryModel(
              id: d.id,
              slug: d.slug,
              name: d.name,
            ).toJson(),
          ),
        ),
      );
    }
  }
}
