import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/single_tag/get_tag.dart';
import 'package:news/domain/entities/tag.dart';
import 'package:news/domain/entities/tag_id.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/domain/repositories/shared/wp_repository.dart';

import '../../fixtures/tag.dart';
import 'get_tag_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetTag usecase;

  final TagId testId = TagId.id('1');
  const bool testForceRefresh = false;
  const Tag testTag = tag;

  setUp(() {
    mockWpRepository = MockWpRepository();
    usecase = GetTag(mockWpRepository);
  });

  test(
    'Should get tag from repository',
    () async {
      // Arrange
      when(
        mockWpRepository.getTag(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testTag),
      );

      // Act
      final result = await usecase(
        id: testId,
        forceRefresh: testForceRefresh,
      );

      // Assert
      verify(
        mockWpRepository.getTag(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      verifyNoMoreInteractions(
        mockWpRepository,
      );

      expect(
        result,
        const Right<Failure, Tag>(testTag),
      );
    },
  );
}
