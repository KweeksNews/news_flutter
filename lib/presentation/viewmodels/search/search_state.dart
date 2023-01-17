// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.loading() = _Loading;
  const factory SearchState.appendPage({
    required List<Post> posts,
    required String nextPageKey,
  }) = _AppendPage;
  const factory SearchState.appendLastPage({
    required List<Post> posts,
  }) = _AppendLastPage;
  const factory SearchState.noSearchTerm() = _NoSearchTerm;
  const factory SearchState.failedToLoadData() = _Error;
}
