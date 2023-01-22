import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/domain/entities/category_id.dart';
import 'package:kweeksnews_app/domain/entities/post_id.dart';
import 'package:kweeksnews_app/domain/entities/tag_id.dart';
import 'package:kweeksnews_app/domain/entities/user_id.dart';
import 'package:kweeksnews_app/domain/error/exceptions.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/infrastructure/datasources/shared/wp_remote_data_source.dart';
import 'package:kweeksnews_app/infrastructure/dtos/category_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/post_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/posts_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/tag_model.dart';
import 'package:kweeksnews_app/infrastructure/dtos/user_model.dart';
import 'package:kweeksnews_app/infrastructure/repositories/shared/wp_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/category.dart';
import '../../../fixtures/post.dart';
import '../../../fixtures/posts.dart';
import '../../../fixtures/tag.dart';
import '../../../fixtures/user.dart';
import 'wp_repository_impl_test.mocks.dart';

@GenerateMocks([WpRemoteDataSource])
void main() {
  late MockWpRemoteDataSource mockWpRemoteDataSource;
  late WpRepositoryImpl repository;

  setUp(
    () {
      mockWpRemoteDataSource = MockWpRemoteDataSource();
      repository = WpRepositoryImpl(mockWpRemoteDataSource);
    },
  );

  group(
    'Get user',
    () {
      final UserId testId = UserId.id('1');
      const bool testForceRefresh = false;
      const UserModel testUserModel = userModel;

      group(
        'Device is online',
        () {
          test(
            'Should return data when the call to remote data source is successful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getUser(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenAnswer(
                (_) async => testUserModel,
              );

              // Act
              final result = await repository.getUser(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getUser(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                const Right<Failure, UserModel>(testUserModel),
              );
            },
          );

          test(
            'Should return request failure when the call to remote data source is unsuccessful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getUser(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                RequestException(),
              );

              // Act
              final result = await repository.getUser(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getUser(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(RequestFailure()),
              );
            },
          );
        },
      );

      group(
        'Device is offline',
        () {
          test(
            'Should return network failure when the call to remote data source indicating that device is offline',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getUser(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                NetworkException(),
              );

              // Act
              final result = await repository.getUser(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getUser(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Get category',
    () {
      final CategoryId testId = CategoryId.id('1');
      const bool testForceRefresh = false;
      const CategoryModel testCategoryModel = categoryModel;

      group(
        'Device is online',
        () {
          test(
            'Should return data when the call to remote data source is successful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getCategory(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenAnswer(
                (_) async => testCategoryModel,
              );

              // Act
              final result = await repository.getCategory(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getCategory(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                const Right<Failure, CategoryModel>(testCategoryModel),
              );
            },
          );

          test(
            'Should return request failure when the call to remote data source is unsuccessful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getCategory(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                RequestException(),
              );

              // Act
              final result = await repository.getCategory(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getCategory(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(RequestFailure()),
              );
            },
          );
        },
      );

      group(
        'Device is offline',
        () {
          test(
            'Should return network failure when the call to remote data source indicating that device is offline',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getCategory(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                NetworkException(),
              );

              // Act
              final result = await repository.getCategory(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getCategory(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Get tag',
    () {
      final TagId testId = TagId.id('1');
      const bool testForceRefresh = false;
      const TagModel testTagModel = tagModel;

      group(
        'Device is online',
        () {
          test(
            'Should return data when the call to remote data source is successful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getTag(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenAnswer(
                (_) async => testTagModel,
              );

              // Act
              final result = await repository.getTag(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getTag(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                const Right<Failure, TagModel>(testTagModel),
              );
            },
          );

          test(
            'Should return request failure when the call to remote data source is unsuccessful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getTag(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                RequestException(),
              );

              // Act
              final result = await repository.getTag(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getTag(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(RequestFailure()),
              );
            },
          );
        },
      );

      group(
        'Device is offline',
        () {
          test(
            'Should return network failure when the call to remote data source indicating that device is offline',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getTag(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                NetworkException(),
              );

              // Act
              final result = await repository.getTag(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getTag(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Get post',
    () {
      final PostId testId = PostId.id('1');
      const bool testForceRefresh = false;
      final PostModel testPostModel = postModel;

      group(
        'Device is online',
        () {
          test(
            'Should return data when the call to remote data source is successful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getPost(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenAnswer(
                (_) async => testPostModel,
              );

              // Act
              final result = await repository.getPost(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getPost(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Right<Failure, PostModel>(testPostModel),
              );
            },
          );

          test(
            'Should return request failure when the call to remote data source is unsuccessful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getPost(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                RequestException(),
              );

              // Act
              final result = await repository.getPost(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getPost(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(RequestFailure()),
              );
            },
          );
        },
      );

      group(
        'Device is offline',
        () {
          test(
            'Should return network failure when the call to remote data source indicating that device is offline',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getPost(
                  id: anyNamed('id'),
                  idType: anyNamed('idType'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                NetworkException(),
              );

              // Act
              final result = await repository.getPost(
                id: testId,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getPost(
                  id: testId.id,
                  idType: testId.type,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, UserModel>(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Get posts',
    () {
      const String testSearchTerm = 'test';
      const int testPostsCount = 1;
      const String testPageKey = 'test';
      const bool testForceRefresh = false;
      final PostsModel testPostsModel = postsModel;

      group(
        'Device is online',
        () {
          test(
            'Should return data when the call to remote data source is successful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getPosts(
                  search: anyNamed('search'),
                  notIn: anyNamed('notIn'),
                  authorIn: anyNamed('authorIn'),
                  categoryIn: anyNamed('categoryIn'),
                  categoryNotIn: anyNamed('categoryNotIn'),
                  tagIn: anyNamed('tagIn'),
                  tagNotIn: anyNamed('tagNotIn'),
                  first: anyNamed('first'),
                  after: anyNamed('after'),
                  last: anyNamed('last'),
                  before: anyNamed('before'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenAnswer(
                (_) async => testPostsModel,
              );

              // Act
              final result = await repository.getPosts(
                search: testSearchTerm,
                first: testPostsCount,
                after: testPageKey,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Right<Failure, PostsModel>(testPostsModel),
              );
            },
          );

          test(
            'Should return request failure when the call to remote data source is unsuccessful',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getPosts(
                  search: anyNamed('search'),
                  notIn: anyNamed('notIn'),
                  authorIn: anyNamed('authorIn'),
                  categoryIn: anyNamed('categoryIn'),
                  categoryNotIn: anyNamed('categoryNotIn'),
                  tagIn: anyNamed('tagIn'),
                  tagNotIn: anyNamed('tagNotIn'),
                  first: anyNamed('first'),
                  after: anyNamed('after'),
                  last: anyNamed('last'),
                  before: anyNamed('before'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                RequestException(),
              );

              // Act
              final result = await repository.getPosts(
                search: testSearchTerm,
                first: testPostsCount,
                after: testPageKey,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, PostsModel>(RequestFailure()),
              );
            },
          );
        },
      );

      group(
        'Device is offline',
        () {
          test(
            'Should return network failure when the call to remote data source indicating that device is offline',
            () async {
              // Arrange
              when(
                mockWpRemoteDataSource.getPosts(
                  search: anyNamed('search'),
                  notIn: anyNamed('notIn'),
                  authorIn: anyNamed('authorIn'),
                  categoryIn: anyNamed('categoryIn'),
                  categoryNotIn: anyNamed('categoryNotIn'),
                  tagIn: anyNamed('tagIn'),
                  tagNotIn: anyNamed('tagNotIn'),
                  first: anyNamed('first'),
                  after: anyNamed('after'),
                  last: anyNamed('last'),
                  before: anyNamed('before'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                NetworkException(),
              );

              // Act
              final result = await repository.getPosts(
                search: testSearchTerm,
                first: testPostsCount,
                after: testPageKey,
                forceRefresh: testForceRefresh,
              );

              // Assert
              verify(
                mockWpRemoteDataSource.getPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, PostsModel>(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );
}
