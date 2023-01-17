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
class UserPostsNotifier extends StateNotifier<UserPostsState> {
  final GetPosts _getPosts;

  UserPostsNotifier(
    this._getPosts,
  ) : super(const UserPostsState.loading());

  Future<void> fetchPage({
    required List<String> authorIn,
    required String pageKey,
    bool forceRefresh = false,
  }) async {
    state = const UserPostsState.loading();

    final failureOrPosts = await _getPosts(
      authorIn: authorIn,
      first: 10,
      after: pageKey,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const UserPostsState.failedToLoadData();
        },
        (posts) {
          if (posts.hasNextPage!) {
            state = UserPostsState.appendPage(
              posts: posts.posts,
              nextPageKey: posts.endCursor!,
            );
          } else {
            state = UserPostsState.appendLastPage(
              posts: posts.posts,
            );
          }
        },
      );
    }
  }
}
