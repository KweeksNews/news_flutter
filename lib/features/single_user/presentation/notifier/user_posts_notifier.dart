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
class UserPostsNotifier extends StateNotifier<UserPostsState> {
  final GetPosts _getPosts;

  UserPostsNotifier(
    this._getPosts,
  ) : super(const UserPostsLoading());

  Future<void> fetchPage({
    required List<String> authorIn,
    required String pageKey,
    bool forceRefresh = false,
  }) async {
    state = const UserPostsLoading();

    final failureOrPosts = await _getPosts(
      authorIn: authorIn,
      first: 10,
      after: pageKey,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const UserPostsException(
            type: StateExceptionType.failedToLoadData,
          );
        },
        (posts) {
          if (posts.hasNextPage!) {
            state = UserPostsAppend(
              posts: posts.posts,
              nextPageKey: posts.endCursor!,
            );
          } else {
            state = UserPostsAppendLast(
              posts: posts.posts,
            );
          }
        },
      );
    }
  }
}
