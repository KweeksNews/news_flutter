import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/shared/get_posts.dart';
import 'package:kweeksnews_app/domain/entities/posts.dart';
import 'package:kweeksnews_app/domain/enums/content_group_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/home/notifier.dart';
import 'package:kweeksnews_app/providers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'content_group_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<ContentGroupNotifier, ContentGroupState>
      contentGroupProvider;

  const List<String> testInitialIds = ['1'];
  const int testPostsCount = 1;
  const bool testForceRefresh = false;
  final Posts testPosts = posts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer(
      overrides: [
        contentGroupDropdownProvider.overrideWith(
          (ref, argument) => ContentGroupDropdownNotifier(argument),
        ),
      ],
    );
    contentGroupProvider =
        StateNotifierProvider<ContentGroupNotifier, ContentGroupState>(
      (ref) => ContentGroupNotifier(mockGetPosts, testInitialIds, ref),
    );

    addTearDown(container.dispose);
  });

  group(
    'Content group type is category',
    () {
      const ContentGroupType testContentGroupType = ContentGroupType.category;

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
            container.read(contentGroupProvider),
            const ContentGroupState.loading(),
          );

          // Act
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

          // Assert
          verify(
            mockGetPosts(
              categoryIn: testInitialIds,
              categoryNotIn: ['1084'],
              tagIn: null,
              first: testPostsCount,
              forceRefresh: testForceRefresh,
            ),
          );

          expect(
            container.read(contentGroupProvider),
            ContentGroupState.loaded(
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
            container.read(contentGroupProvider),
            const ContentGroupState.loading(),
          );

          // Act
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

          // Assert
          verify(
            mockGetPosts(
              categoryIn: testInitialIds,
              categoryNotIn: ['1084'],
              tagIn: null,
              first: testPostsCount,
              forceRefresh: testForceRefresh,
            ),
          );

          expect(
            container.read(contentGroupProvider),
            const ContentGroupState.failedToLoadData(),
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
            container.read(contentGroupProvider),
            const ContentGroupState.loading(),
          );

          // Act
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

          // Assert
          verify(
            mockGetPosts(
              categoryIn: null,
              categoryNotIn: ['1084'],
              tagIn: testInitialIds,
              first: testPostsCount,
              forceRefresh: testForceRefresh,
            ),
          );

          expect(
            container.read(contentGroupProvider),
            ContentGroupState.loaded(
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
            container.read(contentGroupProvider),
            const ContentGroupState.loading(),
          );

          // Act
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

          // Assert
          verify(
            mockGetPosts(
              categoryIn: null,
              categoryNotIn: ['1084'],
              tagIn: testInitialIds,
              first: testPostsCount,
              forceRefresh: testForceRefresh,
            ),
          );

          expect(
            container.read(contentGroupProvider),
            const ContentGroupState.failedToLoadData(),
          );
        },
      );
    },
  );
}