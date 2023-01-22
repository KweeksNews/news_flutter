import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/domain/entities/content_group_ids.dart';
import 'package:news/presentation/viewmodels/home/notifier.dart';

void main() {
  late ProviderContainer container;
  late StateNotifierProvider<ContentGroupDropdownNotifier, ContentGroupIds>
      contentGroupDropdownProvider;

  const ContentGroupIds testInitialIds = ContentGroupIds(categoryIds: ['1']);
  const ContentGroupIds testIds = ContentGroupIds(categoryIds: ['2']);

  setUp(
    () {
      container = ProviderContainer();
      contentGroupDropdownProvider = StateNotifierProvider(
        (ref) => ContentGroupDropdownNotifier(testInitialIds),
      );

      addTearDown(container.dispose);
    },
  );

  test(
    'Should set new IDs',
    () {
      // Arrange
      expect(
        container.read(contentGroupDropdownProvider),
        testInitialIds,
      );

      // Act
      container.read(contentGroupDropdownProvider.notifier).setIds(
            ids: testIds,
          );

      // Assert
      expect(
        container.read(contentGroupDropdownProvider),
        testIds,
      );
    },
  );
}
