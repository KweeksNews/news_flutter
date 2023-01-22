// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/single_tag/get_tag.dart';
import '../../../domain/entities/tag_id.dart';
import 'notifier.dart';

@injectable
class SingleTagNotifier extends StateNotifier<SingleTagState> {
  final GetTag _getTag;

  SingleTagNotifier(
    this._getTag,
  ) : super(const SingleTagState.loading());

  Future<void> fetchTag({
    required TagId id,
    bool forceRefresh = false,
  }) async {
    state = const SingleTagState.loading();

    final failureOrTag = await _getTag(
      id: id,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrTag.fold(
        (failure) {
          state = const SingleTagState.failedToLoadData();
        },
        (tagData) {
          state = SingleTagState.loaded(
            tag: tagData,
          );
        },
      );
    }
  }
}
