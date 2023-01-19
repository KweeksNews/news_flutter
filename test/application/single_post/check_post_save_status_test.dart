import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_post/check_post_save_status.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/saved_posts_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_post_save_status_test.mocks.dart';

@GenerateMocks([SavedPostsRepository])
void main() {
  late MockSavedPostsRepository mockSavedPostsRepository;
  late CheckPostSaveStatus usecase;

  const int testPostId = 1;
  const bool testPostSaveStatus = true;

  setUp(() {
    mockSavedPostsRepository = MockSavedPostsRepository();
    usecase = CheckPostSaveStatus(mockSavedPostsRepository);
  });

  test(
    'Should check post save status using repository',
    () async {
      // Arrange
      when(
        mockSavedPostsRepository.checkPostSaveStatus(
          postId: anyNamed('postId'),
        ),
      ).thenAnswer(
        (_) async => const Right(testPostSaveStatus),
      );

      // Act
      final result = await usecase(
        postId: testPostId,
      );

      // Assert
      verify(
        mockSavedPostsRepository.checkPostSaveStatus(
          postId: testPostId,
        ),
      );

      verifyNoMoreInteractions(
        mockSavedPostsRepository,
      );

      expect(
        result,
        const Right<Failure, bool>(testPostSaveStatus),
      );
    },
  );
}
