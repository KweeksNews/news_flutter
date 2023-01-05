import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/saved_posts/get_saved_posts.dart';
import 'package:kweeksnews_app/domain/entities/posts.dart';
import 'package:kweeksnews_app/domain/enums/state_exception_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/saved_posts/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'saved_posts_notifier_test.mocks.dart';

@GenerateMocks([GetSavedPosts])
void main() {
  late MockGetSavedPosts mockGetSavedPosts;
  late ProviderContainer container;
  late StateNotifierProvider<SavedPostsNotifier, SavedPostsState>
      savedPostsProvider;

  const int testPostsCount = 10;
  final Posts testPosts = postsWithTotal;

  setUp(() {
    mockGetSavedPosts = MockGetSavedPosts();
    container = ProviderContainer();
    savedPostsProvider =
        StateNotifierProvider<SavedPostsNotifier, SavedPostsState>(
      (ref) => SavedPostsNotifier(mockGetSavedPosts),
    );

    addTearDown(container.dispose);
  });

  group(
    'Posts has next page',
    () {
      const int testPageKey = 1;
      const int testFetched = 0;

      test(
        'Should get data from the use case and return Posts on success',
        () async {
          // Arrange
          when(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          ).thenAnswer(
            (_) async => Right(testPosts),
          );

          expect(
            container.read(savedPostsProvider),
            const SavedPostsLoading(),
          );

          // Act
          container.read(savedPostsProvider.notifier).fetchPage(
                postsCount: testPostsCount,
                pageKey: testPageKey,
                fetched: testFetched,
              );

          await untilCalled(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          );

          // Assert
          verify(
            mockGetSavedPosts(
              postsCount: testPostsCount,
              pageKey: testPageKey,
            ),
          );

          expect(
            container.read(savedPostsProvider),
            SavedPostsAppend(
              posts: testPosts.posts,
              nextPageKey: testPageKey + 1,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return error on failure',
        () async {
          // Arrange
          when(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          ).thenAnswer(
            (_) async => Left(DatabaseFailure()),
          );

          expect(
            container.read(savedPostsProvider),
            const SavedPostsLoading(),
          );

          // Act
          container.read(savedPostsProvider.notifier).fetchPage(
                postsCount: testPostsCount,
                pageKey: testPageKey,
                fetched: testFetched,
              );

          await untilCalled(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          );

          // Assert
          verify(
            mockGetSavedPosts(
              postsCount: testPostsCount,
              pageKey: testPageKey,
            ),
          );

          expect(
            container.read(savedPostsProvider),
            const SavedPostsException(
              type: StateExceptionType.failedToLoadData,
            ),
          );
        },
      );
    },
  );

  group(
    'Posts is last page',
    () {
      const int testPageKey = 2;
      const int testFetched = 10;

      test(
        'Should get data from the use case and return Posts on success',
        () async {
          // Arrange
          when(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          ).thenAnswer(
            (_) async => Right(testPosts),
          );

          expect(
            container.read(savedPostsProvider),
            const SavedPostsLoading(),
          );

          // Act
          container.read(savedPostsProvider.notifier).fetchPage(
                postsCount: testPostsCount,
                pageKey: testPageKey,
                fetched: testFetched,
              );

          await untilCalled(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          );

          // Assert
          verify(
            mockGetSavedPosts(
              postsCount: testPostsCount,
              pageKey: testPageKey,
            ),
          );

          expect(
            container.read(savedPostsProvider),
            SavedPostsAppendLast(
              posts: testPosts.posts,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return error on failure',
        () async {
          // Arrange
          when(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          ).thenAnswer(
            (_) async => Left(DatabaseFailure()),
          );

          expect(
            container.read(savedPostsProvider),
            const SavedPostsLoading(),
          );

          // Act
          container.read(savedPostsProvider.notifier).fetchPage(
                postsCount: testPostsCount,
                pageKey: testPageKey,
                fetched: testFetched,
              );

          await untilCalled(
            mockGetSavedPosts(
              postsCount: anyNamed('postsCount'),
              pageKey: anyNamed('pageKey'),
            ),
          );

          // Assert
          verify(
            mockGetSavedPosts(
              postsCount: testPostsCount,
              pageKey: testPageKey,
            ),
          );

          expect(
            container.read(savedPostsProvider),
            const SavedPostsException(
              type: StateExceptionType.failedToLoadData,
            ),
          );
        },
      );
    },
  );
}
