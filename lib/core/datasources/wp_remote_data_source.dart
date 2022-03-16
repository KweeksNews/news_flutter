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

import '../config/graphql.dart';
import '../error/exceptions.dart' as exceptions;
import '../models/post_list_model.dart';
import '../models/post_model.dart';

abstract class WpRemoteDataSource {
  const WpRemoteDataSource();

  Future<PostListModel> getPosts({
    String? search,
    List<String>? notIn,
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
        if (result.exception!.linkException is NetworkException) {
          throw exceptions.NetworkException();
        } else {
          throw exceptions.RequestException();
        }
      } else {
        return result.data ?? {};
      }
    } catch (error) {
      throw exceptions.RequestException();
    }
  }

  @override
  Future<PostListModel> getPosts({
    String? search,
    List<String>? notIn,
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

      return PostListModel.fromGraphQLJson(
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
