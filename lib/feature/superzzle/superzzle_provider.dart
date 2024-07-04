import 'package:taiwan_superzzle/feature/settings/settings_provider.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_card_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_model.dart';

part 'superzzle_provider.g.dart';

@riverpod
class SuperzzleGameState extends _$SuperzzleGameState {
  int? _firstCardOpenedIndex;

  void restart() {
    state = state.copyWith(cards: readFromSettings(), attempts: 0);
    _firstCardOpenedIndex = null;

    ref.notifyListeners();
  }

  Future<bool?> openCard(int id, Duration flipDuration,
      Duration delayBeforeClosing, Duration delayBeforeMatching) async {
    if (state.cards[id].state == SuperzzleCardState.closed) {
      if (_firstCardOpenedIndex != null) {
        // Second card, now check if they match
        state = state.copyWith(attempts: state.attempts + 1);
        final temp = _firstCardOpenedIndex;
        _firstCardOpenedIndex = null;
        setCardState(id, SuperzzleCardState.opened);

        if (state.cards[temp!].text == state.cards[id].text) {
          await Future.delayed(flipDuration + delayBeforeMatching, () {
            setCardState(temp, SuperzzleCardState.matched);
            setCardState(id, SuperzzleCardState.matched);
          });
          return true;
        } else {
          await Future.delayed(flipDuration + delayBeforeMatching);
          setCardState(temp, SuperzzleCardState.incorrect);
          setCardState(id, SuperzzleCardState.incorrect);

          await Future.delayed(delayBeforeClosing);
          setCardState(temp, SuperzzleCardState.closed);
          setCardState(id, SuperzzleCardState.closed);

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
    state = state.copyWith(cards: value);
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
    state.cards.shuffle();
  }

  void setCardState(int index, SuperzzleCardState cardState) {
    state.cards[index] = state.cards[index].copyWith(state: cardState);
    ref.notifyListeners();
  }

  @override
  SuperzzleGameStateModel build() {
    return SuperzzleGameStateModel(cards: readFromSettings());
  }
}
