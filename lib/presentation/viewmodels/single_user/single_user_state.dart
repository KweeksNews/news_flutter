// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user.dart';

part 'single_user_state.freezed.dart';

@freezed
class SingleUserState with _$SingleUserState {
  const factory SingleUserState.loading() = _Loading;
  const factory SingleUserState.loaded({
    required User user,
  }) = _Loaded;
  const factory SingleUserState.failedToLoadData() = _Error;
}
