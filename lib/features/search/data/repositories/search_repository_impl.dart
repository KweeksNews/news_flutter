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

import '../../../../core/datasources/wp_remote_data_source.dart';
import '../../../../core/entities/post_list.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/search_repository.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final WPRemoteDataSource _wpRemoteDataSource;

  SearchRepositoryImpl(
    this._wpRemoteDataSource,
  );

  @override
  Future<Either<Failure, PostList>> searchPosts({
    required String searchTerm,
    required int pageKey,
    required bool forceRefresh,
  }) async {
    try {
      final PostList posts = await _wpRemoteDataSource.getPosts(
        parameters: {
          'search': searchTerm,
          'page': '$pageKey',
          'per_page': '10',
          '_fields': 'id,date,slug,title,meta_for_app',
        },
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
