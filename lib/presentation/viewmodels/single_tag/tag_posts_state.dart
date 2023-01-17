// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post.dart';

part 'tag_posts_state.freezed.dart';

@freezed
class TagPostsState with _$TagPostsState {
  const factory TagPostsState.loading() = _Loading;
  const factory TagPostsState.appendPage({
    required List<Post> posts,
    required String nextPageKey,
  }) = _AppendPage;
  const factory TagPostsState.appendLastPage({
    required List<Post> posts,
  }) = _AppendLastPage;
  const factory TagPostsState.failedToLoadData() = _Error;
}
