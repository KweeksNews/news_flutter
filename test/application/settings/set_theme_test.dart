import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/settings/set_theme.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/domain/repositories/settings/settings_repository.dart';

import 'set_theme_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late SetTheme usecase;

  const ThemeMode testTheme = ThemeMode.system;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = SetTheme(mockSettingsRepository);
  });

  test(
    'Should set theme from repository',
    () async {
      // Arrange
      when(
        mockSettingsRepository.setTheme(
          mode: anyNamed('mode'),
        ),
      ).thenAnswer(
        (_) async => const Right(testTheme),
      );

      // Act
      final result = await usecase(
        mode: testTheme,
      );

      // Assert
      verify(
        mockSettingsRepository.setTheme(
          mode: testTheme,
        ),
      );

      verifyNoMoreInteractions(
        mockSettingsRepository,
      );

      expect(
        result,
        const Right<Failure, ThemeMode>(testTheme),
      );
    },
  );
}
