// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'superzzle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SuperzzleGameStateModel {
  int get attempts => throw _privateConstructorUsedError;
  List<SuperzzleCardModel> get cards => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SuperzzleGameStateModelCopyWith<SuperzzleGameStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuperzzleGameStateModelCopyWith<$Res> {
  factory $SuperzzleGameStateModelCopyWith(SuperzzleGameStateModel value,
          $Res Function(SuperzzleGameStateModel) then) =
      _$SuperzzleGameStateModelCopyWithImpl<$Res, SuperzzleGameStateModel>;
  @useResult
  $Res call({int attempts, List<SuperzzleCardModel> cards});
}

/// @nodoc
class _$SuperzzleGameStateModelCopyWithImpl<$Res,
        $Val extends SuperzzleGameStateModel>
    implements $SuperzzleGameStateModelCopyWith<$Res> {
  _$SuperzzleGameStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attempts = null,
    Object? cards = null,
  }) {
    return _then(_value.copyWith(
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<SuperzzleCardModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SuperzzleGameStateModelImplCopyWith<$Res>
    implements $SuperzzleGameStateModelCopyWith<$Res> {
  factory _$$SuperzzleGameStateModelImplCopyWith(
          _$SuperzzleGameStateModelImpl value,
          $Res Function(_$SuperzzleGameStateModelImpl) then) =
      __$$SuperzzleGameStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int attempts, List<SuperzzleCardModel> cards});
}

/// @nodoc
class __$$SuperzzleGameStateModelImplCopyWithImpl<$Res>
    extends _$SuperzzleGameStateModelCopyWithImpl<$Res,
        _$SuperzzleGameStateModelImpl>
    implements _$$SuperzzleGameStateModelImplCopyWith<$Res> {
  __$$SuperzzleGameStateModelImplCopyWithImpl(
      _$SuperzzleGameStateModelImpl _value,
      $Res Function(_$SuperzzleGameStateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attempts = null,
    Object? cards = null,
  }) {
    return _then(_$SuperzzleGameStateModelImpl(
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<SuperzzleCardModel>,
    ));
  }
}

/// @nodoc

class _$SuperzzleGameStateModelImpl
    with DiagnosticableTreeMixin
    implements _SuperzzleGameStateModel {
  const _$SuperzzleGameStateModelImpl(
      {this.attempts = 0, this.cards = const []});

  @override
  @JsonKey()
  final int attempts;
  @override
  @JsonKey()
  final List<SuperzzleCardModel> cards;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SuperzzleGameStateModel(attempts: $attempts, cards: $cards)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SuperzzleGameStateModel'))
      ..add(DiagnosticsProperty('attempts', attempts))
      ..add(DiagnosticsProperty('cards', cards));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuperzzleGameStateModelImpl &&
            (identical(other.attempts, attempts) ||
                other.attempts == attempts) &&
            const DeepCollectionEquality().equals(other.cards, cards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, attempts, const DeepCollectionEquality().hash(cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuperzzleGameStateModelImplCopyWith<_$SuperzzleGameStateModelImpl>
      get copyWith => __$$SuperzzleGameStateModelImplCopyWithImpl<
          _$SuperzzleGameStateModelImpl>(this, _$identity);
}

abstract class _SuperzzleGameStateModel implements SuperzzleGameStateModel {
  const factory _SuperzzleGameStateModel(
      {final int attempts,
      final List<SuperzzleCardModel> cards}) = _$SuperzzleGameStateModelImpl;

  @override
  int get attempts;
  @override
  List<SuperzzleCardModel> get cards;
  @override
  @JsonKey(ignore: true)
  _$$SuperzzleGameStateModelImplCopyWith<_$SuperzzleGameStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
