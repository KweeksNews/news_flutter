// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/shared/get_posts.dart';
import 'notifier.dart';

@injectable
class TagPostsNotifier extends StateNotifier<TagPostsState> {
  final GetPosts _getPosts;

  TagPostsNotifier(
    this._getPosts,
  ) : super(const TagPostsState.loading());

  Future<void> fetchPage({
    required List<String> tagIn,
    required String pageKey,
    bool forceRefresh = false,
  }) async {
    state = const TagPostsState.loading();

    final failureOrPosts = await _getPosts(
      tagIn: tagIn,
      first: 10,
      after: pageKey,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const TagPostsState.failedToLoadData();
        },
        (posts) {
          if (posts.hasNextPage!) {
            state = TagPostsState.appendPage(
              posts: posts.posts,
              nextPageKey: posts.endCursor!,
            );
          } else {
            state = TagPostsState.appendLastPage(
              posts: posts.posts,
            );
          }
        },
      );
    }
  }
}
