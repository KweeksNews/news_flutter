import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/presentation/viewmodels/webview/loading_progress_notifier.dart';

void main() {
  late ProviderContainer container;
  late StateNotifierProvider<LoadingProgressNotifier, double>
      loadingProgressProvider;

  const double testProgressStart = 0;
  const double testProgressEnd = 100;

  setUp(() {
    container = ProviderContainer();
    loadingProgressProvider =
        StateNotifierProvider<LoadingProgressNotifier, double>(
      (ref) => LoadingProgressNotifier(),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should set loading progress start from 0.0 to set value',
    () async {
      // Arrange
      expect(
        container.read(loadingProgressProvider),
        testProgressStart,
      );

      // Act
      container.read(loadingProgressProvider.notifier).set(
            progress: testProgressEnd,
          );

      // Assert
      expect(
        container.read(loadingProgressProvider),
        testProgressEnd,
      );
    },
  );
}
