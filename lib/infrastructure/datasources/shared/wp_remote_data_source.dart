// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import '../../../config/graphql.dart';
import '../../../domain/error/exceptions.dart' as exceptions;
import '../../dtos/category_model.dart';
import '../../dtos/post_model.dart';
import '../../dtos/posts_model.dart';
import '../../dtos/tag_model.dart';
import '../../dtos/user_model.dart';

abstract class WpRemoteDataSource {
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

  Future<PostModel> getPost({
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
}

@LazySingleton(as: WpRemoteDataSource)
class WpRemoteDataSourceImpl implements WpRemoteDataSource {
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
}
