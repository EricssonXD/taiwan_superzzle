import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taiwan_superzzle/feature/settings/settings_model.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsState extends _$SettingsState {
  @override
  SettingsModel build() {
    return const SettingsModel();
  }
}
