/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/enums/state_exception_type.dart';
import '../../../../core/domain/usecases/get_posts.dart';
import '../../../../providers.dart';
import 'notifier.dart';

@injectable
class SearchNotifier extends StateNotifier<SearchState> {
  final GetPosts _getPosts;
  final Ref _ref;

  SearchNotifier(
    this._getPosts,
    @factoryParam this._ref,
  ) : super(const SearchLoading());

  Future<void> fetchPage({
    required int postsCount,
    required String pageKey,
    bool forceRefresh = false,
  }) async {
    final String searchTerm = _ref.read(searchTermProvider);

    if (searchTerm.isEmpty) {
      state = const SearchException(
        type: StateExceptionType.noSearchTerm,
      );
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
            state = const SearchException(
              type: StateExceptionType.failedToLoadData,
            );
          },
          (postList) {
            if (forceRefresh) {
              forceRefresh = false;
            }

            if (postList.hasNextPage!) {
              state = SearchAppend(
                posts: postList.posts,
                nextPageKey: postList.endCursor!,
              );
            } else {
              state = SearchAppendLast(
                posts: postList.posts,
              );
            }
          },
        );
      }
    }
  }
}

@injectable
class SearchTermNotifier extends StateNotifier<String> {
  SearchTermNotifier() : super('');

  void setSearchTerm({
    required String searchTerm,
  }) {
    state = searchTerm;
  }
}

@injectable
class SearchBarFilledStatusNotifier extends StateNotifier<bool> {
  SearchBarFilledStatusNotifier() : super(false);

  void setFilledStatus({
    required bool isFilled,
  }) {
    state = isFilled;
  }
}
