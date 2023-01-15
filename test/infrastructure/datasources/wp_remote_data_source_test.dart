import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:kweeksnews_app/config/graphql.dart';
import 'package:kweeksnews_app/domain/enums/category_id_type.dart';
import 'package:kweeksnews_app/domain/enums/post_id_type.dart';
import 'package:kweeksnews_app/domain/enums/tag_id_type.dart';
import 'package:kweeksnews_app/domain/enums/user_node_id_type.dart';
import 'package:kweeksnews_app/domain/error/exceptions.dart' as exceptions;
import 'package:kweeksnews_app/infrastructure/datasources/shared/wp_remote_data_source.dart';
import 'package:kweeksnews_app/infrastructure/dtos/category_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/post_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/posts_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/tag_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/category.dart';
import '../../fixtures/fixture_reader.dart';
import '../../fixtures/post.dart';
import '../../fixtures/posts.dart';
import '../../fixtures/tag.dart';
import '../../fixtures/user.dart';
import 'wp_remote_data_source_test.mocks.dart';

@GenerateMocks([GraphQLClient])
void main() {
  late MockGraphQLClient mockGraphQLClient;
  late WpRemoteDataSourceImpl dataSource;

  const bool testForceRefresh = false;

  setUp(
    () {
      mockGraphQLClient = MockGraphQLClient();
      dataSource = WpRemoteDataSourceImpl(mockGraphQLClient);
    },
  );

  group(
    'Get user',
    () {
      const String testUserId = '1';
      const UserNodeIdType testUserIdType = UserNodeIdType.databaseId;
      final String testUserJson = fixture('user.json');
      const UserModel testUserModel = userModel;

      test(
        'Should perform user query with provided variables and return UserModel',
        () async {
          // Arrange
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

          // Act
          final result = await dataSource.getUser(
            id: testUserId,
            idType: testUserIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
          // Arrange
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
                linkException: NetworkException.fromException(
                  originalException: Exception(),
                  originalStackTrace: StackTrace.empty,
                  uri: Uri(),
                ),
              ),
            ),
          );

          // Act
          final result = dataSource.getUser(
            id: testUserId,
            idType: testUserIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          // Arrange
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

          // Act
          final result = dataSource.getUser(
            id: testUserId,
            idType: testUserIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get category',
    () {
      const String testCategoryId = '1';
      const CategoryIdType testCategoryIdType = CategoryIdType.databaseId;
      final String testCategoryJson = fixture('category.json');
      const CategoryModel testCategoryModel = categoryModel;

      test(
        'Should perform category query with provided variables and return CategoryModel',
        () async {
          // Arrange
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

          // Act
          final result = await dataSource.getCategory(
            id: testCategoryId,
            idType: testCategoryIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
          // Arrange
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
                linkException: NetworkException.fromException(
                  originalException: Exception(),
                  originalStackTrace: StackTrace.empty,
                  uri: Uri(),
                ),
              ),
            ),
          );

          // Act
          final result = dataSource.getCategory(
            id: testCategoryId,
            idType: testCategoryIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          // Arrange
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

          // Act
          final result = dataSource.getCategory(
            id: testCategoryId,
            idType: testCategoryIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get tag',
    () {
      const String testTagId = '2';
      const TagIdType testTagIdType = TagIdType.databaseId;
      final String testTagJson = fixture('tag.json');
      const TagModel testTagModel = tagModel;

      test(
        'Should perform tag query with provided variables and return TagModel',
        () async {
          // Arrange
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

          // Act
          final result = await dataSource.getTag(
            id: testTagId,
            idType: testTagIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
          // Arrange
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
                linkException: NetworkException.fromException(
                  originalException: Exception(),
                  originalStackTrace: StackTrace.empty,
                  uri: Uri(),
                ),
              ),
            ),
          );

          // Act
          final result = dataSource.getTag(
            id: testTagId,
            idType: testTagIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          // Arrange
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

          // Act
          final result = dataSource.getTag(
            id: testTagId,
            idType: testTagIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get post',
    () {
      const String testPostId = '2';
      const PostIdType testPostIdType = PostIdType.databaseId;
      final String testPostJson = fixture('post.json');
      final PostModel testPostModel = postModel;

      test(
        'Should perform post query with provided variables and return PostModel',
        () async {
          // Arrange
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

          // Act
          final result = await dataSource.getPost(
            id: testPostId,
            idType: testPostIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
          // Arrange
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
                linkException: NetworkException.fromException(
                  originalException: Exception(),
                  originalStackTrace: StackTrace.empty,
                  uri: Uri(),
                ),
              ),
            ),
          );

          // Act
          final result = dataSource.getPost(
            id: testPostId,
            idType: testPostIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          // Arrange
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

          // Act
          final result = dataSource.getPost(
            id: testPostId,
            idType: testPostIdType.toString(),
            forceRefresh: testForceRefresh,
          );

          // Assert
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
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );

  group(
    'Get posts',
    () {
      final String testPostsJson = fixture('posts.json');
      final PostsModel testPostsModel = postsModel;

      test(
        'Should perform posts query with provided variables and return PostsModel',
        () async {
          // Arrange
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

          // Act
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

          // Assert
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
          // Arrange
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
                linkException: NetworkException.fromException(
                  originalException: Exception(),
                  originalStackTrace: StackTrace.empty,
                  uri: Uri(),
                ),
              ),
            ),
          );

          // Act
          final result = dataSource.getPosts(
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

          // Assert
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
            throwsA(isA<exceptions.NetworkException>()),
          );
        },
      );

      test(
        'Should throw RequestException when failed to fetch data due to any other error',
        () async {
          // Arrange
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

          // Act
          final result = dataSource.getPosts(
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

          // Assert
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
            throwsA(isA<exceptions.RequestException>()),
          );
        },
      );
    },
  );
}
