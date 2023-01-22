import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/shared/get_posts.dart';
import 'package:news/domain/entities/posts.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/presentation/viewmodels/single_tag/notifier.dart';

import '../../../fixtures/posts.dart';
import 'tag_posts_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<TagPostsNotifier, TagPostsState> tagPostsProvider;

  const List<String> testTag = ['1'];
  const int testPostsCount = 10;
  const String testPageKey = 'first';
  const bool testForceRefresh = false;
  final Posts testPosts = posts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer();
    tagPostsProvider = StateNotifierProvider<TagPostsNotifier, TagPostsState>(
      (ref) => TagPostsNotifier(mockGetPosts),
    );

    addTearDown(container.dispose);
  });

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
        container.read(tagPostsProvider),
        const TagPostsState.loading(),
      );

      // Act
      container.read(tagPostsProvider.notifier).fetchPage(
            tagIn: testTag,
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
          tagIn: testTag,
          first: testPostsCount,
          after: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(tagPostsProvider),
        TagPostsState.appendLastPage(
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
        container.read(tagPostsProvider),
        const TagPostsState.loading(),
      );

      // Act
      container.read(tagPostsProvider.notifier).fetchPage(
            tagIn: testTag,
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
          tagIn: testTag,
          first: testPostsCount,
          after: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(tagPostsProvider),
        const TagPostsState.failedToLoadData(),
      );
    },
  );
}
