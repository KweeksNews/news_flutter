// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

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
