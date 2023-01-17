// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/entities/posts.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/enums/category_id_type.dart';
import '../../../domain/enums/post_id_type.dart';
import '../../../domain/enums/tag_id_type.dart';
import '../../../domain/enums/user_node_id_type.dart';
import '../../../domain/error/exceptions.dart';
import '../../../domain/error/failures.dart';
import '../../../domain/repositories/shared/wp_repository.dart';
import '../../datasources/shared/wp_remote_data_source.dart';

@LazySingleton(as: WpRepository)
class WpRepositoryImpl implements WpRepository {
  final WpRemoteDataSource _wpRemoteDataSource;

  WpRepositoryImpl(
    this._wpRemoteDataSource,
  );

  @override
  Future<Either<Failure, User>> getUser({
    required String id,
    required UserNodeIdType idType,
    required bool forceRefresh,
  }) async {
    try {
      final User user = await _wpRemoteDataSource.getUser(
        id: id,
        idType: idType.toString(),
        forceRefresh: forceRefresh,
      );

      return Right(user);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RequestException {
      return Left(RequestFailure());
    }
  }

  @override
  Future<Either<Failure, Category>> getCategory({
    required String id,
    required CategoryIdType idType,
    required bool forceRefresh,
  }) async {
    try {
      final Category category = await _wpRemoteDataSource.getCategory(
        id: id,
        idType: idType.toString(),
        forceRefresh: forceRefresh,
      );

      return Right(category);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RequestException {
      return Left(RequestFailure());
    }
  }

  @override
  Future<Either<Failure, Tag>> getTag({
    required String id,
    required TagIdType idType,
    required bool forceRefresh,
  }) async {
    try {
      final Tag tag = await _wpRemoteDataSource.getTag(
        id: id,
        idType: idType.toString(),
        forceRefresh: forceRefresh,
      );

      return Right(tag);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RequestException {
      return Left(RequestFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> getPost({
    required String id,
    required PostIdType idType,
    required bool forceRefresh,
  }) async {
    try {
      final Post post = await _wpRemoteDataSource.getPost(
        id: id,
        idType: idType.toString(),
        forceRefresh: forceRefresh,
      );

      return Right(post);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RequestException {
      return Left(RequestFailure());
    }
  }

  @override
  Future<Either<Failure, Posts>> getPosts({
    String? search,
    List<String>? notIn,
    List<String>? authorIn,
    List<String>? categoryIn,
    List<String>? categoryNotIn,
    List<String>? tagIn,
    List<String>? tagNotIn,
    int? first,
    String? after,
    int? last,
    String? before,
    required bool forceRefresh,
  }) async {
    try {
      final Posts posts = await _wpRemoteDataSource.getPosts(
        search: search,
        notIn: notIn,
        authorIn: authorIn,
        categoryIn: categoryIn,
        categoryNotIn: categoryNotIn,
        tagIn: tagIn,
        tagNotIn: tagNotIn,
        first: first,
        after: after,
        last: last,
        before: before,
        forceRefresh: forceRefresh,
      );

      return Right(posts);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RequestException {
      return Left(RequestFailure());
    }
  }
}
