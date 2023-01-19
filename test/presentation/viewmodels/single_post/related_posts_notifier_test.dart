import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/shared/get_posts.dart';
import 'package:kweeksnews_app/domain/entities/posts.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_post/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'related_posts_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<RelatedPostsNotifier, RelatedPostsState>
      relatedPostsProvider;

  const String testPostId = '1';
  const List<String> testTagsId = ['1'];
  const int testPostsCount = 3;
  const bool testForceRefresh = true;
  final Posts testPosts = posts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer();
    relatedPostsProvider =
        StateNotifierProvider<RelatedPostsNotifier, RelatedPostsState>(
      (ref) => RelatedPostsNotifier(mockGetPosts),
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
        container.read(relatedPostsProvider),
        const RelatedPostsState.loading(),
      );

      // Act
      container.read(relatedPostsProvider.notifier).fetchPosts(
            postId: testPostId,
            tagsId: testTagsId,
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
          notIn: [testPostId],
          tagIn: testTagsId,
          first: testPostsCount,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(relatedPostsProvider),
        RelatedPostsState.loaded(
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
        container.read(relatedPostsProvider),
        const RelatedPostsState.loading(),
      );

      // Act
      container.read(relatedPostsProvider.notifier).fetchPosts(
            postId: testPostId,
            tagsId: testTagsId,
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
          notIn: [testPostId],
          tagIn: testTagsId,
          first: testPostsCount,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(relatedPostsProvider),
        const RelatedPostsState.failedToLoadData(),
      );
    },
  );
}
