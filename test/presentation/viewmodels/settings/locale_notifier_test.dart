import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news/application/settings/get_locale.dart';
import 'package:news/application/settings/set_locale.dart';
import 'package:news/domain/error/failures.dart';
import 'package:news/presentation/viewmodels/settings/notifier.dart';

import 'locale_notifier_test.mocks.dart';

@GenerateMocks([GetLocale, SetLocale])
void main() {
  late MockGetLocale mockGetLocale;
  late MockSetLocale mockSetLocale;
  late ProviderContainer container;
  late StateNotifierProvider<LocaleNotifier, LocaleState> localeProvider;

  const String testLocaleString = 'id';
  const Locale testLocale = Locale('id');

  setUp(() {
    mockGetLocale = MockGetLocale();
    mockSetLocale = MockSetLocale();
    container = ProviderContainer();
    localeProvider = StateNotifierProvider<LocaleNotifier, LocaleState>(
      (ref) => LocaleNotifier(
        mockGetLocale,
        mockSetLocale,
      ),
    );

    addTearDown(container.dispose);
  });

  group(
    'Get locale',
    () {
      test(
        'Should get data from the use case and return Locale on success',
        () async {
          // Arrange
          when(
            mockGetLocale(),
          ).thenAnswer(
            (_) async => const Right(testLocale),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.loading(
              locale: testLocale,
            ),
          );

          // Act
          container.read(localeProvider.notifier).get();

          await untilCalled(
            mockGetLocale(),
          );

          // Assert
          verify(
            mockGetLocale(),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.loaded(
              locale: testLocale,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          // Arrange
          when(
            mockGetLocale(),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.loading(
              locale: testLocale,
            ),
          );

          // Act
          container.read(localeProvider.notifier).get();

          await untilCalled(
            mockGetLocale(),
          );

          // Assert
          verify(
            mockGetLocale(),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.failedToRetrieveSettings(
              locale: testLocale,
            ),
          );
        },
      );
    },
  );

  group(
    'Set locale',
    () {
      test(
        'Should get data from the use case and return Locale on success',
        () async {
          // Arrange
          when(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          ).thenAnswer(
            (_) async => const Right(testLocale),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.loading(
              locale: testLocale,
            ),
          );

          // Act
          container.read(localeProvider.notifier).set(
                languageCode: testLocaleString,
              );

          await untilCalled(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          );

          // Assert
          verify(
            mockSetLocale(
              languageCode: testLocaleString,
            ),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.loaded(
              locale: testLocale,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          // Arrange
          when(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.loading(
              locale: testLocale,
            ),
          );

          // Act
          container.read(localeProvider.notifier).set(
                languageCode: testLocaleString,
              );

          await untilCalled(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          );

          // Assert
          verify(
            mockSetLocale(
              languageCode: testLocaleString,
            ),
          );

          expect(
            container.read(localeProvider),
            const LocaleState.failedToRetrieveSettings(
              locale: testLocale,
            ),
          );
        },
      );
    },
  );
}
