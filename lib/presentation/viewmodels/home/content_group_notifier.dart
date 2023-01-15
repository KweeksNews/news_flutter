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

import '../../../../domain/enums/content_group_type.dart';
import '../../../../providers.dart';
import '../../../application/shared/get_posts.dart';
import 'notifier.dart';

@injectable
class ContentGroupNotifier extends StateNotifier<ContentGroupState> {
  final GetPosts _getPosts;
  final List<String> _initialIds;
  final Ref _ref;

  ContentGroupNotifier(
    this._getPosts,
    @factoryParam this._initialIds,
    @factoryParam this._ref,
  ) : super(const ContentGroupState.loading());

  Future<void> fetchPage({
    required ContentGroupType contentGroupType,
    required int postsCount,
    bool forceRefresh = false,
  }) async {
    state = const ContentGroupState.loading();

    final id = _ref.read(contentGroupDropdownProvider(_initialIds));

    final failureOrPosts = await _getPosts(
      categoryIn: contentGroupType == ContentGroupType.category ? id : null,
      categoryNotIn: ['1084'],
      tagIn: contentGroupType == ContentGroupType.tag ? id : null,
      first: postsCount,
      forceRefresh: forceRefresh,
    );

    if (mounted) {
      failureOrPosts.fold(
        (failure) {
          state = const ContentGroupState.failedToLoadData();
        },
        (posts) {
          state = ContentGroupState.loaded(
            posts: posts.posts,
          );
        },
      );
    }
  }
}
