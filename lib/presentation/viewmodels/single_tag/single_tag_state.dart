// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/tag.dart';

part 'single_tag_state.freezed.dart';

@freezed
class SingleTagState with _$SingleTagState {
  const factory SingleTagState.loading() = _Loading;
  const factory SingleTagState.loaded({
    required Tag tag,
  }) = _Loaded;
  const factory SingleTagState.failedToLoadData() = _Error;
}
