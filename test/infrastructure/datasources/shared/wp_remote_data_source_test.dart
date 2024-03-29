import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/config/graphql.dart';
import 'package:news/domain/entities/category_id.dart';
import 'package:news/domain/entities/post_id.dart';
import 'package:news/domain/entities/tag_id.dart';
import 'package:news/domain/entities/user_id.dart';
import 'package:news/domain/error/exceptions.dart' as exceptions;
import 'package:news/infrastructure/datasources/shared/wp_remote_data_source.dart';
import 'package:news/infrastructure/dtos/category_model.dart';
import 'package:news/infrastructure/dtos/post_model.dart';
import 'package:news/infrastructure/dtos/posts_model.dart';
import 'package:news/infrastructure/dtos/tag_model.dart';
import 'package:news/infrastructure/dtos/user_model.dart';

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
      final UserId testUserId = UserId.databaseId('1');
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
            id: testUserId.id,
            idType: testUserId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.userQuery),
                variables: {
                  'id': testUserId.id,
                  'idType': testUserId.type,
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
            id: testUserId.id,
            idType: testUserId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.userQuery),
                variables: {
                  'id': testUserId.id,
                  'idType': testUserId.type,
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
            id: testUserId.id,
            idType: testUserId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.userQuery),
                variables: {
                  'id': testUserId.id,
                  'idType': testUserId.type,
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
      final CategoryId testCategoryId = CategoryId.databaseId('1');
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
            id: testCategoryId.id,
            idType: testCategoryId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.categoryQuery),
                variables: {
                  'id': testCategoryId.id,
                  'idType': testCategoryId.type,
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
            id: testCategoryId.id,
            idType: testCategoryId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.categoryQuery),
                variables: {
                  'id': testCategoryId.id,
                  'idType': testCategoryId.type,
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
            id: testCategoryId.id,
            idType: testCategoryId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.categoryQuery),
                variables: {
                  'id': testCategoryId.id,
                  'idType': testCategoryId.type,
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
      final TagId testTagId = TagId.databaseId('2');
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
            id: testTagId.id,
            idType: testTagId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.tagQuery),
                variables: {
                  'id': testTagId.id,
                  'idType': testTagId.type,
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
            id: testTagId.id,
            idType: testTagId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.tagQuery),
                variables: {
                  'id': testTagId.id,
                  'idType': testTagId.type,
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
            id: testTagId.id,
            idType: testTagId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.tagQuery),
                variables: {
                  'id': testTagId.id,
                  'idType': testTagId.type,
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
      final PostId testPostId = PostId.databaseId('2');
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
            id: testPostId.id,
            idType: testPostId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.postQuery),
                variables: {
                  'id': testPostId.id,
                  'idType': testPostId.type,
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
            id: testPostId.id,
            idType: testPostId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.postQuery),
                variables: {
                  'id': testPostId.id,
                  'idType': testPostId.type,
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
            id: testPostId.id,
            idType: testPostId.type,
            forceRefresh: testForceRefresh,
          );

          // Assert
          verify(
            mockGraphQLClient.query<dynamic>(
              QueryOptions(
                document: gql(GqlDocument.postQuery),
                variables: {
                  'id': testPostId.id,
                  'idType': testPostId.type,
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
