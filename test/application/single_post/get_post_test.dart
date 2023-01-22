import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_post/get_post.dart';
import 'package:kweeksnews_app/domain/entities/post.dart';
import 'package:kweeksnews_app/domain/entities/post_id.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/post.dart';
import 'get_post_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetPost usecase;

  final PostId testId = PostId.id('1');
  const bool testForceRefresh = false;
  final Post testPost = post;

  setUp(() {
    mockWpRepository = MockWpRepository();
    usecase = GetPost(mockWpRepository);
  });

  test(
    'Should get post from repository',
    () async {
      // Arrange
      when(
        mockWpRepository.getPost(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Right(testPost),
      );

      // Act
      final result = await usecase(
        id: testId,
        forceRefresh: testForceRefresh,
      );

      // Assert
      verify(
        mockWpRepository.getPost(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      verifyNoMoreInteractions(
        mockWpRepository,
      );

      expect(
        result,
        Right<Failure, Post>(testPost),
      );
    },
  );
}
