import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/saved_posts/get_saved_posts.dart';
import 'package:kweeksnews_app/domain/entities/posts.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/saved_posts_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/posts.dart';
import 'get_saved_posts_test.mocks.dart';

@GenerateMocks([SavedPostsRepository])
void main() {
  late MockSavedPostsRepository mockSavedPostsRepository;
  late GetSavedPosts usecase;

  const int testPostsCount = 10;
  const int testPageKey = 1;
  final Posts testPosts = posts;

  setUp(() {
    mockSavedPostsRepository = MockSavedPostsRepository();
    usecase = GetSavedPosts(mockSavedPostsRepository);
  });

  test(
    'Should get saved posts from repository',
    () async {
      // Arrange
      when(
        mockSavedPostsRepository.getSavedPosts(
          postsCount: anyNamed('postsCount'),
          pageKey: anyNamed('pageKey'),
        ),
      ).thenAnswer(
        (_) async => Right(testPosts),
      );

      // Act
      final result = await usecase(
        postsCount: testPostsCount,
        pageKey: testPageKey,
      );

      // Assert
      verify(
        mockSavedPostsRepository.getSavedPosts(
          postsCount: testPostsCount,
          pageKey: testPageKey,
        ),
      );

      verifyNoMoreInteractions(
        mockSavedPostsRepository,
      );

      expect(
        result,
        Right<Failure, Posts>(testPosts),
      );
    },
  );
}
