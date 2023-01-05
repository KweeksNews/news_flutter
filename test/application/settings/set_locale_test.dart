import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/settings/set_locale.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/domain/repositories/settings/settings_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'set_locale_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late SetLocale usecase;

  const String testLocaleString = 'id';
  const Locale testLocale = Locale('id');

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = SetLocale(mockSettingsRepository);
  });

  test(
    'Should set locale from repository',
    () async {
      // Arrange
      when(
        mockSettingsRepository.setLocale(
          languageCode: anyNamed('languageCode'),
        ),
      ).thenAnswer(
        (_) async => const Right(testLocale),
      );

      // Act
      final result = await usecase(
        languageCode: testLocaleString,
      );

      // Assert
      verify(
        mockSettingsRepository.setLocale(
          languageCode: testLocaleString,
        ),
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
