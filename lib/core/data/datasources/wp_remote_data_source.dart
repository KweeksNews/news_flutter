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

import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import '../../../config/graphql.dart';
import '../../domain/error/exceptions.dart' as exceptions;
import '../models/category_model.dart';
import '../models/posts_model.dart';
import '../models/post_model.dart';
import '../models/tag_model.dart';
import '../models/user_model.dart';

abstract class WpRemoteDataSource {
  const WpRemoteDataSource();

  Future<UserModel> getUser({
    required String id,
    required String idType,
    required bool forceRefresh,
  });

  Future<CategoryModel> getCategory({
    required String id,
    required String idType,
    required bool forceRefresh,
  });

  Future<TagModel> getTag({
    required String id,
    required String idType,
    required bool forceRefresh,
  });

  Future<PostsModel> getPosts({
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
  });

  Future<PostModel> getPost({
    required String id,
    required String idType,
    required bool forceRefresh,
  });
}

@LazySingleton(as: WpRemoteDataSource)
class WpRemoteDataSourceImpl extends WpRemoteDataSource {
  final GraphQLClient _client;

  WpRemoteDataSourceImpl(
    this._client,
  );

  Future<Map<String, dynamic>> _query({
    required String query,
    required Map<String, dynamic> variables,
    required bool forceRefresh,
  }) async {
    try {
      final QueryResult<dynamic> result = await _client.query(
        QueryOptions(
          document: gql(query),
          variables: variables,
          fetchPolicy: forceRefresh
              ? FetchPolicy.networkOnly
              : FetchPolicy.cacheAndNetwork,
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      } else {
        return result.data ?? {};
      }
    } catch (error) {
      if ((error as OperationException).linkException is NetworkException) {
        throw exceptions.NetworkException();
      } else {
        throw exceptions.RequestException();
      }
    }
  }

  @override
  Future<UserModel> getUser({
    required String id,
    required String idType,
    required bool forceRefresh,
  }) async {
    try {
      final result = await _query(
        query: GqlDocument.userQuery,
        variables: {
          'id': id,
          'idType': idType,
        },
        forceRefresh: forceRefresh,
      );

      return UserModel.fromGraphQLJson(
        result['user'] as Map<String, dynamic>,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<CategoryModel> getCategory({
    required String id,
    required String idType,
    required bool forceRefresh,
  }) async {
    try {
      final result = await _query(
        query: GqlDocument.categoryQuery,
        variables: {
          'id': id,
          'idType': idType,
        },
        forceRefresh: forceRefresh,
      );

      return CategoryModel.fromGraphQLJson(
        result['category'] as Map<String, dynamic>,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<TagModel> getTag({
    required String id,
    required String idType,
    required bool forceRefresh,
  }) async {
    try {
      final result = await _query(
        query: GqlDocument.tagQuery,
        variables: {
          'id': id,
          'idType': idType,
        },
        forceRefresh: forceRefresh,
      );

      return TagModel.fromGraphQLJson(
        result['tag'] as Map<String, dynamic>,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PostsModel> getPosts({
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
      final result = await _query(
        query: GqlDocument.postsQuery,
        variables: {
          'search': search,
          'notIn': notIn,
          'authorIn': authorIn,
          'categoryIn': categoryIn,
          'categoryNotIn': categoryNotIn,
          'tagIn': tagIn,
          'tagNotIn': tagNotIn,
          'first': first,
          'after': after,
          'last': last,
          'before': before,
        },
        forceRefresh: forceRefresh,
      );

      return PostsModel.fromGraphQLJson(
        result['posts'] as Map<String, dynamic>,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PostModel> getPost({
    required String id,
    required String idType,
    required bool forceRefresh,
  }) async {
    try {
      final result = await _query(
        query: GqlDocument.postQuery,
        variables: {
          'id': id,
          'idType': idType,
        },
        forceRefresh: forceRefresh,
      );

      return PostModel.fromGraphQLJson(
        result['post'] as Map<String, dynamic>,
      );
    } catch (error) {
      rethrow;
    }
  }
}
