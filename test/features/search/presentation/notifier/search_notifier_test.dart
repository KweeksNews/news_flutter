import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/entities/post_list.dart';
import 'package:kweeksnews_app/core/domain/enums/state_exception_type.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/core/domain/usecases/get_posts.dart';
import 'package:kweeksnews_app/features/search/presentation/notifier/notifier.dart';
import 'package:kweeksnews_app/providers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/posts.dart';
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
        searchTermProvider.overrideWithProvider(
          StateNotifierProvider.autoDispose<SearchTermNotifier, String>(
            (ref) => SearchTermNotifier(),
          ),
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
        'Post list has next page',
        () {
          final PostList testPosts = postsHasNextPage;

          test(
            'Should get data from the use case and return PostList on success',
            () async {
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
                const SearchLoading(),
              );

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

              expect(
                container.read(searchProvider),
                SearchAppend(
                  posts: testPosts.posts,
                  nextPageKey: testPosts.endCursor!,
                ),
              );

              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );
            },
          );

          test(
            'Should get data from the use case and return error on failure',
            () async {
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
                const SearchLoading(),
              );

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

              expect(
                container.read(searchProvider),
                const SearchException(
                  type: StateExceptionType.failedToLoadData,
                ),
              );

              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );
            },
          );
        },
      );

      group(
        'Post list is last page',
        () {
          final PostList testPosts = posts;

          test(
            'Should get data from the use case and return PostList on success',
            () async {
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
                const SearchLoading(),
              );

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

              expect(
                container.read(searchProvider),
                SearchAppendLast(
                  posts: testPosts.posts,
                ),
              );

              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );
            },
          );

          test(
            'Should get data from the use case and return error on failure',
            () async {
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
                const SearchLoading(),
              );

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

              expect(
                container.read(searchProvider),
                const SearchException(
                  type: StateExceptionType.failedToLoadData,
                ),
              );

              verify(
                mockGetPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
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
          expect(
            container.read(searchProvider),
            const SearchLoading(),
          );

          container.read(searchProvider.notifier).fetchPage(
                postsCount: testPostsCount,
                pageKey: testPageKey,
                forceRefresh: testForceRefresh,
              );

          expect(
            container.read(searchProvider),
            const SearchException(
              type: StateExceptionType.noSearchTerm,
            ),
          );
        },
      );
    },
  );
}
