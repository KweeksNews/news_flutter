// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post.dart';

part 'single_post_state.freezed.dart';

@freezed
class SinglePostState with _$SinglePostState {
  const factory SinglePostState.loading() = _Loading;
  const factory SinglePostState.loaded({
    required Post post,
  }) = _Loaded;
  const factory SinglePostState.failedToLoadData() = _Error;
}
