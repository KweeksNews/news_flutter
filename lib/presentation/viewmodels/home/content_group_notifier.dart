// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../providers.dart';
import '../../../application/shared/get_posts.dart';
import '../../../domain/entities/content_group_ids.dart';
import 'notifier.dart';

@injectable
class ContentGroupNotifier extends StateNotifier<ContentGroupState> {
  final GetPosts _getPosts;
  final ContentGroupIds _initialIds;
  final Ref _ref;

  ContentGroupNotifier(
    this._getPosts,
    @factoryParam this._initialIds,
    @factoryParam this._ref,
  ) : super(const ContentGroupState.loading());

  Future<void> fetchPage({
    required int postsCount,
    bool forceRefresh = false,
  }) async {
    state = const ContentGroupState.loading();

    final id = _ref.read(contentGroupDropdownProvider(_initialIds));

    final failureOrPosts = await _getPosts(
      categoryIn: id.categoryIds,
      categoryNotIn: ['1084'],
      tagIn: id.tagIds,
      first: postsCount,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const ContentGroupState.failedToLoadData();
        },
        (posts) {
          state = ContentGroupState.loaded(
            posts: posts.posts,
          );
        },
      );
    }
  }
}
