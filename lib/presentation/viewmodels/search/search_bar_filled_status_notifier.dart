// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchBarFilledStatusNotifier extends StateNotifier<bool> {
  SearchBarFilledStatusNotifier() : super(false);

  void setFilledStatus({
    required bool isFilled,
  }) {
    state = isFilled;
  }
}
