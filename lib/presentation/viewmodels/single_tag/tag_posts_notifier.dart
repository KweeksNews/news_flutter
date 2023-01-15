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
