import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_user/get_user.dart';
import 'package:kweeksnews_app/domain/entities/user.dart';
import 'package:kweeksnews_app/domain/entities/user_id.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/user.dart';
import 'get_user_test.mocks.dart';

@GenerateMocks([WpRepository])
void main() {
  late MockWpRepository mockWpRepository;
  late GetUser usecase;

  final UserId testId = UserId.id('1');
  const bool testForceRefresh = false;
  const User testUser = user;

  setUp(() {
    mockWpRepository = MockWpRepository();
    usecase = GetUser(mockWpRepository);
  });

  test(
    'Should get user from repository',
    () async {
      // Arrange
      when(
        mockWpRepository.getUser(
          id: anyNamed('id'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => const Right(testUser),
      );

      // Act
      final result = await usecase(
        id: testId,
        forceRefresh: testForceRefresh,
      );

      // Assert
      verify(
        mockWpRepository.getUser(
          id: testId,
          forceRefresh: testForceRefresh,
        ),
      );

      verifyNoMoreInteractions(
        mockWpRepository,
      );

      expect(
        result,
        const Right<Failure, User>(testUser),
      );
    },
  );
}
