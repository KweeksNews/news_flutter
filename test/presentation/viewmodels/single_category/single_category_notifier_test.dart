import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_category/get_category.dart';
import 'package:kweeksnews_app/domain/entities/category.dart';
import 'package:kweeksnews_app/domain/enums/category_id_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_category/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/category.dart';
import 'single_category_notifier_test.mocks.dart';

@GenerateMocks([GetCategory])
void main() {
  late MockGetCategory mockGetCategory;
  late ProviderContainer container;
  late StateNotifierProvider<SingleCategoryNotifier, SingleCategoryState>
      singleCategoryProvider;

  const String testId = '1';
  const CategoryIdType testIdType = CategoryIdType.id;
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
          idType: anyNamed('idType'),
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
            idType: testIdType,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetCategory(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetCategory(
          id: testId,
          idType: testIdType,
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
          idType: anyNamed('idType'),
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
            idType: testIdType,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetCategory(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetCategory(
          id: testId,
          idType: testIdType,
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
