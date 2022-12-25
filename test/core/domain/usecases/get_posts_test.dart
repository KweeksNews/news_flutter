import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/entities/posts.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/core/domain/repositories/wp_repository.dart';
import 'package:kweeksnews_app/core/domain/usecases/get_posts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'get_posts_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetPosts usecase;

  setUp(() {
    mockWpRepository = MockWpRepository();
    usecase = GetPosts(mockWpRepository);
  });

  const String testSearchTerm = 'test';
  const int testPostsCount = 1;
  const String testPageKey = 'test';
  const bool testForceRefresh = false;
  final Posts testPosts = posts;

  test(
    'Should get posts from repository',
    () async {
      when(
        mockWpRepository.getPosts(
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

      final result = await usecase(
        search: testSearchTerm,
        first: testPostsCount,
        after: testPageKey,
        forceRefresh: testForceRefresh,
      );

      expect(
        result,
        Right<Failure, Posts>(testPosts),
      );

      verify(
        mockWpRepository.getPosts(
          search: testSearchTerm,
          first: testPostsCount,
          after: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      verifyNoMoreInteractions(
        mockWpRepository,
      );
    },
  );
}
