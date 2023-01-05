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

import '../../../domain/entities/post.dart';
import '../../../domain/entities/posts.dart';
import '../../../domain/error/exceptions.dart';
import '../../../domain/error/failures.dart';
import '../../../domain/repositories/shared/saved_posts_repository.dart';
import '../../datasources/shared/saved_posts_local_data_source.dart';
import '../../dtos/post_model.dart';

@LazySingleton(as: SavedPostsRepository)
class SavedPostsRepositoryImpl implements SavedPostsRepository {
  final SavedPostsLocalDataSource _savedPostsLocalDataSource;

  SavedPostsRepositoryImpl(
    this._savedPostsLocalDataSource,
  );

  @override
  Future<Either<Failure, int>> addSavedPost({
    required Post post,
  }) async {
    try {
      return Right(await _savedPostsLocalDataSource.createSavedPost(
        post: PostModel(
          id: post.id,
          date: post.date,
          slug: post.slug,
          title: post.title,
          content: post.content,
          image: post.image,
          video: post.video,
          author: post.author,
          categories: post.categories,
          tags: post.tags,
        ),
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Posts>> getSavedPosts({
    required int postsCount,
    required int pageKey,
  }) async {
    try {
      final Posts posts = await _savedPostsLocalDataSource.readSavedPosts(
        postsCount: postsCount,
        pageKey: pageKey,
      );

      return Right(posts);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteSavedPost({
    required int postId,
  }) async {
    try {
      return Right(await _savedPostsLocalDataSource.deleteSavedPost(
        postId: postId,
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkPostSaveStatus({
    required int postId,
  }) async {
    try {
      return Right(await _savedPostsLocalDataSource.checkPostSaveStatus(
        postId: postId,
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
