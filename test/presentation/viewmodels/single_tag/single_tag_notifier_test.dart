import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_tag/get_tag.dart';
import 'package:kweeksnews_app/domain/entities/tag.dart';
import 'package:kweeksnews_app/domain/entities/tag_id.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_tag/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/tag.dart';
import 'single_tag_notifier_test.mocks.dart';

@GenerateMocks([GetTag])
void main() {
  late MockGetTag mockGetTag;
  late ProviderContainer container;
  late StateNotifierProvider<SingleTagNotifier, SingleTagState>
      singleTagProvider;

  final TagId testId = TagId.id('1');
  const bool testForceRefresh = false;
  const Tag testTag = tag;

  setUp(() {
    mockGetTag = MockGetTag();
    container = ProviderContainer();
    singleTagProvider =
        StateNotifierProvider<SingleTagNotifier, SingleTagState>(
      (ref) => SingleTagNotifier(mockGetTag),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should get data from the use case and return Tag on success',
    () async {
      // Arrange
      when(
        mockGetTag(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testTag),
      );

      expect(
        container.read(singleTagProvider),
        const SingleTagState.loading(),
      );

      // Act
      container.read(singleTagProvider.notifier).fetchTag(
            id: testId,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetTag(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetTag(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singleTagProvider),
        const SingleTagState.loaded(
          tag: tag,
        ),
      );
    },
  );

  test(
    'Should get data from the use case and return error on failure',
    () async {
      // Arrange
      when(
        mockGetTag(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Left(RequestFailure()),
      );

      expect(
        container.read(singleTagProvider),
        const SingleTagState.loading(),
      );

      // Act
      container.read(singleTagProvider.notifier).fetchTag(
            id: testId,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetTag(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetTag(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singleTagProvider),
        const SingleTagState.failedToLoadData(),
      );
    },
  );
}
