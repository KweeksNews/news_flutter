import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/settings/get_theme.dart';
import 'package:kweeksnews_app/application/settings/set_theme.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/settings/notifier.dart';
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
          // Arrange
          when(
            mockGetTheme(),
          ).thenAnswer(
            (_) async => const Right(testTheme),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.loading(
              themeMode: testTheme,
            ),
          );

          // Act
          container.read(themeProvider.notifier).get();

          await untilCalled(
            mockGetTheme(),
          );

          // Assert
          verify(
            mockGetTheme(),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.loaded(
              themeMode: testTheme,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          // Arrange
          when(
            mockGetTheme(),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.loading(
              themeMode: testTheme,
            ),
          );

          // Act
          container.read(themeProvider.notifier).get();

          await untilCalled(
            mockGetTheme(),
          );

          // Assert
          verify(
            mockGetTheme(),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.failedToRetrieveSettings(
              themeMode: testTheme,
            ),
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
          // Arrange
          when(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          ).thenAnswer(
            (_) async => const Right(testTheme),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.loading(
              themeMode: testTheme,
            ),
          );

          // Act
          container.read(themeProvider.notifier).set(
                mode: testTheme,
              );

          await untilCalled(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          );

          // Assert
          verify(
            mockSetTheme(
              mode: testTheme,
            ),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.loaded(
              themeMode: testTheme,
            ),
          );
        },
      );

      test(
        'Should get data from the use case and return exception on failure',
        () async {
          // Arrange
          when(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          ).thenAnswer(
            (_) async => Left(ConfigFailure()),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.loading(
              themeMode: testTheme,
            ),
          );

          // Act
          container.read(themeProvider.notifier).set(
                mode: testTheme,
              );

          await untilCalled(
            mockSetTheme(
              mode: anyNamed('mode'),
            ),
          );

          // Assert
          verify(
            mockSetTheme(
              mode: testTheme,
            ),
          );

          expect(
            container.read(themeProvider),
            const ThemeState.failedToRetrieveSettings(
              themeMode: testTheme,
            ),
          );
        },
      );
    },
  );
}
