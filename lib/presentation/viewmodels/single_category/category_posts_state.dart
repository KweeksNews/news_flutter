// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post.dart';

part 'category_posts_state.freezed.dart';

@freezed
class CategoryPostsState with _$CategoryPostsState {
  const factory CategoryPostsState.loading() = _Loading;
  const factory CategoryPostsState.appendPage({
    required List<Post> posts,
    required String nextPageKey,
  }) = _AppendPage;
  const factory CategoryPostsState.appendLastPage({
    required List<Post> posts,
  }) = _AppendLastPage;
  const factory CategoryPostsState.failedToLoadData() = _Error;
}
