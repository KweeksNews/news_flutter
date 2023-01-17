// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.loading({
    required ThemeMode themeMode,
  }) = _Loading;
  const factory ThemeState.loaded({
    required ThemeMode themeMode,
  }) = _Loaded;
  const factory ThemeState.failedToRetrieveSettings({
    required ThemeMode themeMode,
  }) = _Error;
}
