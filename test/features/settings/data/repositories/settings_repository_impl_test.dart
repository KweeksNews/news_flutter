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
          when(
            mockThemeLocalDataSource.getTheme(),
          ).thenAnswer(
            (_) async => testTheme,
          );

          final result = await repository.getTheme();

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
          when(
            mockThemeLocalDataSource.getTheme(),
          ).thenThrow(
            ConfigException(),
          );

          final result = await repository.getTheme();

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
          when(
            mockThemeLocalDataSource.setTheme(any),
          ).thenAnswer(
            (_) async => testTheme,
          );

          final result = await repository.setTheme(
            mode: testTheme,
          );

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
          when(
            mockThemeLocalDataSource.setTheme(any),
          ).thenThrow(
            ConfigException(),
          );

          final result = await repository.setTheme(
            mode: testTheme,
          );

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
          when(
            mockLocaleLocalDataSource.getLocale(),
          ).thenAnswer(
            (_) async => testLocale,
          );

          final result = await repository.getLocale();

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
          when(
            mockLocaleLocalDataSource.getLocale(),
          ).thenThrow(
            ConfigException(),
          );

          final result = await repository.getLocale();

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
          when(
            mockLocaleLocalDataSource.setLocale(any),
          ).thenAnswer(
            (_) async => testLocale,
          );

          final result = await repository.setLocale(
            languageCode: testLocaleString,
          );

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
          when(
            mockLocaleLocalDataSource.setLocale(any),
          ).thenThrow(
            ConfigException(),
          );

          final result = await repository.setLocale(
            languageCode: testLocaleString,
          );

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
