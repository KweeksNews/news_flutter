import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_post/lightbox_notifier.dart';

void main() {
  late ProviderContainer container;
  late StateNotifierProvider<LightboxNotifier, int> lightboxProvider;

  const int testIndexStart = 0;
  const int testIndexEnd = 3;

  setUp(() {
    container = ProviderContainer();
    lightboxProvider = StateNotifierProvider<LightboxNotifier, int>(
      (ref) => LightboxNotifier(),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should set lightbox index start from 0 to set value',
    () async {
      // Arrange
      expect(
        container.read(lightboxProvider),
        testIndexStart,
      );

      // Act
      container.read(lightboxProvider.notifier).setIndex(
            index: testIndexEnd,
          );

      // Assert
      expect(
        container.read(lightboxProvider),
        testIndexEnd,
      );
    },
  );
}
