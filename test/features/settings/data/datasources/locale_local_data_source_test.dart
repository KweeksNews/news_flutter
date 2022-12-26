import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kweeksnews_app/features/settings/data/datasources/locale_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'locale_local_data_source_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<dynamic> mockBox;
  late LocaleLocalDataSource localeLocalDataSource;

  const testLocaleString = 'id';
  const testLocale = Locale('id');

  setUp(() {
    mockBox = MockBox();
    localeLocalDataSource = LocaleLocalDataSourceImpl(mockBox);
  });

  test(
    'Should set and get locale config',
    () async {
      // Arrange
      when(mockBox.put(any, any)).thenAnswer((_) async => {});
      when(mockBox.get(any)).thenAnswer((_) => testLocaleString);

      // Act
      await localeLocalDataSource.setLocale(testLocaleString);

      final result = await localeLocalDataSource.getLocale();

      // Assert
      expect(result, testLocale);
    },
  );
}
