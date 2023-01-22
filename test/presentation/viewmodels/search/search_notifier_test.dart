import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/shared/get_posts.dart';
import 'package:news/domain/entities/posts.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/presentation/viewmodels/search/notifier.dart';
import 'package:news/providers.dart';

import '../../../fixtures/posts.dart';
import 'search_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<SearchNotifier, SearchState> searchProvider;

  const int testPostsCount = 10;
  const String testPageKey = 'first';
  const bool testForceRefresh = false;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer(
      overrides: [
        searchTermProvider.overrideWith(
          (ref) => SearchTermNotifier(),
        ),
      ],
    );
    searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
      (ref) => SearchNotifier(mockGetPosts, ref),
    );

    addTearDown(container.dispose);
  });

  group(
    'Search term is not empty',
    () {
      const String testSearchTerm = 'search term';

      setUp(() {
        container.read(searchTermProvider.notifier).setSearchTerm(
              searchTerm: testSearchTerm,
            );
      });

      group(
        'Posts has next page',
        () {
          final Posts testPosts = postsHasNextPage;

          test(
            'Should get data from the use case and return Posts on success',
            () async {
              // Arrange
              when(
                mockGetPosts(
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
                (_) async => Right(testPosts),
              );

              expect(
                container.read(searchProvider),
                const SearchState.loading(),
              );

              // Act
              container.read(searchProvider.notifier).fetchPage(
                    postsCount: testPostsCount,
                    pageKey: testPageKey,
                    forceRefresh: testForceRefresh,
                  );

              await untilCalled(
                mockGetPosts(
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
              );

              // Assert
              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                container.read(searchProvider),
                SearchState.appendPage(
                  posts: testPosts.posts,
                  nextPageKey: testPosts.endCursor!,
                ),
              );
            },
          );

          test(
            'Should get data from the use case and return error on failure',
            () async {
              // Arrange
              when(
                mockGetPosts(
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
                (_) async => Left(RequestFailure()),
              );

              expect(
                container.read(searchProvider),
                const SearchState.loading(),
              );

              // Act
              container.read(searchProvider.notifier).fetchPage(
                    postsCount: testPostsCount,
                    pageKey: testPageKey,
                    forceRefresh: testForceRefresh,
                  );

              await untilCalled(
                mockGetPosts(
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
              );

              // Assert
              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                container.read(searchProvider),
                const SearchState.failedToLoadData(),
              );
            },
          );
        },
      );

      group(
        'Posts is last page',
        () {
          final Posts testPosts = posts;

          test(
            'Should get data from the use case and return Posts on success',
            () async {
              // Arrange
              when(
                mockGetPosts(
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
                (_) async => Right(testPosts),
              );

              expect(
                container.read(searchProvider),
                const SearchState.loading(),
              );

              // Act
              container.read(searchProvider.notifier).fetchPage(
                    postsCount: testPostsCount,
                    pageKey: testPageKey,
                    forceRefresh: testForceRefresh,
                  );

              await untilCalled(
                mockGetPosts(
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
              );

              // Assert
              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                container.read(searchProvider),
                SearchState.appendLastPage(
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
                mockGetPosts(
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
                (_) async => Left(RequestFailure()),
              );

              expect(
                container.read(searchProvider),
                const SearchState.loading(),
              );

              // Act
              container.read(searchProvider.notifier).fetchPage(
                    postsCount: testPostsCount,
                    pageKey: testPageKey,
                    forceRefresh: testForceRefresh,
                  );

              await untilCalled(
                mockGetPosts(
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
              );

              // Assert
              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                container.read(searchProvider),
                const SearchState.failedToLoadData(),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Search term is empty',
    () {
      test(
        'Should return error on empty search term',
        () async {
          // Arrange
          expect(
            container.read(searchProvider),
            const SearchState.loading(),
          );

          // Act
          container.read(searchProvider.notifier).fetchPage(
                postsCount: testPostsCount,
                pageKey: testPageKey,
                forceRefresh: testForceRefresh,
              );

          // Assert
          expect(
            container.read(searchProvider),
            const SearchState.noSearchTerm(),
          );
        },
      );
    },
  );
}
