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
import '../../domain/usecases/search_posts.dart';
import 'notifier.dart';

@injectable
class SearchNotifier extends StateNotifier<SearchState> {
  SearchPosts searchPosts;
  bool forceRefresh = false;
  String searchTerm = '';

  SearchNotifier({
    required this.searchPosts,
  }) : super(const SearchLoading());

  Future<void> fetchPage(int pageKey, int fetched) async {
    if (searchTerm.isEmpty) {
      state = const SearchError(
        message: 'No keyword',
      );
    } else {
      final failureOrPosts = await searchPosts(
        searchTerm: searchTerm,
        pageKey: pageKey,
        forceRefresh: forceRefresh,
      );

      failureOrPosts.fold(
        (failure) {
          state = const SearchError(
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
            state = SearchAppendLast(
              posts: posts,
            );
          } else {
            state = SearchAppend(
              posts: posts,
              nextPageKey: pageKey + 1,
            );
          }
        },
      );
    }
  }
}
