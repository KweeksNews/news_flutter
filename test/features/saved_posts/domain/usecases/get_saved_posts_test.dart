import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/entities/posts.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/saved_posts/domain/repositories/saved_posts_repository.dart';
import 'package:kweeksnews_app/features/saved_posts/domain/usecases/get_saved_posts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/posts.dart';
import 'get_saved_posts_test.mocks.dart';

@GenerateMocks([SavedPostsRepository])
void main() {
  late MockSavedPostsRepository mockSavedPostsRepository;
  late GetSavedPosts usecase;

  setUp(() {
    mockSavedPostsRepository = MockSavedPostsRepository();
    usecase = GetSavedPosts(mockSavedPostsRepository);
  });

  const int testPostsCount = 10;
  const int testPageKey = 1;
  final Posts testPosts = posts;

  test(
    'Should get posts from repository',
    () async {
      when(
        mockSavedPostsRepository.getSavedPosts(
          postsCount: anyNamed('postsCount'),
          pageKey: anyNamed('pageKey'),
        ),
      ).thenAnswer(
        (_) async => Right(testPosts),
      );

      final result = await usecase(
        postsCount: testPostsCount,
        pageKey: testPageKey,
      );

      expect(
        result,
        Right<Failure, Posts>(testPosts),
      );

      verify(
        mockSavedPostsRepository.getSavedPosts(
          postsCount: testPostsCount,
          pageKey: testPageKey,
        ),
      );

      verifyNoMoreInteractions(
        mockSavedPostsRepository,
      );
    },
  );
}
