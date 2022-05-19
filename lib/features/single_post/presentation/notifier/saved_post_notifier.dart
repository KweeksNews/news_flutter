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

import '../../../../core/models/post_model.dart';
import '../../domain/usecases/create_saved_post.dart';
import '../../domain/usecases/delete_saved_post.dart';
import '../../domain/usecases/is_saved_post.dart';

@injectable
class SavedPostNotifier extends StateNotifier<bool> {
  final CreateSavedPost _createSavedPost;
  final DeleteSavedPost _deleteSavedPost;
  final IsSavedPost _isSavedPost;
  bool forceRefresh = true;

  SavedPostNotifier(
    this._createSavedPost,
    this._deleteSavedPost,
    this._isSavedPost,
  ) : super(false);

  Future<void> createPost({
    required PostModel post,
  }) async {
    final failureOrStatus = await _createSavedPost(
      post: post,
    );

    if (!mounted) {
      return;
    } else {
      failureOrStatus.fold(
        (failure) {
          state = false;
        },
        (status) {
          state = true;
        },
      );
    }
  }

  Future<void> deletePost({
    required int postId,
  }) async {
    final failureOrStatus = await _deleteSavedPost(
      postId: postId,
    );

    if (!mounted) {
      return;
    } else {
      failureOrStatus.fold(
        (failure) {
          state = true;
        },
        (status) {
          state = false;
        },
      );
    }
  }

  Future<void> checkPost({
    required int postId,
  }) async {
    final failureOrStatus = await _isSavedPost(
      postId: postId,
    );

    if (!mounted) {
      return;
    } else {
      failureOrStatus.fold(
        (failure) {
          state = false;
        },
        (status) {
          state = status;
        },
      );
    }
  }
}
