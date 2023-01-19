import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/shared/get_posts.dart';
import 'package:kweeksnews_app/domain/entities/posts.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_category/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'category_posts_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<CategoryPostsNotifier, CategoryPostsState>
      categoryPostsProvider;

  const List<String> testCategory = ['1'];
  const int testPostsCount = 10;
  const String testPageKey = 'first';
  const bool testForceRefresh = false;
  final Posts testPosts = posts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer();
    categoryPostsProvider =
        StateNotifierProvider<CategoryPostsNotifier, CategoryPostsState>(
      (ref) => CategoryPostsNotifier(mockGetPosts),
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
        container.read(categoryPostsProvider),
        const CategoryPostsState.loading(),
      );

      // Act
      container.read(categoryPostsProvider.notifier).fetchPage(
            categoryIn: testCategory,
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
          categoryIn: testCategory,
          first: testPostsCount,
          after: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(categoryPostsProvider),
        CategoryPostsState.appendLastPage(
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
        container.read(categoryPostsProvider),
        const CategoryPostsState.loading(),
      );

      // Act
      container.read(categoryPostsProvider.notifier).fetchPage(
            categoryIn: testCategory,
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
          categoryIn: testCategory,
          first: testPostsCount,
          after: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(categoryPostsProvider),
        const CategoryPostsState.failedToLoadData(),
      );
    },
  );
}
