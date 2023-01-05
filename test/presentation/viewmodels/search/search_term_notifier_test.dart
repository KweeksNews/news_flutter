import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/presentation/viewmodels/search/notifier.dart';

void main() {
  late ProviderContainer container;
  late StateNotifierProvider<SearchTermNotifier, String> searchTermProvider;

  const String testSearchTerm = 'search term';

  setUp(() {
    container = ProviderContainer();
    searchTermProvider = StateNotifierProvider<SearchTermNotifier, String>(
      (ref) => SearchTermNotifier(),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should set new search term',
    () {
      // Arrange
      expect(
        container.read(searchTermProvider),
        '',
      );

      // Act
      container.read(searchTermProvider.notifier).setSearchTerm(
            searchTerm: testSearchTerm,
          );

      // Assert
      expect(
        container.read(searchTermProvider),
        testSearchTerm,
      );
    },
  );
}
