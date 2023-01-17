// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../application/shared/get_posts.dart';
import '../../../providers.dart';
import 'notifier.dart';

@injectable
class SearchNotifier extends StateNotifier<SearchState> {
  final GetPosts _getPosts;
  final Ref _ref;

  SearchNotifier(
    this._getPosts,
    @factoryParam this._ref,
  ) : super(const SearchState.loading());

  Future<void> fetchPage({
    required int postsCount,
    required String pageKey,
    bool forceRefresh = false,
  }) async {
    final String searchTerm = _ref.read(searchTermProvider);

    if (searchTerm.isEmpty) {
      state = const SearchState.noSearchTerm();
    } else {
      final failureOrPosts = await _getPosts(
        search: searchTerm,
        first: postsCount,
        after: pageKey,
        forceRefresh: forceRefresh,
      );

      if (mounted) {
        failureOrPosts.fold(
          (failure) {
            state = const SearchState.failedToLoadData();
          },
          (posts) {
            if (posts.hasNextPage!) {
              state = SearchState.appendPage(
                posts: posts.posts,
                nextPageKey: posts.endCursor!,
              );
            } else {
              state = SearchState.appendLastPage(
                posts: posts.posts,
              );
            }
          },
        );
      }
    }
  }
}
