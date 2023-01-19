import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/shared/get_posts.dart';
import 'package:kweeksnews_app/domain/entities/posts.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_user/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'user_posts_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late ProviderContainer container;
  late StateNotifierProvider<UserPostsNotifier, UserPostsState>
      userPostsProvider;

  const List<String> testUser = ['1'];
  const int testPostsCount = 10;
  const String testPageKey = 'first';
  const bool testForceRefresh = false;
  final Posts testPosts = posts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer();
    userPostsProvider =
        StateNotifierProvider<UserPostsNotifier, UserPostsState>(
      (ref) => UserPostsNotifier(mockGetPosts),
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
        container.read(userPostsProvider),
        const UserPostsState.loading(),
      );

      // Act
      container.read(userPostsProvider.notifier).fetchPage(
            authorIn: testUser,
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
          authorIn: testUser,
          first: testPostsCount,
          after: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(userPostsProvider),
        UserPostsState.appendLastPage(
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
        container.read(userPostsProvider),
        const UserPostsState.loading(),
      );

      // Act
      container.read(userPostsProvider.notifier).fetchPage(
            authorIn: testUser,
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
          authorIn: testUser,
          first: testPostsCount,
          after: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(userPostsProvider),
        const UserPostsState.failedToLoadData(),
      );
    },
  );
}
