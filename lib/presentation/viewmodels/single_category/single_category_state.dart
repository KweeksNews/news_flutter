// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/category.dart' as entity;

part 'single_category_state.freezed.dart';

@freezed
class SingleCategoryState with _$SingleCategoryState {
  const factory SingleCategoryState.loading() = _Loading;
  const factory SingleCategoryState.loaded({
    required entity.Category category,
  }) = _Loaded;
  const factory SingleCategoryState.failedToLoadData() = _Error;
}
