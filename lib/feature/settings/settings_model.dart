import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    @Default([
      '餐廳',
      '扶手電梯',
      '買樓',
      '小費文化',
      '自助餐',
      '叫人名字',
      '派利是',
      '簽名',
      '米糕',
      '地理問題',
      '蛋炒飯',
      '三色豆'
    ])
    List<String> items,
    @Default(4) int cardsPerRow,
  }) = _SettingsModel;
}
