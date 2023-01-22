import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/single_category/get_category.dart';
import 'package:news/domain/entities/category.dart';
import 'package:news/domain/entities/category_id.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/domain/repositories/shared/wp_repository.dart';

import '../../fixtures/category.dart';
import 'get_category_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetCategory usecase;

  final CategoryId testId = CategoryId.id('1');
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
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testCategory),
      );

      // Act
      final result = await usecase(
        id: testId,
        forceRefresh: testForceRefresh,
      );

      // Assert
      verify(
        mockWpRepository.getCategory(
          id: testId,
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
