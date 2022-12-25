import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/features/home/presentation/notifier/notifier.dart';

void main() {
  late ProviderContainer container;
  late StateNotifierProvider<ContentGroupDropdownNotifier, List<String>>
      contentGroupDropdownProvider;

  const List<String> testInitialIds = ['1'];
  const List<String> testIds = ['2'];

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
      expect(
        container.read(contentGroupDropdownProvider),
        testInitialIds,
      );

      container.read(contentGroupDropdownProvider.notifier).setIds(
            ids: testIds,
          );

      expect(
        container.read(contentGroupDropdownProvider),
        testIds,
      );
    },
  );
}
