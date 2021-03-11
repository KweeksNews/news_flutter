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

import '../../../../core/datasources/network/wordpress_apis.dart';
import '../../../../core/entities/comment_list.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/comments_repository.dart';

@LazySingleton(as: CommentsRepository)
class CommentsRepositoryImpl implements CommentsRepository {
  final WpApi wpApi;

  CommentsRepositoryImpl({
    required this.wpApi,
  });

  @override
  Future<Either<Failure, CommentList>> getComments({
    required int postId,
    required int pageKey,
    required bool forceRefresh,
  }) async {
    try {
      final CommentList posts = await wpApi.getComments(
        request: {
          'post': '$postId',
          'page': '$pageKey',
          'per_page': '5',
          'order': 'desc',
          'orderby': 'date',
          '_fields': 'id,author_name,author_avatar_urls,date,content',
        },
        forceRefresh: forceRefresh,
      );
      return Right(posts);
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
