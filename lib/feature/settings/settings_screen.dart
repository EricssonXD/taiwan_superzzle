import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taiwan_superzzle/feature/settings/settings_provider.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => ref.read(settingsStateProvider.notifier).reset(),
              child: const Text("Reset")),
          const Text("Cards per row"),
          Slider(
            divisions: 20,
            label: settings.cardsPerRow.toString(),
            max: 20,
            min: 1,
            value: settings.cardsPerRow.toDouble(),
            onChanged: (value) =>
                ref.read(settingsStateProvider.notifier).update(
                      (state) => state.copyWith(cardsPerRow: value.toInt()),
                    ),
          ),
          const Text("Font Size"),
          Slider(
            divisions: 100,
            label: settings.fontSize.toInt().toString(),
            max: 100,
            min: 1,
            value: settings.fontSize,
            onChanged: (value) =>
                ref.read(settingsStateProvider.notifier).update(
                      (state) => state.copyWith(fontSize: value),
                    ),
          )
        ],
      ),
    );
  }
}

class ItemList extends HookConsumerWidget {
  const ItemList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
