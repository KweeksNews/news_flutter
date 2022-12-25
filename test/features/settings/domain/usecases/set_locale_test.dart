import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/set_locale.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'set_locale_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late SetLocale usecase;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = SetLocale(mockSettingsRepository);
  });

  const String testLocaleString = 'id';
  const Locale testLocale = Locale('id');

  test(
    'Should set locale from repository',
    () async {
      when(
        mockSettingsRepository.setLocale(
          languageCode: anyNamed('languageCode'),
        ),
      ).thenAnswer(
        (_) async => const Right(testLocale),
      );

      final result = await usecase(
        languageCode: testLocaleString,
      );

      expect(
        result,
        const Right<Failure, Locale>(testLocale),
      );

      verify(
        mockSettingsRepository.setLocale(
          languageCode: testLocaleString,
        ),
      );

      verifyNoMoreInteractions(
        mockSettingsRepository,
      );
    },
  );
}
