import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/entities/post_list.dart';
import 'package:kweeksnews_app/core/domain/enums/state_exception_type.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/home/domain/usecases/get_posts.dart';
import 'package:kweeksnews_app/features/home/presentation/notifier/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/posts.dart';
import 'featured_content_notifier_test.mocks.dart';

@GenerateMocks([GetPosts])
void main() {
  late MockGetPosts mockGetPosts;
  late FeaturedContentNotifier featuredContentNotifier;
  late StateNotifierProvider<FeaturedContentNotifier, HomeState>
      featuredContentProvider;

  setUp(() {
    mockGetPosts = MockGetPosts();
    featuredContentNotifier = FeaturedContentNotifier(mockGetPosts);
    featuredContentProvider =
        StateNotifierProvider<FeaturedContentNotifier, HomeState>(
      (ref) => featuredContentNotifier,
    );
  });

  const int testPostsCount = 1;
  const bool testForceRefresh = false;
  final PostList testPosts = posts;

  test(
    'Should get data from the use case and return PostList on success',
    () async {
      final container = ProviderContainer();

      addTearDown(container.dispose);

      when(
        mockGetPosts(
          categoryIn: anyNamed('categoryIn'),
          categoryNotIn: anyNamed('categoryNotIn'),
          tagIn: anyNamed('tagIn'),
          tagNotIn: anyNamed('tagNotIn'),
          postsCount: anyNamed('postsCount'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Right(testPosts),
      );

      expect(
        container.read(featuredContentProvider),
        const HomeLoading(),
      );

      container.read(featuredContentProvider.notifier).fetchPage(
            postsCount: testPostsCount,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetPosts(
          categoryIn: anyNamed('categoryIn'),
          categoryNotIn: anyNamed('categoryNotIn'),
          tagIn: anyNamed('tagIn'),
          tagNotIn: anyNamed('tagNotIn'),
          postsCount: anyNamed('postsCount'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      expect(
        container.read(featuredContentProvider),
        HomeLoaded(
          posts: testPosts.posts,
        ),
      );

      verify(
        mockGetPosts(
          categoryNotIn: ['1084'],
          postsCount: testPostsCount,
          forceRefresh: testForceRefresh,
        ),
      );
    },
  );

  test(
    'Should get data from the use case and return error on failure',
    () async {
      final container = ProviderContainer();

      addTearDown(container.dispose);

      when(
        mockGetPosts(
          categoryIn: anyNamed('categoryIn'),
          categoryNotIn: anyNamed('categoryNotIn'),
          tagIn: anyNamed('tagIn'),
          tagNotIn: anyNamed('tagNotIn'),
          postsCount: anyNamed('postsCount'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Left(RequestFailure()),
      );

      expect(
        container.read(featuredContentProvider),
        const HomeLoading(),
      );

      container.read(featuredContentProvider.notifier).fetchPage(
            postsCount: testPostsCount,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetPosts(
          categoryIn: anyNamed('categoryIn'),
          categoryNotIn: anyNamed('categoryNotIn'),
          tagIn: anyNamed('tagIn'),
          tagNotIn: anyNamed('tagNotIn'),
          postsCount: anyNamed('postsCount'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      expect(
        container.read(featuredContentProvider),
        const HomeException(
          type: StateExceptionType.failedToLoadData,
        ),
      );

      verify(
        mockGetPosts(
          categoryNotIn: ['1084'],
          postsCount: testPostsCount,
          forceRefresh: testForceRefresh,
        ),
      );
    },
  );
}
