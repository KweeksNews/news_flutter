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

import 'package:dartz/dartz.dart';

import '../../../../core/data/models/post_model.dart';
import '../../../../core/domain/entities/post.dart';
import '../../../../core/domain/entities/post_list.dart';
import '../../../../core/domain/enums/post_id_type.dart';
import '../../../../core/domain/error/failures.dart';

abstract class SinglePostRepository {
  Future<Either<Failure, int>> createSavedPost({
    required PostModel post,
  });

  Future<Either<Failure, int>> deleteSavedPost({
    required int postId,
  });

  Future<Either<Failure, bool>> checkPostSaveStatus({
    required int postId,
  });

  Future<Either<Failure, Post>> getPost({
    required String id,
    required PostIdType idType,
    required bool forceRefresh,
  });

  Future<Either<Failure, PostList>> getRelatedPosts({
    required String postId,
    required List<String> tagsId,
    required int postsCount,
    required bool forceRefresh,
  });
}
