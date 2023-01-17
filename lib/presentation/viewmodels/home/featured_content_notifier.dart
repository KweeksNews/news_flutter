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
class FeaturedContentNotifier extends StateNotifier<FeaturedContentState> {
  final GetPosts _getPosts;

  FeaturedContentNotifier(
    this._getPosts,
  ) : super(const FeaturedContentState.loading());

  Future<void> fetchPage({
    required int postsCount,
    bool forceRefresh = false,
  }) async {
    state = const FeaturedContentState.loading();

    final failureOrPosts = await _getPosts(
      categoryNotIn: ['1084'],
      first: postsCount,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const FeaturedContentState.failedToLoadData();
        },
        (posts) {
          state = FeaturedContentState.loaded(
            posts: posts.posts,
          );
        },
      );
    }
  }
}
