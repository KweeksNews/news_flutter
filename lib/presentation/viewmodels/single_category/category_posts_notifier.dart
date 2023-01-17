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
class CategoryPostsNotifier extends StateNotifier<CategoryPostsState> {
  final GetPosts _getPosts;

  CategoryPostsNotifier(
    this._getPosts,
  ) : super(const CategoryPostsState.loading());

  Future<void> fetchPage({
    required List<String> categoryIn,
    required String pageKey,
    bool forceRefresh = false,
  }) async {
    state = const CategoryPostsState.loading();

    final failureOrPosts = await _getPosts(
      categoryIn: categoryIn,
      first: 10,
      after: pageKey,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const CategoryPostsState.failedToLoadData();
        },
        (posts) {
          if (posts.hasNextPage!) {
            state = CategoryPostsState.appendPage(
              posts: posts.posts,
              nextPageKey: posts.endCursor!,
            );
          } else {
            state = CategoryPostsState.appendLastPage(
              posts: posts.posts,
            );
          }
        },
      );
    }
  }
}
