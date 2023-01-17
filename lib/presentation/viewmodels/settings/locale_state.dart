// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

@freezed
class LocaleState with _$LocaleState {
  const factory LocaleState.loading({
    required Locale locale,
  }) = _Loading;
  const factory LocaleState.loaded({
    required Locale locale,
  }) = _Loaded;
  const factory LocaleState.failedToRetrieveSettings({
    required Locale locale,
  }) = _Error;
}
