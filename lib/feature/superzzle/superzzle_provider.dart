import 'package:taiwan_superzzle/feature/settings/settings_provider.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'superzzle_provider.g.dart';

@riverpod
class SuperzzleGameState extends _$SuperzzleGameState {
  int? _firstCardOpenedIndex;

  void restart() {
    state = readFromSettings();
  }

  Future<bool?> openCard(int id) async {
    if (state[id].state == SuperzzleCardState.closed) {
      if (_firstCardOpenedIndex != null) {
        // Second card, now check if they match
        if (state[_firstCardOpenedIndex!].text == state[id].text) {
          setCardState(_firstCardOpenedIndex!, SuperzzleCardState.matched);
          setCardState(id, SuperzzleCardState.matched);
          _firstCardOpenedIndex = null;
          return true;
        } else {
          setCardState(id, SuperzzleCardState.opened);
          final temp = _firstCardOpenedIndex;
          _firstCardOpenedIndex = null;
          await Future.delayed(const Duration(milliseconds: 1500), () {
            setCardState(temp!, SuperzzleCardState.closed);
            setCardState(id, SuperzzleCardState.closed);
          });

          // _firstCardOpenedIndex = null;
          return false;
        }
      } else {
        // First card
        setCardState(id, SuperzzleCardState.opened);
        _firstCardOpenedIndex = id;
        return null;
      }
    }
    return null;
  }

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
