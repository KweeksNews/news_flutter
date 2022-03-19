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

import '../../../../core/l10n/generated/l10n.dart';
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
    String pageKey,
  ) async {
    final failureOrPosts = await _getPosts(
      categoryId: _categoryId,
      postsCount: 10,
      pageKey: pageKey,
      forceRefresh: forceRefresh,
    );

    failureOrPosts.fold(
      (failure) {
        state = HomeError(
          message: AppLocalizations.current.errorFailedToLoadData,
          image: 'assets/img/error.png',
        );
      },
      (postList) {
        if (forceRefresh) {
          forceRefresh = false;
        }

        if (postList.hasNextPage!) {
          state = HomeAppend(
            posts: postList.posts,
            nextPageKey: postList.endCursor!,
          );
        } else {
          state = HomeAppendLast(
            posts: postList.posts,
          );
        }
      },
    );
  }
}
