import 'package:taiwan_superzzle/feature/settings/settings_provider.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'superzzle_provider.g.dart';

@riverpod
class SuperzzleGameState extends _$SuperzzleGameState {
  void set(List<SuperzzleCardModel> value) {
    state = value;
  }

  List<SuperzzleCardModel> readFromSettings() {
    List<SuperzzleCardModel> temp = [
      for (final String v in ref.read(settingsStateProvider).items) ...[
        SuperzzleCardModel(text: v),
        SuperzzleCardModel(text: v),
      ]
    ]..shuffle();
    return temp;
  }

  void shuffle() {
    state.shuffle();
  }

  void setCardState(int index, SuperzzleCardState cardState) {
    state[index] = state[index].copyWith(state: cardState);
    ref.notifyListeners();
  }

  @override
  List<SuperzzleCardModel> build() {
    return readFromSettings();
  }
}
