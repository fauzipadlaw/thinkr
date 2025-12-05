// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DecisionEditorState {

 Decision? get decision; bool get isLoading; bool get isSaving; bool get isEvaluated; String? get errorMessage;
/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionEditorStateCopyWith<DecisionEditorState> get copyWith => _$DecisionEditorStateCopyWithImpl<DecisionEditorState>(this as DecisionEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionEditorState&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isEvaluated, isEvaluated) || other.isEvaluated == isEvaluated)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,decision,isLoading,isSaving,isEvaluated,errorMessage);

@override
String toString() {
  return 'DecisionEditorState(decision: $decision, isLoading: $isLoading, isSaving: $isSaving, isEvaluated: $isEvaluated, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DecisionEditorStateCopyWith<$Res>  {
  factory $DecisionEditorStateCopyWith(DecisionEditorState value, $Res Function(DecisionEditorState) _then) = _$DecisionEditorStateCopyWithImpl;
@useResult
$Res call({
 Decision? decision, bool isLoading, bool isSaving, bool isEvaluated, String? errorMessage
});


$DecisionCopyWith<$Res>? get decision;

}
/// @nodoc
class _$DecisionEditorStateCopyWithImpl<$Res>
    implements $DecisionEditorStateCopyWith<$Res> {
  _$DecisionEditorStateCopyWithImpl(this._self, this._then);

  final DecisionEditorState _self;
  final $Res Function(DecisionEditorState) _then;

/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decision = freezed,Object? isLoading = null,Object? isSaving = null,Object? isEvaluated = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
decision: freezed == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as Decision?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isEvaluated: null == isEvaluated ? _self.isEvaluated : isEvaluated // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DecisionCopyWith<$Res>? get decision {
    if (_self.decision == null) {
    return null;
  }

  return $DecisionCopyWith<$Res>(_self.decision!, (value) {
    return _then(_self.copyWith(decision: value));
  });
}
}


/// Adds pattern-matching-related methods to [DecisionEditorState].
extension DecisionEditorStatePatterns on DecisionEditorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionEditorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionEditorState value)  $default,){
final _that = this;
switch (_that) {
case _DecisionEditorState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionEditorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Decision? decision,  bool isLoading,  bool isSaving,  bool isEvaluated,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionEditorState() when $default != null:
return $default(_that.decision,_that.isLoading,_that.isSaving,_that.isEvaluated,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Decision? decision,  bool isLoading,  bool isSaving,  bool isEvaluated,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DecisionEditorState():
return $default(_that.decision,_that.isLoading,_that.isSaving,_that.isEvaluated,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Decision? decision,  bool isLoading,  bool isSaving,  bool isEvaluated,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DecisionEditorState() when $default != null:
return $default(_that.decision,_that.isLoading,_that.isSaving,_that.isEvaluated,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DecisionEditorState implements DecisionEditorState {
  const _DecisionEditorState({this.decision, this.isLoading = false, this.isSaving = false, this.isEvaluated = false, this.errorMessage});
  

@override final  Decision? decision;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isEvaluated;
@override final  String? errorMessage;

/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionEditorStateCopyWith<_DecisionEditorState> get copyWith => __$DecisionEditorStateCopyWithImpl<_DecisionEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionEditorState&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isEvaluated, isEvaluated) || other.isEvaluated == isEvaluated)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,decision,isLoading,isSaving,isEvaluated,errorMessage);

@override
String toString() {
  return 'DecisionEditorState(decision: $decision, isLoading: $isLoading, isSaving: $isSaving, isEvaluated: $isEvaluated, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DecisionEditorStateCopyWith<$Res> implements $DecisionEditorStateCopyWith<$Res> {
  factory _$DecisionEditorStateCopyWith(_DecisionEditorState value, $Res Function(_DecisionEditorState) _then) = __$DecisionEditorStateCopyWithImpl;
@override @useResult
$Res call({
 Decision? decision, bool isLoading, bool isSaving, bool isEvaluated, String? errorMessage
});


@override $DecisionCopyWith<$Res>? get decision;

}
/// @nodoc
class __$DecisionEditorStateCopyWithImpl<$Res>
    implements _$DecisionEditorStateCopyWith<$Res> {
  __$DecisionEditorStateCopyWithImpl(this._self, this._then);

  final _DecisionEditorState _self;
  final $Res Function(_DecisionEditorState) _then;

/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decision = freezed,Object? isLoading = null,Object? isSaving = null,Object? isEvaluated = null,Object? errorMessage = freezed,}) {
  return _then(_DecisionEditorState(
decision: freezed == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as Decision?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isEvaluated: null == isEvaluated ? _self.isEvaluated : isEvaluated // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DecisionCopyWith<$Res>? get decision {
    if (_self.decision == null) {
    return null;
  }

  return $DecisionCopyWith<$Res>(_self.decision!, (value) {
    return _then(_self.copyWith(decision: value));
  });
}
}

// dart format on
