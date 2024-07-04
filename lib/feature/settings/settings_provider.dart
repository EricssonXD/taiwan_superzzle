import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taiwan_superzzle/feature/settings/settings_model.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
class SettingsState extends _$SettingsState {
  void update(SettingsModel Function(SettingsModel state) update) {
    state = update(state);
  }

  void reset() {
    state = const SettingsModel();
  }

  @override
  SettingsModel build() {
    return const SettingsModel(
        // items: ['餐廳'],
        );
  }
}
