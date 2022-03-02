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
import '../../../../core/l10n/l10n.dart';
import '../../domain/usecases/get_post.dart';
import 'notifier.dart';

@injectable
class SinglePostNotifier extends StateNotifier<SinglePostState> {
  final GetPost _getPost;

  SinglePostNotifier(
    this._getPost,
  ) : super(const SinglePostLoading());

  Future<void> fetchPost(
    String postSlug,
  ) async {
    state = const SinglePostLoading();

    final failureOrPost = await _getPost(
      postSlug: postSlug,
      forceRefresh: true,
    );

    failureOrPost.fold(
      (failure) {
        state = SinglePostError(
          message: AppLocalizations.current.errorFailedToLoadData,
          image: 'assets/img/error.png',
        );
      },
      (postData) {
        final Post post = postData;

        state = SinglePostLoaded(
          post: post,
        );
      },
    );
  }
}
