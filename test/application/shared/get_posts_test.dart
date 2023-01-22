import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/shared/get_posts.dart';
import 'package:news/domain/entities/posts.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/domain/repositories/shared/wp_repository.dart';

import '../../fixtures/posts.dart';
import 'get_posts_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetPosts usecase;

  const String testSearchTerm = 'test';
  const int testPostsCount = 1;
  const String testPageKey = 'test';
  const bool testForceRefresh = false;
  final Posts testPosts = posts;

  setUp(() {
    mockWpRepository = MockWpRepository();
    usecase = GetPosts(mockWpRepository);
  });

  test(
    'Should get posts from repository',
    () async {
      // Arrange
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

      // Act
      final result = await usecase(
        search: testSearchTerm,
        first: testPostsCount,
        after: testPageKey,
        forceRefresh: testForceRefresh,
      );

      // Assert
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

      expect(
        result,
        Right<Failure, Posts>(testPosts),
      );
    },
  );
}
