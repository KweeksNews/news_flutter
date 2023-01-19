import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_post/delete_saved_post.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/saved_posts_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_saved_post_test.mocks.dart';

@GenerateMocks([SavedPostsRepository])
void main() {
  late MockSavedPostsRepository mockSavedPostsRepository;
  late DeleteSavedPost usecase;

  const int testPostId = 1;

  setUp(() {
    mockSavedPostsRepository = MockSavedPostsRepository();
    usecase = DeleteSavedPost(mockSavedPostsRepository);
  });

  test(
    'Should delete saved post using repository',
    () async {
      // Arrange
      when(
        mockSavedPostsRepository.deleteSavedPost(
          postId: anyNamed('postId'),
        ),
      ).thenAnswer(
        (_) async => const Right(testPostId),
      );

      // Act
      final result = await usecase(
        postId: testPostId,
      );

      // Assert
      verify(
        mockSavedPostsRepository.deleteSavedPost(
          postId: testPostId,
        ),
      );

      verifyNoMoreInteractions(
        mockSavedPostsRepository,
      );

      expect(
        result,
        const Right<Failure, int>(testPostId),
      );
    },
  );
}
