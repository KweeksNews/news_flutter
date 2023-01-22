import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/domain/error/exceptions.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/infrastructure/datasources/shared/saved_posts_local_data_source.dart';
import 'package:news/infrastructure/dtos/post_model.dart';
import 'package:news/infrastructure/dtos/posts_model.dart';
import 'package:news/infrastructure/repositories/shared/saved_posts_repository_impl.dart';

import '../../../fixtures/post.dart';
import '../../../fixtures/posts.dart';
import 'saved_posts_repository_impl_test.mocks.dart';

@GenerateMocks([SavedPostsLocalDataSource])
void main() {
  late MockSavedPostsLocalDataSource mockSavedPostsLocalDataSource;
  late SavedPostsRepositoryImpl repository;

  const int testPostId = 1;
  const int testPostsCount = 10;
  const int testPageKey = 1;
  const bool testPostSaveStatus = true;
  final PostsModel testPostsModel = postsModel;
  final PostModel testPostModel = postModel;

  setUp(
    () {
      mockSavedPostsLocalDataSource = MockSavedPostsLocalDataSource();
      repository = SavedPostsRepositoryImpl(mockSavedPostsLocalDataSource);
    },
  );

  group(
    'Add saved post',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.createSavedPost(
              post: anyNamed('post'),
            ),
          ).thenAnswer(
            (_) async => testPostId,
          );

          // Act
          final result = await repository.addSavedPost(
            post: testPostModel,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.createSavedPost(
              post: testPostModel,
            ),
          );

          expect(
            result,
            const Right<Failure, int>(testPostId),
          );
        },
      );

      test(
        'Should return database failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.createSavedPost(
              post: anyNamed('post'),
            ),
          ).thenThrow(
            DatabaseException(),
          );

          // Act
          final result = await repository.addSavedPost(
            post: testPostModel,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.createSavedPost(
              post: testPostModel,
            ),
          );

          expect(
            result,
            Left<Failure, int>(DatabaseFailure()),
          );
        },
      );
    },
  );

  group(
    'Get saved posts',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.readSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          ).thenAnswer(
            (_) async => testPostsModel,
          );

          // Act
          final result = await repository.getSavedPosts(
            postsCount: testPostsCount,
            pageKey: testPageKey,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.readSavedPosts(
              postsCount: testPostsCount,
              pageKey: testPageKey,
            ),
          );

          expect(
            result,
            Right<Failure, PostsModel>(testPostsModel),
          );
        },
      );

      test(
        'Should return database failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.readSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          ).thenThrow(
            DatabaseException(),
          );

          // Act
          final result = await repository.getSavedPosts(
            postsCount: testPostsCount,
            pageKey: testPageKey,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.readSavedPosts(
              postsCount: testPostsCount,
              pageKey: testPageKey,
            ),
          );

          expect(
            result,
            Left<Failure, PostsModel>(DatabaseFailure()),
          );
        },
      );
    },
  );

  group(
    'Delete saved post',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.deleteSavedPost(
              postId: anyNamed('postId'),
            ),
          ).thenAnswer(
            (_) async => testPostId,
          );

          // Act
          final result = await repository.deleteSavedPost(
            postId: testPostId,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.deleteSavedPost(
              postId: testPostId,
            ),
          );

          expect(
            result,
            const Right<Failure, int>(testPostId),
          );
        },
      );

      test(
        'Should return database failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.deleteSavedPost(
              postId: anyNamed('postId'),
            ),
          ).thenThrow(
            DatabaseException(),
          );

          // Act
          final result = await repository.deleteSavedPost(
            postId: testPostId,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.deleteSavedPost(
              postId: testPostId,
            ),
          );

          expect(
            result,
            Left<Failure, int>(DatabaseFailure()),
          );
        },
      );
    },
  );

  group(
    'Check post save status',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.checkPostSaveStatus(
              postId: anyNamed('postId'),
            ),
          ).thenAnswer(
            (_) async => testPostSaveStatus,
          );

          // Act
          final result = await repository.checkPostSaveStatus(
            postId: testPostId,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.checkPostSaveStatus(
              postId: testPostId,
            ),
          );

          expect(
            result,
            const Right<Failure, bool>(testPostSaveStatus),
          );
        },
      );

      test(
        'Should return database failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockSavedPostsLocalDataSource.checkPostSaveStatus(
              postId: anyNamed('postId'),
            ),
          ).thenThrow(
            DatabaseException(),
          );

          // Act
          final result = await repository.checkPostSaveStatus(
            postId: testPostId,
          );

          // Assert
          verify(
            mockSavedPostsLocalDataSource.checkPostSaveStatus(
              postId: testPostId,
            ),
          );

          expect(
            result,
            Left<Failure, bool>(DatabaseFailure()),
          );
        },
      );
    },
  );
}
