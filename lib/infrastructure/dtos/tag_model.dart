// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../domain/entities/tag.dart';

class TagModel extends Tag {
  const TagModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.description,
  });

  factory TagModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return TagModel(
      id: data['databaseId'] as int,
      slug: data['slug'] as String,
      name: HtmlUnescape().convert(data['name'] as String),
      description: data['description'] as String? ?? '',
    );
  }

  factory TagModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return TagModel(
      id: data['id'] as int,
      slug: data['slug'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
    };
  }
}

class TagsConverter extends TypeConverter<List<Tag>, String> {
  const TagsConverter();

  @override
  List<Tag> fromSql(
    String fromDb,
  ) {
    return List.from(
      (jsonDecode(fromDb) as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => TagModel.fromJson(d)),
    );
  }

  @override
  String toSql(
    List<Tag> value,
  ) {
    return jsonEncode(
      List<Map<String, dynamic>>.from(
        value.map(
          (d) => TagModel(
            id: d.id,
            slug: d.slug,
            name: d.name,
            description: d.description,
          ).toJson(),
        ),
      ),
    );
  }
}
