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
class RelatedPostsNotifier extends StateNotifier<RelatedPostsState> {
  final GetPosts _getPosts;

  RelatedPostsNotifier(
    this._getPosts,
  ) : super(const RelatedPostsState.loading());

  Future<void> fetchPosts({
    required String postId,
    required List<String> tagsId,
  }) async {
    state = const RelatedPostsState.loading();

    final failureOrPosts = await _getPosts(
      notIn: [postId],
      tagIn: tagsId,
      first: 3,
      forceRefresh: true,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const RelatedPostsState.failedToLoadData();
        },
        (posts) {
          state = RelatedPostsState.loaded(
            posts: posts.posts,
          );
        },
      );
    }
  }
}
