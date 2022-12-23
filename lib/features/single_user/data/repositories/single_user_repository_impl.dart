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

import '../../../../core/data/datasources/wp_remote_data_source.dart';
import '../../../../core/domain/entities/post_list.dart';
import '../../../../core/domain/entities/user.dart';
import '../../../../core/domain/enums/user_node_id_type.dart';
import '../../../../core/domain/error/exceptions.dart';
import '../../../../core/domain/error/failures.dart';
import '../../domain/repositories/single_user_repository.dart';

@LazySingleton(as: SingleUserRepository)
class SingleUserRepositoryImpl implements SingleUserRepository {
  final WpRemoteDataSource _wpRemoteDataSource;

  SingleUserRepositoryImpl(
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
  Future<Either<Failure, PostList>> getPosts({
    required List<String> authorIn,
    required int postsCount,
    required String pageKey,
    required bool forceRefresh,
  }) async {
    try {
      final PostList posts = await _wpRemoteDataSource.getPosts(
        authorIn: authorIn,
        first: postsCount,
        after: pageKey,
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
