// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post.dart';

part 'saved_posts_state.freezed.dart';

@freezed
class SavedPostsState with _$SavedPostsState {
  const factory SavedPostsState.loading() = _Loading;
  const factory SavedPostsState.appendPage({
    required List<Post> posts,
    required int nextPageKey,
  }) = _AppendPage;
  const factory SavedPostsState.appendLastPage({
    required List<Post> posts,
  }) = _AppendLastPage;
  const factory SavedPostsState.failedToLoadData() = _Error;
}
