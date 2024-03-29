import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/saved_posts/get_saved_posts.dart';
import 'package:news/domain/entities/posts.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/presentation/viewmodels/saved_posts/notifier.dart';

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
            const SavedPostsState.loading(),
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
            SavedPostsState.appendPage(
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
            const SavedPostsState.loading(),
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
            const SavedPostsState.failedToLoadData(),
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
            const SavedPostsState.loading(),
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
            SavedPostsState.appendLastPage(
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
            const SavedPostsState.loading(),
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
            const SavedPostsState.failedToLoadData(),
          );
        },
      );
    },
  );
}
