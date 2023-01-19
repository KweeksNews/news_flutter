import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_category/get_category.dart';
import 'package:kweeksnews_app/domain/entities/category.dart';
import 'package:kweeksnews_app/domain/enums/category_id_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/category.dart';
import 'get_category_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetCategory usecase;

  const String testId = '1';
  const CategoryIdType testIdType = CategoryIdType.id;
  const bool testForceRefresh = false;
  const Category testCategory = category;

  setUp(() {
    mockWpRepository = MockWpRepository();
    usecase = GetCategory(mockWpRepository);
  });

  test(
    'Should get category from repository',
    () async {
      // Arrange
      when(
        mockWpRepository.getCategory(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testCategory),
      );

      // Act
      final result = await usecase(
        id: testId,
        idType: testIdType,
        forceRefresh: testForceRefresh,
      );

      // Assert
      verify(
        mockWpRepository.getCategory(
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
        const Right<Failure, Category>(testCategory),
      );
    },
  );
}
