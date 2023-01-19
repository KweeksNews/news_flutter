import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_user/get_user.dart';
import 'package:kweeksnews_app/domain/entities/user.dart';
import 'package:kweeksnews_app/domain/enums/user_node_id_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_user/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/user.dart';
import 'single_user_notifier_test.mocks.dart';

@GenerateMocks([GetUser])
void main() {
  late MockGetUser mockGetUser;
  late ProviderContainer container;
  late StateNotifierProvider<SingleUserNotifier, SingleUserState>
      singleUserProvider;

  const String testId = '1';
  const UserNodeIdType testIdType = UserNodeIdType.id;
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
          idType: anyNamed('idType'),
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
            idType: testIdType,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetUser(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetUser(
          id: testId,
          idType: testIdType,
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
          idType: anyNamed('idType'),
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
            idType: testIdType,
            forceRefresh: testForceRefresh,
          );

      await untilCalled(
        mockGetUser(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetUser(
          id: testId,
          idType: testIdType,
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
