// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post.dart';

part 'user_posts_state.freezed.dart';

@freezed
class UserPostsState with _$UserPostsState {
  const factory UserPostsState.loading() = _Loading;
  const factory UserPostsState.appendPage({
    required List<Post> posts,
    required String nextPageKey,
  }) = _AppendPage;
  const factory UserPostsState.appendLastPage({
    required List<Post> posts,
  }) = _AppendLastPage;
  const factory UserPostsState.failedToLoadData() = _Error;
}
