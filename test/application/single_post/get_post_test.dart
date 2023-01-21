import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_post/get_post.dart';
import 'package:kweeksnews_app/domain/entities/post.dart';
import 'package:kweeksnews_app/domain/enums/post_id_type.dart';
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

  const String testId = '1';
  const PostIdType testIdType = PostIdType.id;
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
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Right(testPost),
      );

      // Act
      final result = await usecase(
        id: testId,
        idType: testIdType,
        forceRefresh: testForceRefresh,
      );

      // Assert
      verify(
        mockWpRepository.getPost(
          id: testId,
          idType: testIdType,
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