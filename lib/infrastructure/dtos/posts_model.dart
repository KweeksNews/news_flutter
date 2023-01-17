// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import '../../domain/entities/posts.dart';
import '../database/app_database.dart';
import 'post_model.dart';

class PostsModel extends Posts {
  const PostsModel({
    required super.posts,
    super.hasNextPage,
    super.hasPreviousPage,
    super.startCursor,
    super.endCursor,
    super.totalPosts,
  });

  factory PostsModel.fromGraphQLJson(
    Map<String, dynamic> data,
  ) {
    return PostsModel(
      posts: List.from(
        (data['nodes'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((d) => PostModel.fromGraphQLJson(d)),
      ),
      hasNextPage: data['pageInfo']['hasNextPage'] as bool,
      hasPreviousPage: data['pageInfo']['hasPreviousPage'] as bool,
      startCursor: data['pageInfo']['startCursor'] as String? ?? '',
      endCursor: data['pageInfo']['endCursor'] as String? ?? '',
    );
  }

  factory PostsModel.fromDB(
    List<SavedPost> data,
    int count,
  ) {
    return PostsModel(
      posts: List.from(
        data.map((d) => PostModel.fromDB(d)),
      ),
      totalPosts: count,
    );
  }
}
