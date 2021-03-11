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

@lazySingleton
class SavedPostNotifier extends StateNotifier<bool> {
  CreateSavedPost createSavedPost;
  DeleteSavedPost deleteSavedPost;
  IsSavedPost isSavedPost;
  bool forceRefresh = true;

  SavedPostNotifier({
    required this.createSavedPost,
    required this.deleteSavedPost,
    required this.isSavedPost,
  }) : super(false);

  Future<void> createPost(PostModel post) async {
    final failureOrStatus = await createSavedPost(
      post: post,
    );

    failureOrStatus.fold(
      (failure) {
        state = false;
      },
      (status) {
        state = true;
      },
    );
  }

  Future<void> deletePost(int postId) async {
    final failureOrStatus = await deleteSavedPost(
      postId: postId,
    );

    failureOrStatus.fold(
      (failure) {
        state = true;
      },
      (status) {
        state = false;
      },
    );
  }

  Future<void> checkPost(int postId) async {
    final failureOrStatus = await isSavedPost(
      postId: postId,
    );

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
