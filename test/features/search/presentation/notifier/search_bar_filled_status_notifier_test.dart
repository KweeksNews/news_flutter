import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/features/search/presentation/notifier/notifier.dart';

void main() {
  late ProviderContainer container;
  late StateNotifierProvider<SearchBarFilledStatusNotifier, bool>
      searchBarFilledStatusProvider;

  const bool testSearchBarFilledStatus = true;

  setUp(() {
    container = ProviderContainer();
    searchBarFilledStatusProvider =
        StateNotifierProvider<SearchBarFilledStatusNotifier, bool>(
      (ref) => SearchBarFilledStatusNotifier(),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should set new search bar filled status',
    () {
      // Arrange
      expect(
        container.read(searchBarFilledStatusProvider),
        false,
      );

      // Act
      container.read(searchBarFilledStatusProvider.notifier).setFilledStatus(
            isFilled: testSearchBarFilledStatus,
          );

      // Assert
      expect(
        container.read(searchBarFilledStatusProvider),
        testSearchBarFilledStatus,
      );
    },
  );
}
