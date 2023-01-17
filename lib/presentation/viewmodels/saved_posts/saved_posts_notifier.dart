// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/saved_posts/get_saved_posts.dart';
import 'notifier.dart';

@injectable
class SavedPostsNotifier extends StateNotifier<SavedPostsState> {
  final GetSavedPosts _getSavedPosts;

  SavedPostsNotifier(
    this._getSavedPosts,
  ) : super(const SavedPostsState.loading());

  Future<void> fetchPage({
    required int postsCount,
    required int pageKey,
    required int fetched,
    bool forceRefresh = false,
  }) async {
    final failureOrPosts = await _getSavedPosts(
      postsCount: postsCount,
      pageKey: pageKey,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const SavedPostsState.failedToLoadData();
        },
        (posts) {
          if (fetched + posts.posts.length != posts.totalPosts!) {
            state = SavedPostsState.appendPage(
              posts: posts.posts,
              nextPageKey: pageKey + 1,
            );
          } else {
            state = SavedPostsState.appendLastPage(
              posts: posts.posts,
            );
          }
        },
      );
    }
  }
}
