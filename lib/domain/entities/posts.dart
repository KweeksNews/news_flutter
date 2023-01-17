// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:equatable/equatable.dart';

import 'post.dart';

class Posts extends Equatable {
  final List<Post> posts;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final String? startCursor;
  final String? endCursor;
  final int? totalPosts;

  const Posts({
    required this.posts,
    this.hasNextPage,
    this.hasPreviousPage,
    this.startCursor,
    this.endCursor,
    this.totalPosts,
  });

  @override
  List<Object> get props {
    return [
      posts,
    ];
  }
}
