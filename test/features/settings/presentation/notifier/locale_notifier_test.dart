import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/enums/state_exception_type.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/get_locale.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/set_locale.dart';
import 'package:kweeksnews_app/features/settings/presentation/notifier/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
          when(
            mockGetLocale(),
          ).thenAnswer(
            (_) async => const Right(testLocale),
          );

          expect(
            container.read(localeProvider),
            const LocaleLoading(
              locale: testLocale,
            ),
          );

          container.read(localeProvider.notifier).get();

          await untilCalled(
            mockGetLocale(),
          );

          expect(
            container.read(localeProvider),
            const LocaleLoaded(
              locale: testLocale,
            ),
          );

          verify(
            mockGetLocale(),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          when(
            mockGetLocale(),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(localeProvider),
            const LocaleLoading(
              locale: testLocale,
            ),
          );

          container.read(localeProvider.notifier).get();

          await untilCalled(
            mockGetLocale(),
          );

          expect(
            container.read(localeProvider),
            const LocaleException(
              locale: testLocale,
              type: StateExceptionType.failedToRetrieveSettings,
            ),
          );

          verify(
            mockGetLocale(),
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
          when(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          ).thenAnswer(
            (_) async => const Right(testLocale),
          );

          expect(
            container.read(localeProvider),
            const LocaleLoading(
              locale: testLocale,
            ),
          );

          container.read(localeProvider.notifier).set(
                languageCode: testLocaleString,
              );

          await untilCalled(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          );

          expect(
            container.read(localeProvider),
            const LocaleLoaded(
              locale: testLocale,
            ),
          );

          verify(
            mockSetLocale(
              languageCode: testLocaleString,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          when(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(localeProvider),
            const LocaleLoading(
              locale: testLocale,
            ),
          );

          container.read(localeProvider.notifier).set(
                languageCode: testLocaleString,
              );

          await untilCalled(
            mockSetLocale(
              languageCode: anyNamed('languageCode'),
            ),
          );

          expect(
            container.read(localeProvider),
            const LocaleException(
              locale: testLocale,
              type: StateExceptionType.failedToChangeSettings,
            ),
          );

          verify(
            mockSetLocale(
              languageCode: testLocaleString,
            ),
          );
        },
      );
    },
  );
}
