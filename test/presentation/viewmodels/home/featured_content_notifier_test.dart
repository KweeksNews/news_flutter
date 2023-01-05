import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/shared/get_posts.dart';
import 'package:kweeksnews_app/domain/entities/posts.dart';
import 'package:kweeksnews_app/domain/enums/state_exception_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/home/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'featured_content_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<FeaturedContentNotifier, HomeState>
      featuredContentProvider;

  const int testPostsCount = 1;
  const bool testForceRefresh = false;
  final Posts testPosts = posts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer();
    featuredContentProvider =
        StateNotifierProvider<FeaturedContentNotifier, HomeState>(
      (ref) => FeaturedContentNotifier(mockGetPosts),
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
        container.read(featuredContentProvider),
        const HomeLoading(),
      );

      // Act
      container.read(featuredContentProvider.notifier).fetchPage(
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
          categoryNotIn: ['1084'],
          first: testPostsCount,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(featuredContentProvider),
        HomeLoaded(
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
        container.read(featuredContentProvider),
        const HomeLoading(),
      );

      // Act
      container.read(featuredContentProvider.notifier).fetchPage(
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
          categoryNotIn: ['1084'],
          first: testPostsCount,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(featuredContentProvider),
        const HomeException(
          type: StateExceptionType.failedToLoadData,
        ),
      );
    },
  );
}
