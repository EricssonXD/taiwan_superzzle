import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:taiwan_superzzle/feature/superzzle/superzzle_card_model.dart';
part 'superzzle_model.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class SuperzzleGameStateModel with _$SuperzzleGameStateModel {
  const factory SuperzzleGameStateModel({
    @Default(0) int attempts,
    @Default([]) List<SuperzzleCardModel> cards,
  }) = _SuperzzleGameStateModel;
}
