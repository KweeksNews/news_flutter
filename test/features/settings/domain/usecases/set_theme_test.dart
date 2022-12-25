import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/set_theme.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'set_theme_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late SetTheme usecase;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = SetTheme(mockSettingsRepository);
  });

  const ThemeMode testTheme = ThemeMode.system;

  test(
    'Should set locale from repository',
    () async {
      when(
        mockSettingsRepository.setTheme(
          mode: anyNamed('mode'),
        ),
      ).thenAnswer(
        (_) async => const Right(testTheme),
      );

      final result = await usecase(
        mode: testTheme,
      );

      expect(
        result,
        const Right<Failure, ThemeMode>(testTheme),
      );

      verify(
        mockSettingsRepository.setTheme(
          mode: testTheme,
        ),
      );

      verifyNoMoreInteractions(
        mockSettingsRepository,
      );
    },
  );
}
