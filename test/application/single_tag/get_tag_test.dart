import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_tag/get_tag.dart';
import 'package:kweeksnews_app/domain/entities/tag.dart';
import 'package:kweeksnews_app/domain/enums/tag_id_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/tag.dart';
import 'get_tag_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetTag usecase;

  const String testId = '1';
  const TagIdType testIdType = TagIdType.id;
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
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testTag),
      );

      // Act
      final result = await usecase(
        id: testId,
        idType: testIdType,
        forceRefresh: testForceRefresh,
      );

      // Assert
      verify(
        mockWpRepository.getTag(
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
        const Right<Failure, Tag>(testTag),
      );
    },
  );
}
