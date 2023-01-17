// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.description,
    required super.children,
  });

  factory CategoryModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return CategoryModel(
      id: data['databaseId'] as int,
      slug: data['slug'] as String,
      name: HtmlUnescape().convert(data['name'] as String),
      description: data['description'] as String? ?? '',
      children: List.from(
        (data['children']?['nodes'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>()
            .map((d) => CategoryModel.fromGraphQLJson(d)),
      ),
    );
  }

  factory CategoryModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return CategoryModel(
      id: data['id'] as int,
      slug: data['slug'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      children: List.from(
        (data['children'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((d) => CategoryModel.fromJson(d)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'children': List<Map<String, dynamic>>.from(
        children.map(
          (d) => CategoryModel(
            id: d.id,
            slug: d.slug,
            name: d.name,
            description: d.description,
            children: d.children,
          ).toJson(),
        ),
      ),
    };
  }
}

class CategoriesConverter extends TypeConverter<List<Category>, String> {
  const CategoriesConverter();

  @override
  List<Category> fromSql(
    String fromDb,
  ) {
    return List.from(
      (jsonDecode(fromDb) as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => CategoryModel.fromJson(d)),
    );
  }

  @override
  String toSql(
    List<Category> value,
  ) {
    return jsonEncode(
      List<Map<String, dynamic>>.from(
        value.map(
          (d) => CategoryModel(
                  id: d.id,
                  slug: d.slug,
                  name: d.name,
                  description: d.description,
                  children: d.children)
              .toJson(),
        ),
      ),
    );
  }
}
