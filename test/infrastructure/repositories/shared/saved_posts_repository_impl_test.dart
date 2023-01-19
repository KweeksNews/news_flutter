import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/domain/error/exceptions.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/infrastructure/datasources/shared/saved_posts_local_data_source.dart';
import 'package:kweeksnews_app/infrastructure/dtos/posts_model.dart';
import 'package:kweeksnews_app/infrastructure/repositories/shared/saved_posts_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'saved_posts_repository_impl_test.mocks.dart';

@GenerateMocks([SavedPostsLocalDataSource])
void main() {
  late MockSavedPostsLocalDataSource mockSavedPostsLocalDataSource;
  late SavedPostsRepositoryImpl repository;

  const int testPostsCount = 10;
  const int testPageKey = 1;
  final PostsModel testPostsModel = postsModel;

  setUp(
    () {
      mockSavedPostsLocalDataSource = MockSavedPostsLocalDataSource();
      repository = SavedPostsRepositoryImpl(mockSavedPostsLocalDataSource);
    },
  );

  group(
    'Get saved posts',
    () {
      test(
        'Should return data when the call to remote data source is successful',
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
        'Should return database failure when the call to remote data source is unsuccessful',
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
}
