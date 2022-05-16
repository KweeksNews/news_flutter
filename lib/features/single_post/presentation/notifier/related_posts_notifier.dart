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

import '../../../../core/types/state_exception_type.dart';
import '../../domain/usecases/get_related_posts.dart';
import 'notifier.dart';

@injectable
class RelatedPostsNotifier extends StateNotifier<RelatedPostsState> {
  final GetRelatedPosts _getRelatedPosts;

  RelatedPostsNotifier(
    this._getRelatedPosts,
  ) : super(const RelatedPostsLoading());

  Future<void> fetchPosts(
    String postId,
    List<String> tagsId,
  ) async {
    state = const RelatedPostsLoading();

    final failureOrPosts = await _getRelatedPosts(
      postId: postId,
      tagsId: tagsId,
      postsCount: 3,
      forceRefresh: true,
    );

    if (!mounted) {
      return;
    } else {
      failureOrPosts.fold(
        (failure) {
          state = const RelatedPostsException(
            type: StateExceptionType.failedToLoadData,
          );
        },
        (postList) {
          state = RelatedPostsLoaded(
            posts: postList.posts,
          );
        },
      );
    }
  }
}
