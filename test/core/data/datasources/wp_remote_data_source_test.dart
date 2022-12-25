import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:kweeksnews_app/config/graphql.dart';
import 'package:kweeksnews_app/core/data/datasources/wp_remote_data_source.dart';
import 'package:kweeksnews_app/core/data/models/category_model.dart';
import 'package:kweeksnews_app/core/data/models/post_model.dart';
import 'package:kweeksnews_app/core/data/models/posts_model.dart';
import 'package:kweeksnews_app/core/data/models/tag_model.dart';
import 'package:kweeksnews_app/core/data/models/user_model.dart';
import 'package:kweeksnews_app/core/domain/enums/category_id_type.dart';
import 'package:kweeksnews_app/core/domain/enums/post_id_type.dart';
import 'package:kweeksnews_app/core/domain/enums/tag_id_type.dart';
import 'package:kweeksnews_app/core/domain/enums/user_node_id_type.dart';
import 'package:kweeksnews_app/core/domain/error/exceptions.dart' as exceptions;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/category.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../fixtures/post.dart';
import '../../../fixtures/posts.dart';
import '../../../fixtures/tag.dart';
import '../../../fixtures/user.dart';
import 'wp_remote_data_source_test.mocks.dart';

@GenerateMocks([GraphQLClient])
void main() {
  late MockGraphQLClient mockGraphQLClient;
  late WpRemoteDataSource dataSource;

  setUp(
    () {
      mockGraphQLClient = MockGraphQLClient();
      dataSource = WpRemoteDataSourceImpl(mockGraphQLClient);
    },
  );

  const String testUserId = '1';
  const UserNodeIdType testUserIdType = UserNodeIdType.databaseId;
  final String testUserJson = fixture('user.json');
  const UserModel testUserModel = userModel;
  const String testCategoryId = '1';
  const CategoryIdType testCategoryIdType = CategoryIdType.databaseId;
  final String testCategoryJson = fixture('category.json');
  const CategoryModel testCategoryModel = categoryModel;
  const String testTagId = '2';
  const TagIdType testTagIdType = TagIdType.databaseId;
  final String testTagJson = fixture('tag.json');
  const TagModel testTagModel = tagModel;
  final String testPostsJson = fixture('posts.json');
  final PostsModel testPostsModel = postsModel;
  const String testPostId = '2';
  const PostIdType testPostIdType = PostIdType.databaseId;
  final String testPostJson = fixture('post.json');
  final PostModel testPostModel = postModel;
  const bool testForceRefresh = false;

  group(
    'Get User',
    () {
      test(
        'Should perform user query with provided variables and return UserModel',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.userQuery),
              ),
              source: QueryResultSource.network,
              data: jsonDecode(testUserJson) as Map<String, dynamic>,
              context: const Context(),
              exception: null,
            ),
          );

          final result = await dataSource.getUser(
            id: testUserId,
            idType: testUserIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.userQuery),
                variables: {
                  'id': testUserId,
                  'idType': testUserIdType.toString(),
                },
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
            ),
          );

          expect(
            result,
            testUserModel,
          );
        },
      );

      test(
        'Should throw NetworkException when failed to fetch data due to network error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.userQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                linkException: NetworkException(
                  uri: Uri(),
                ),
              ),
            ),
          );

          final call = dataSource.getUser;

          expect(
            () => call(
              id: testUserId,
              idType: testUserIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.userQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                graphqlErrors: const [
                  GraphQLError(
                    message: 'Error',
                  ),
                ],
              ),
            ),
          );

          final call = dataSource.getUser;

          expect(
            () => call(
              id: testUserId,
              idType: testUserIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get Category',
    () {
      test(
        'Should perform category query with provided variables and return CategoryModel',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.categoryQuery),
              ),
              source: QueryResultSource.network,
              data: jsonDecode(testCategoryJson) as Map<String, dynamic>,
              context: const Context(),
              exception: null,
            ),
          );

          final result = await dataSource.getCategory(
            id: testCategoryId,
            idType: testCategoryIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.categoryQuery),
                variables: {
                  'id': testCategoryId,
                  'idType': testCategoryIdType.toString(),
                },
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
            ),
          );

          expect(
            result,
            testCategoryModel,
          );
        },
      );

      test(
        'Should throw NetworkException when failed to fetch data due to network error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.categoryQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                linkException: NetworkException(
                  uri: Uri(),
                ),
              ),
            ),
          );

          final call = dataSource.getCategory;

          expect(
            () => call(
              id: testCategoryId,
              idType: testCategoryIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.categoryQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                graphqlErrors: const [
                  GraphQLError(
                    message: 'Error',
                  ),
                ],
              ),
            ),
          );

          final call = dataSource.getCategory;

          expect(
            () => call(
              id: testCategoryId,
              idType: testCategoryIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get Tag',
    () {
      test(
        'Should perform tag query with provided variables and return TagModel',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.tagQuery),
              ),
              source: QueryResultSource.network,
              data: jsonDecode(testTagJson) as Map<String, dynamic>,
              context: const Context(),
              exception: null,
            ),
          );

          final result = await dataSource.getTag(
            id: testTagId,
            idType: testTagIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.tagQuery),
                variables: {
                  'id': testTagId,
                  'idType': testTagIdType.toString(),
                },
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
            ),
          );

          expect(
            result,
            testTagModel,
          );
        },
      );

      test(
        'Should throw NetworkException when failed to fetch data due to network error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.tagQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                linkException: NetworkException(
                  uri: Uri(),
                ),
              ),
            ),
          );

          final call = dataSource.getTag;

          expect(
            () => call(
              id: testTagId,
              idType: testTagIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.tagQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                graphqlErrors: const [
                  GraphQLError(
                    message: 'Error',
                  ),
                ],
              ),
            ),
          );

          final call = dataSource.getTag;

          expect(
            () => call(
              id: testTagId,
              idType: testTagIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get Posts',
    () {
      test(
        'Should perform posts query with provided variables and return PostsModel',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.postsQuery),
              ),
              source: QueryResultSource.network,
              data: jsonDecode(testPostsJson) as Map<String, dynamic>,
              context: const Context(),
              exception: null,
            ),
          );

          final result = await dataSource.getPosts(
            search: '',
            notIn: [],
            authorIn: [],
            categoryIn: [],
            categoryNotIn: [],
            tagIn: [],
            tagNotIn: [],
            first: 1,
            after: '',
            last: 0,
            before: '',
            forceRefresh: testForceRefresh,
          );

          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.postsQuery),
                variables: const {
                  'search': '',
                  'notIn': <String>[],
                  'authorIn': <String>[],
                  'categoryIn': <String>[],
                  'categoryNotIn': <String>[],
                  'tagIn': <String>[],
                  'tagNotIn': <String>[],
                  'first': 1,
                  'after': '',
                  'last': 0,
                  'before': '',
                },
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
            ),
          );

          expect(
            result,
            testPostsModel,
          );
        },
      );

      test(
        'Should throw NetworkException when failed to fetch data due to network error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.postsQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                linkException: NetworkException(
                  uri: Uri(),
                ),
              ),
            ),
          );

          final call = dataSource.getPosts;

          expect(
            () => call(
              search: '',
              notIn: [],
              authorIn: [],
              categoryIn: [],
              categoryNotIn: [],
              tagIn: [],
              tagNotIn: [],
              first: 1,
              after: '',
              last: 0,
              before: '',
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.postsQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                graphqlErrors: const [
                  GraphQLError(
                    message: 'Error',
                  ),
                ],
              ),
            ),
          );

          final call = dataSource.getPosts;

          expect(
            () => call(
              search: '',
              notIn: [],
              authorIn: [],
              categoryIn: [],
              categoryNotIn: [],
              tagIn: [],
              tagNotIn: [],
              first: 1,
              after: '',
              last: 0,
              before: '',
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get Post',
    () {
      test(
        'Should perform post query with provided variables and return PostModel',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.postQuery),
              ),
              source: QueryResultSource.network,
              data: jsonDecode(testPostJson) as Map<String, dynamic>,
              context: const Context(),
              exception: null,
            ),
          );

          final result = await dataSource.getPost(
            id: testPostId,
            idType: testPostIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.postQuery),
                variables: {
                  'id': testPostId,
                  'idType': testPostIdType.toString(),
                },
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
            ),
          );

          expect(
            result,
            testPostModel,
          );
        },
      );

      test(
        'Should throw NetworkException when failed to fetch data due to network error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.postQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                linkException: NetworkException(
                  uri: Uri(),
                ),
              ),
            ),
          );

          final call = dataSource.getPost;

          expect(
            () => call(
              id: testPostId,
              idType: testPostIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          when(
            mockGraphQLClient.query<dynamic>(any),
          ).thenAnswer(
            (_) async => QueryResult(
              options: QueryOptions(
                document: gql(GqlDocument.postQuery),
              ),
              source: QueryResultSource.loading,
              context: const Context(),
              exception: OperationException(
                graphqlErrors: const [
                  GraphQLError(
                    message: 'Error',
                  ),
                ],
              ),
            ),
          );

          final call = dataSource.getPost;

          expect(
            () => call(
              id: testPostId,
              idType: testPostIdType.toString(),
              forceRefresh: testForceRefresh,
            ),
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );
}
