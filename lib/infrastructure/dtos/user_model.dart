// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../domain/entities/user.dart';

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
