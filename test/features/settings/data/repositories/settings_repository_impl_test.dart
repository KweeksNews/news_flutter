import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/error/exceptions.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/settings/data/datasources/locale_local_data_source.dart';
import 'package:kweeksnews_app/features/settings/data/datasources/theme_local_data_source.dart';
import 'package:kweeksnews_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:kweeksnews_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'settings_repository_impl_test.mocks.dart';

@GenerateMocks([LocaleLocalDataSource, ThemeLocalDataSource])
void main() {
  late MockLocaleLocalDataSource mockLocaleLocalDataSource;
  late MockThemeLocalDataSource mockThemeLocalDataSource;
  late SettingsRepository repository;

  const testTheme = ThemeMode.system;
  const testLocaleString = 'id';
  const testLocale = Locale('id');

  setUp(
    () {
      mockLocaleLocalDataSource = MockLocaleLocalDataSource();
      mockThemeLocalDataSource = MockThemeLocalDataSource();
      repository = SettingsRepositoryImpl(
        mockThemeLocalDataSource,
        mockLocaleLocalDataSource,
      );
    },
  );

  group(
    'Get theme',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockThemeLocalDataSource.getTheme(),
          ).thenAnswer(
            (_) async => testTheme,
          );

          // Act
          final result = await repository.getTheme();

          // Assert
          verify(
            mockThemeLocalDataSource.getTheme(),
          );

          expect(
            result,
            const Right<Failure, ThemeMode>(testTheme),
          );
        },
      );

      test(
        'Should return config failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockThemeLocalDataSource.getTheme(),
          ).thenThrow(
            ConfigException(),
          );

          // Act
          final result = await repository.getTheme();

          // Assert
          verify(
            mockThemeLocalDataSource.getTheme(),
          );

          expect(
            result,
            Left<Failure, ThemeMode>(ConfigFailure()),
          );
        },
      );
    },
  );

  group(
    'Set theme',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockThemeLocalDataSource.setTheme(any),
          ).thenAnswer(
            (_) async => testTheme,
          );

          // Act
          final result = await repository.setTheme(
            mode: testTheme,
          );

          // Assert
          verify(
            mockThemeLocalDataSource.setTheme(
              testTheme,
            ),
          );

          expect(
            result,
            const Right<Failure, ThemeMode>(testTheme),
          );
        },
      );

      test(
        'Should return config failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockThemeLocalDataSource.setTheme(any),
          ).thenThrow(
            ConfigException(),
          );

          // Act
          final result = await repository.setTheme(
            mode: testTheme,
          );

          // Assert
          verify(
            mockThemeLocalDataSource.setTheme(
              testTheme,
            ),
          );

          expect(
            result,
            Left<Failure, ThemeMode>(ConfigFailure()),
          );
        },
      );
    },
  );

  group(
    'Get locale',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockLocaleLocalDataSource.getLocale(),
          ).thenAnswer(
            (_) async => testLocale,
          );

          // Act
          final result = await repository.getLocale();

          // Assert
          verify(
            mockLocaleLocalDataSource.getLocale(),
          );

          expect(
            result,
            const Right<Failure, Locale>(testLocale),
          );
        },
      );

      test(
        'Should return config failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockLocaleLocalDataSource.getLocale(),
          ).thenThrow(
            ConfigException(),
          );

          // Act
          final result = await repository.getLocale();

          // Assert
          verify(
            mockLocaleLocalDataSource.getLocale(),
          );

          expect(
            result,
            Left<Failure, Locale>(ConfigFailure()),
          );
        },
      );
    },
  );

  group(
    'Set locale',
    () {
      test(
        'Should return data when the call to local data source is successful',
        () async {
          // Arrange
          when(
            mockLocaleLocalDataSource.setLocale(any),
          ).thenAnswer(
            (_) async => testLocale,
          );

          // Act
          final result = await repository.setLocale(
            languageCode: testLocaleString,
          );

          // Assert
          verify(
            mockLocaleLocalDataSource.setLocale(
              testLocaleString,
            ),
          );

          expect(
            result,
            const Right<Failure, Locale>(testLocale),
          );
        },
      );

      test(
        'Should return config failure when the call to local data source is unsuccessful',
        () async {
          // Arrange
          when(
            mockLocaleLocalDataSource.setLocale(any),
          ).thenThrow(
            ConfigException(),
          );

          // Act
          final result = await repository.setLocale(
            languageCode: testLocaleString,
          );

          // Assert
          verify(
            mockLocaleLocalDataSource.setLocale(
              testLocaleString,
            ),
          );

          expect(
            result,
            Left<Failure, Locale>(ConfigFailure()),
          );
        },
      );
    },
  );
}
