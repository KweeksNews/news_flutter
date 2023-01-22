import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/single_user/get_user.dart';
import 'package:news/domain/entities/user.dart';
import 'package:news/domain/entities/user_id.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/presentation/viewmodels/single_user/notifier.dart';

import '../../../fixtures/user.dart';
import 'single_user_notifier_test.mocks.dart';

@GenerateMocks([GetUser])
void main() {
  late MockGetUser mockGetUser;
  late ProviderContainer container;
  late StateNotifierProvider<SingleUserNotifier, SingleUserState>
      singleUserProvider;

  final UserId testId = UserId.id('1');
  const bool testForceRefresh = false;
  const User testUser = user;

  setUp(() {
    mockGetUser = MockGetUser();
    container = ProviderContainer();
    singleUserProvider =
        StateNotifierProvider<SingleUserNotifier, SingleUserState>(
      (ref) => SingleUserNotifier(mockGetUser),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should get data from the use case and return User on success',
    () async {
      // Arrange
      when(
        mockGetUser(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testUser),
      );

      expect(
        container.read(singleUserProvider),
        const SingleUserState.loading(),
      );

      // Act
      container.read(singleUserProvider.notifier).fetchUser(
            id: testId,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetUser(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetUser(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singleUserProvider),
        const SingleUserState.loaded(
          user: user,
        ),
      );
    },
  );

  test(
    'Should get data from the use case and return error on failure',
    () async {
      // Arrange
      when(
        mockGetUser(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Left(RequestFailure()),
      );

      expect(
        container.read(singleUserProvider),
        const SingleUserState.loading(),
      );

      // Act
      container.read(singleUserProvider.notifier).fetchUser(
            id: testId,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetUser(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetUser(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singleUserProvider),
        const SingleUserState.failedToLoadData(),
      );
    },
  );
}
