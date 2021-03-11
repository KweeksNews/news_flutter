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
import 'package:injectable/injectable.dart';

import '../../../../core/datasources/databases/database_utils.dart';
import '../../../../core/datasources/network/wordpress_apis.dart';
import '../../../../core/entities/post_list.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/post_model.dart';
import '../../domain/repositories/single_post_repository.dart';

@LazySingleton(as: SinglePostRepository)
class SinglePostRepositoryImpl implements SinglePostRepository {
  final SavedPostsDao savedPostsDao;
  final WpApi wpApi;

  SinglePostRepositoryImpl({
    required this.savedPostsDao,
    required this.wpApi,
  });

  @override
  Future<Either<Failure, bool>> isSavedPost({
    required int postId,
  }) async {
    try {
      return Right(await savedPostsDao.isSavedPost(
        postId: postId,
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> createSavedPost({
    required PostModel post,
  }) async {
    try {
      return Right(await savedPostsDao.createSavedPost(
        post: post,
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteSavedPost({
    required int postId,
  }) async {
    try {
      return Right(await savedPostsDao.deleteSavedPost(
        postId: postId,
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, PostList>> getRelatedPosts({
    required int catId,
    required int postId,
    required bool forceRefresh,
  }) async {
    try {
      final PostList posts = await wpApi.getPosts(
        request: {
          'exclude': '$postId',
          'categories': '$catId',
          'page': '1',
          'per_page': '3',
          '_fields': 'id,date,title,content,custom,link',
        },
        forceRefresh: forceRefresh,
      );
      return Right(posts);
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
