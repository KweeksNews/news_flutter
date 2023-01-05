import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/settings/get_locale.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/settings/settings_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_locale_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late GetLocale usecase;

  const Locale testLocale = Locale('id');

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = GetLocale(mockSettingsRepository);
  });

  test(
    'Should get locale from repository',
    () async {
      // Arrange
      when(
        mockSettingsRepository.getLocale(),
      ).thenAnswer(
        (_) async => const Right(testLocale),
      );

      // Act
      final result = await usecase();

      // Assert
      verify(
        mockSettingsRepository.getLocale(),
      );

      verifyNoMoreInteractions(
        mockSettingsRepository,
      );

      expect(
        result,
        const Right<Failure, Locale>(testLocale),
      );
    },
  );
}
