import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/entities/post_list.dart';
import 'package:kweeksnews_app/core/domain/enums/content_group_type.dart';
import 'package:kweeksnews_app/core/domain/enums/state_exception_type.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/core/domain/usecases/get_posts.dart';
import 'package:kweeksnews_app/features/home/presentation/notifier/notifier.dart';
import 'package:kweeksnews_app/providers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/posts.dart';
import 'content_group_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<ContentGroupNotifier, HomeState>
      contentGroupProvider;

  const List<String> testInitialIds = ['1'];

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer(
      overrides: [
        contentGroupDropdownProvider.overrideWithProvider(
          (argument) => StateNotifierProvider.autoDispose<
              ContentGroupDropdownNotifier, List<String>>(
            (ref) => ContentGroupDropdownNotifier(argument),
          ),
        ),
      ],
    );
    contentGroupProvider =
        StateNotifierProvider<ContentGroupNotifier, HomeState>(
      (ref) => ContentGroupNotifier(mockGetPosts, testInitialIds, ref),
    );

    addTearDown(container.dispose);
  });

  const int testPostsCount = 1;
  const bool testForceRefresh = false;
  final PostList testPosts = posts;

  group(
    'Content group type is category',
    () {
      const ContentGroupType testContentGroupType = ContentGroupType.category;

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
            container.read(contentGroupProvider),
            const HomeLoading(),
          );

          container.read(contentGroupProvider.notifier).fetchPage(
                contentGroupType: testContentGroupType,
                postsCount: testPostsCount,
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
            container.read(contentGroupProvider),
            HomeLoaded(
              posts: testPosts.posts,
            ),
          );

          verify(
            mockGetPosts(
              categoryIn: testInitialIds,
              categoryNotIn: ['1084'],
              tagIn: null,
              first: testPostsCount,
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
            container.read(contentGroupProvider),
            const HomeLoading(),
          );

          container.read(contentGroupProvider.notifier).fetchPage(
                contentGroupType: testContentGroupType,
                postsCount: testPostsCount,
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
            container.read(contentGroupProvider),
            const HomeException(
              type: StateExceptionType.failedToLoadData,
            ),
          );

          verify(
            mockGetPosts(
              categoryIn: testInitialIds,
              categoryNotIn: ['1084'],
              tagIn: null,
              first: testPostsCount,
              forceRefresh: testForceRefresh,
            ),
          );
        },
      );
    },
  );

  group(
    'Content group type is tag',
    () {
      const ContentGroupType testContentGroupType = ContentGroupType.tag;

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
            container.read(contentGroupProvider),
            const HomeLoading(),
          );

          container.read(contentGroupProvider.notifier).fetchPage(
                contentGroupType: testContentGroupType,
                postsCount: testPostsCount,
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
            container.read(contentGroupProvider),
            HomeLoaded(
              posts: testPosts.posts,
            ),
          );

          verify(
            mockGetPosts(
              categoryIn: null,
              categoryNotIn: ['1084'],
              tagIn: testInitialIds,
              first: testPostsCount,
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
            container.read(contentGroupProvider),
            const HomeLoading(),
          );

          container.read(contentGroupProvider.notifier).fetchPage(
                contentGroupType: testContentGroupType,
                postsCount: testPostsCount,
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
            container.read(contentGroupProvider),
            const HomeException(
              type: StateExceptionType.failedToLoadData,
            ),
          );

          verify(
            mockGetPosts(
              categoryIn: null,
              categoryNotIn: ['1084'],
              tagIn: testInitialIds,
              first: testPostsCount,
              forceRefresh: testForceRefresh,
            ),
          );
        },
      );
    },
  );
}
