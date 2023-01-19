import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_post/add_saved_post.dart';
import 'package:kweeksnews_app/domain/entities/post.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/saved_posts_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/post.dart';
import 'add_saved_post_test.mocks.dart';

@GenerateMocks([SavedPostsRepository])
void main() {
  late MockSavedPostsRepository mockSavedPostsRepository;
  late AddSavedPost usecase;

  final Post testPost = post;
  const int testPostId = 1;

  setUp(() {
    mockSavedPostsRepository = MockSavedPostsRepository();
    usecase = AddSavedPost(mockSavedPostsRepository);
  });

  test(
    'Should add saved post using repository',
    () async {
      // Arrange
      when(
        mockSavedPostsRepository.addSavedPost(
          post: anyNamed('post'),
        ),
      ).thenAnswer(
        (_) async => const Right(testPostId),
      );

      // Act
      final result = await usecase(
        post: testPost,
      );

      // Assert
      verify(
        mockSavedPostsRepository.addSavedPost(
          post: testPost,
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
