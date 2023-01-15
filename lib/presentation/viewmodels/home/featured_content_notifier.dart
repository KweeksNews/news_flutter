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
