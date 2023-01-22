import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/single_category/get_category.dart';
import 'package:news/domain/entities/category.dart';
import 'package:news/domain/entities/category_id.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/presentation/viewmodels/single_category/notifier.dart';

import '../../../fixtures/category.dart';
import 'single_category_notifier_test.mocks.dart';

@GenerateMocks([GetCategory])
void main() {
  late MockGetCategory mockGetCategory;
  late ProviderContainer container;
  late StateNotifierProvider<SingleCategoryNotifier, SingleCategoryState>
      singleCategoryProvider;

  final CategoryId testId = CategoryId.id('1');
  const bool testForceRefresh = false;
  const Category testCategory = category;

  setUp(() {
    mockGetCategory = MockGetCategory();
    container = ProviderContainer();
    singleCategoryProvider =
        StateNotifierProvider<SingleCategoryNotifier, SingleCategoryState>(
      (ref) => SingleCategoryNotifier(mockGetCategory),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should get data from the use case and return Category on success',
    () async {
      // Arrange
      when(
        mockGetCategory(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testCategory),
      );

      expect(
        container.read(singleCategoryProvider),
        const SingleCategoryState.loading(),
      );

      // Act
      container.read(singleCategoryProvider.notifier).fetchCategory(
            id: testId,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetCategory(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetCategory(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singleCategoryProvider),
        const SingleCategoryState.loaded(
          category: category,
        ),
      );
    },
  );

  test(
    'Should get data from the use case and return error on failure',
    () async {
      // Arrange
      when(
        mockGetCategory(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Left(RequestFailure()),
      );

      expect(
        container.read(singleCategoryProvider),
        const SingleCategoryState.loading(),
      );

      // Act
      container.read(singleCategoryProvider.notifier).fetchCategory(
            id: testId,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetCategory(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetCategory(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singleCategoryProvider),
        const SingleCategoryState.failedToLoadData(),
      );
    },
  );
}
