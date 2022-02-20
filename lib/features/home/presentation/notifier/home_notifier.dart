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

import '../../../../core/entities/post.dart';
import '../../domain/usecases/get_posts.dart';
import 'notifier.dart';

@injectable
class HomeNotifier extends StateNotifier<HomeState> {
  final GetPosts _getPosts;
  final String _categoryId;
  bool forceRefresh = false;

  HomeNotifier(
    this._getPosts,
    @factoryParam this._categoryId,
  ) : super(const HomeLoading());

  Future<void> fetchPage(
    int pageKey,
    int fetched,
  ) async {
    final failureOrPosts = await _getPosts(
      categoryId: _categoryId,
      pageKey: pageKey,
      forceRefresh: forceRefresh,
    );

    failureOrPosts.fold(
      (failure) {
        state = const HomeError(
          message: 's',
        );
      },
      (postList) {
        final int totalPosts = postList.totalPosts;
        final List<Post> posts = postList.posts;

        if (forceRefresh) {
          forceRefresh = false;
        }

        if (fetched + posts.length == totalPosts) {
          state = HomeAppendLast(
            posts: posts,
          );
        } else {
          state = HomeAppend(
            posts: posts,
            nextPageKey: pageKey + 1,
          );
        }
      },
    );
  }
}
