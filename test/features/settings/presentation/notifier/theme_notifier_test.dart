import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/enums/state_exception_type.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/get_theme.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/set_theme.dart';
import 'package:kweeksnews_app/features/settings/presentation/notifier/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_notifier_test.mocks.dart';

@GenerateMocks([GetTheme, SetTheme])
void main() {
  late MockGetTheme mockGetTheme;
  late MockSetTheme mockSetTheme;
  late ProviderContainer container;
  late StateNotifierProvider<ThemeNotifier, ThemeState> themeProvider;

  const ThemeMode testTheme = ThemeMode.system;

  setUp(() {
    mockGetTheme = MockGetTheme();
    mockSetTheme = MockSetTheme();
    container = ProviderContainer();
    themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
      (ref) => ThemeNotifier(
        mockGetTheme,
        mockSetTheme,
      ),
    );

    addTearDown(container.dispose);
  });

  group(
    'Get theme',
    () {
      test(
        'Should get data from the use case and return ThemeMode on success',
        () async {
          when(
            mockGetTheme(),
          ).thenAnswer(
            (_) async => const Right(testTheme),
          );

          expect(
            container.read(themeProvider),
            const ThemeLoading(
              themeMode: testTheme,
            ),
          );

          container.read(themeProvider.notifier).get();

          await untilCalled(
            mockGetTheme(),
          );

          expect(
            container.read(themeProvider),
            const ThemeLoaded(
              themeMode: testTheme,
            ),
          );

          verify(
            mockGetTheme(),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          when(
            mockGetTheme(),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(themeProvider),
            const ThemeLoading(
              themeMode: testTheme,
            ),
          );

          container.read(themeProvider.notifier).get();

          await untilCalled(
            mockGetTheme(),
          );

          expect(
            container.read(themeProvider),
            const ThemeException(
              themeMode: testTheme,
              type: StateExceptionType.failedToRetrieveSettings,
            ),
          );

          verify(
            mockGetTheme(),
          );
        },
      );
    },
  );

  group(
    'Set theme',
    () {
      test(
        'Should get data from the use case and return ThemeMode on success',
        () async {
          when(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          ).thenAnswer(
            (_) async => const Right(testTheme),
          );

          expect(
            container.read(themeProvider),
            const ThemeLoading(
              themeMode: testTheme,
            ),
          );

          container.read(themeProvider.notifier).set(
                mode: testTheme,
              );

          await untilCalled(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          );

          expect(
            container.read(themeProvider),
            const ThemeLoaded(
              themeMode: testTheme,
            ),
          );

          verify(
            mockSetTheme(
              mode: testTheme,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          when(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(themeProvider),
            const ThemeLoading(
              themeMode: testTheme,
            ),
          );

          container.read(themeProvider.notifier).set(
                mode: testTheme,
              );

          await untilCalled(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          );

          expect(
            container.read(themeProvider),
            const ThemeException(
              themeMode: testTheme,
              type: StateExceptionType.failedToChangeSettings,
            ),
          );

          verify(
            mockSetTheme(
              mode: testTheme,
            ),
          );
        },
      );
    },
  );
}
