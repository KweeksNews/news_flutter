import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kweeksnews_app/infrastructure/datasources/settings/theme_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_local_data_source_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<dynamic> mockBox;
  late ThemeLocalDataSourceImpl themeLocalDataSource;

  const testThemeString = 'system';
  const testTheme = ThemeMode.system;

  setUp(() {
    mockBox = MockBox();
    themeLocalDataSource = ThemeLocalDataSourceImpl(mockBox);
  });

  test(
    'Should set and get theme config',
    () async {
      // Arrange
      when(mockBox.put(any, any)).thenAnswer((_) async => {});
      when(mockBox.get(any)).thenAnswer((_) => testThemeString);

      // Act
      await themeLocalDataSource.setTheme(testTheme);

      final result = await themeLocalDataSource.getTheme();

      // Assert
      expect(result, testTheme);
    },
  );
}
