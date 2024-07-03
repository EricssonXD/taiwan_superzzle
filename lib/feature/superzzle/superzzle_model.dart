import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'superzzle_model.freezed.dart';

@freezed
class SuperzzleCardModel with _$SuperzzleCardModel {
  const factory SuperzzleCardModel({
    @Default(SuperzzleCardState.closed) SuperzzleCardState state,
    required String text,
  }) = _SuperzzleCardModel;
}

enum SuperzzleCardState {
  closed,
  opened,
  matched,
}
