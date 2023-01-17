// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:html_unescape/html_unescape.dart';

import '../../domain/entities/post.dart';
import '../database/app_database.dart';
import 'category_model.dart';
import 'tag_model.dart';
import 'user_model.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.date,
    required super.slug,
    required super.title,
    required super.content,
    required super.image,
    required super.video,
    required super.author,
    required super.categories,
    required super.tags,
  });

  factory PostModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return PostModel(
      id: data['databaseId'] as int,
      date: DateTime.parse(data['date'] as String),
      slug: data['slug'] as String,
      title: HtmlUnescape().convert(data['title'] as String),
      content: data['content'] as String? ?? '',
      image: data['featuredImage']?['node']['sourceUrl'] as String? ?? '',
      video: data['featuredVideo'] as String,
      author: UserModel.fromGraphQLJson(
        data['author']['node'] as Map<String, dynamic>,
      ),
      categories: List.from(
        (data['categories']?['nodes'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>()
            .map((d) => CategoryModel.fromGraphQLJson(d)),
      ),
      tags: List.from(
        (data['tags']?['nodes'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>()
            .map((d) => TagModel.fromGraphQLJson(d)),
      ),
    );
  }

  factory PostModel.fromDB(
    SavedPost data,
  ) {
    return PostModel(
      id: data.id,
      date: data.date,
      slug: data.slug,
      title: data.title,
      content: '',
      image: data.image,
      video: data.video,
      author: data.author,
      categories: data.categories,
      tags: const [],
    );
  }

  SavedPost toDB() {
    return SavedPost(
      id: id,
      date: date,
      slug: slug,
      title: title,
      image: image,
      video: video,
      author: author,
      categories: categories,
    );
  }
}
