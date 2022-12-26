import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/get_locale.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_locale_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late GetLocale usecase;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = GetLocale(mockSettingsRepository);
  });

  const Locale testLocale = Locale('id');

  test(
    'Should get locale from repository',
    () async {
      when(
        mockSettingsRepository.getLocale(),
      ).thenAnswer(
        (_) async => const Right(testLocale),
      );

      final result = await usecase();

      expect(
        result,
        const Right<Failure, Locale>(testLocale),
      );

      verify(
        mockSettingsRepository.getLocale(),
      );

      verifyNoMoreInteractions(
        mockSettingsRepository,
      );
    },
  );
}