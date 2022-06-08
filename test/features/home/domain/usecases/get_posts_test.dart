import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/entities/post_list.dart';
import 'package:kweeksnews_app/core/error/failures.dart';
import 'package:kweeksnews_app/features/home/domain/repositories/home_repository.dart';
import 'package:kweeksnews_app/features/home/domain/usecases/get_posts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/posts.dart';
import 'get_posts_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockHomeRepository;
  late GetPosts usecase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetPosts(mockHomeRepository);
  });

  const int testPostsCount = 1;
  const bool testForceRefresh = false;
  final PostList testPosts = posts;

  test(
    'Should get posts from repository',
    () async {
      when(
        mockHomeRepository.getPosts(
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

      final result = await usecase(
        postsCount: testPostsCount,
        forceRefresh: testForceRefresh,
      );

      expect(
        result,
        Right<Failure, PostList>(testPosts),
      );

      verify(
        mockHomeRepository.getPosts(
          postsCount: testPostsCount,
          forceRefresh: testForceRefresh,
        ),
      );

      verifyNoMoreInteractions(
        mockHomeRepository,
      );
    },
  );
}
