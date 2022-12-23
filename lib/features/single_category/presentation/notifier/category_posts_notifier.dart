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
import 'notifier.dart';

@injectable
class CategoryPostsNotifier extends StateNotifier<CategoryPostsState> {
  final GetPosts _getPosts;

  CategoryPostsNotifier(
    this._getPosts,
  ) : super(const CategoryPostsLoading());

  Future<void> fetchPage({
    required List<String> categoryIn,
    required String pageKey,
    bool forceRefresh = false,
  }) async {
    state = const CategoryPostsLoading();

    final failureOrPosts = await _getPosts(
      categoryIn: categoryIn,
      first: 10,
      after: pageKey,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const CategoryPostsException(
            type: StateExceptionType.failedToLoadData,
          );
        },
        (postList) {
          if (forceRefresh) {
            forceRefresh = false;
          }

          if (postList.hasNextPage!) {
            state = CategoryPostsAppend(
              posts: postList.posts,
              nextPageKey: postList.endCursor!,
            );
          } else {
            state = CategoryPostsAppendLast(
              posts: postList.posts,
            );
          }
        },
      );
    }
  }
}
