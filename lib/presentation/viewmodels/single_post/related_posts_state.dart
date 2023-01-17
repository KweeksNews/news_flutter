// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post.dart';

part 'related_posts_state.freezed.dart';

@freezed
class RelatedPostsState with _$RelatedPostsState {
  const factory RelatedPostsState.loading() = _Loading;
  const factory RelatedPostsState.loaded({
    required List<Post> posts,
  }) = _Loaded;
  const factory RelatedPostsState.failedToLoadData() = _Error;
}
