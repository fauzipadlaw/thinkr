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

 Decision? get decision; bool get isLoading; bool get isSaving; bool get isEvaluated; bool get isDirty; String? get errorMessage;// Derived validation/status fields
 int get missingScores; bool get hasMinOptions; bool get hasCriteria; bool get canEvaluate; int get completionPercent;// Draft inputs managed by the cubit
 String get optionDraft; String get criterionDraft; double get criterionWeightDraft;
/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionEditorStateCopyWith<DecisionEditorState> get copyWith => _$DecisionEditorStateCopyWithImpl<DecisionEditorState>(this as DecisionEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionEditorState&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isEvaluated, isEvaluated) || other.isEvaluated == isEvaluated)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.missingScores, missingScores) || other.missingScores == missingScores)&&(identical(other.hasMinOptions, hasMinOptions) || other.hasMinOptions == hasMinOptions)&&(identical(other.hasCriteria, hasCriteria) || other.hasCriteria == hasCriteria)&&(identical(other.canEvaluate, canEvaluate) || other.canEvaluate == canEvaluate)&&(identical(other.completionPercent, completionPercent) || other.completionPercent == completionPercent)&&(identical(other.optionDraft, optionDraft) || other.optionDraft == optionDraft)&&(identical(other.criterionDraft, criterionDraft) || other.criterionDraft == criterionDraft)&&(identical(other.criterionWeightDraft, criterionWeightDraft) || other.criterionWeightDraft == criterionWeightDraft));
}


@override
int get hashCode => Object.hash(runtimeType,decision,isLoading,isSaving,isEvaluated,isDirty,errorMessage,missingScores,hasMinOptions,hasCriteria,canEvaluate,completionPercent,optionDraft,criterionDraft,criterionWeightDraft);

@override
String toString() {
  return 'DecisionEditorState(decision: $decision, isLoading: $isLoading, isSaving: $isSaving, isEvaluated: $isEvaluated, isDirty: $isDirty, errorMessage: $errorMessage, missingScores: $missingScores, hasMinOptions: $hasMinOptions, hasCriteria: $hasCriteria, canEvaluate: $canEvaluate, completionPercent: $completionPercent, optionDraft: $optionDraft, criterionDraft: $criterionDraft, criterionWeightDraft: $criterionWeightDraft)';
}


}

/// @nodoc
abstract mixin class $DecisionEditorStateCopyWith<$Res>  {
  factory $DecisionEditorStateCopyWith(DecisionEditorState value, $Res Function(DecisionEditorState) _then) = _$DecisionEditorStateCopyWithImpl;
@useResult
$Res call({
 Decision? decision, bool isLoading, bool isSaving, bool isEvaluated, bool isDirty, String? errorMessage, int missingScores, bool hasMinOptions, bool hasCriteria, bool canEvaluate, int completionPercent, String optionDraft, String criterionDraft, double criterionWeightDraft
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
@pragma('vm:prefer-inline') @override $Res call({Object? decision = freezed,Object? isLoading = null,Object? isSaving = null,Object? isEvaluated = null,Object? isDirty = null,Object? errorMessage = freezed,Object? missingScores = null,Object? hasMinOptions = null,Object? hasCriteria = null,Object? canEvaluate = null,Object? completionPercent = null,Object? optionDraft = null,Object? criterionDraft = null,Object? criterionWeightDraft = null,}) {
  return _then(_self.copyWith(
decision: freezed == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as Decision?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isEvaluated: null == isEvaluated ? _self.isEvaluated : isEvaluated // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,missingScores: null == missingScores ? _self.missingScores : missingScores // ignore: cast_nullable_to_non_nullable
as int,hasMinOptions: null == hasMinOptions ? _self.hasMinOptions : hasMinOptions // ignore: cast_nullable_to_non_nullable
as bool,hasCriteria: null == hasCriteria ? _self.hasCriteria : hasCriteria // ignore: cast_nullable_to_non_nullable
as bool,canEvaluate: null == canEvaluate ? _self.canEvaluate : canEvaluate // ignore: cast_nullable_to_non_nullable
as bool,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,optionDraft: null == optionDraft ? _self.optionDraft : optionDraft // ignore: cast_nullable_to_non_nullable
as String,criterionDraft: null == criterionDraft ? _self.criterionDraft : criterionDraft // ignore: cast_nullable_to_non_nullable
as String,criterionWeightDraft: null == criterionWeightDraft ? _self.criterionWeightDraft : criterionWeightDraft // ignore: cast_nullable_to_non_nullable
as double,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Decision? decision,  bool isLoading,  bool isSaving,  bool isEvaluated,  bool isDirty,  String? errorMessage,  int missingScores,  bool hasMinOptions,  bool hasCriteria,  bool canEvaluate,  int completionPercent,  String optionDraft,  String criterionDraft,  double criterionWeightDraft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionEditorState() when $default != null:
return $default(_that.decision,_that.isLoading,_that.isSaving,_that.isEvaluated,_that.isDirty,_that.errorMessage,_that.missingScores,_that.hasMinOptions,_that.hasCriteria,_that.canEvaluate,_that.completionPercent,_that.optionDraft,_that.criterionDraft,_that.criterionWeightDraft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Decision? decision,  bool isLoading,  bool isSaving,  bool isEvaluated,  bool isDirty,  String? errorMessage,  int missingScores,  bool hasMinOptions,  bool hasCriteria,  bool canEvaluate,  int completionPercent,  String optionDraft,  String criterionDraft,  double criterionWeightDraft)  $default,) {final _that = this;
switch (_that) {
case _DecisionEditorState():
return $default(_that.decision,_that.isLoading,_that.isSaving,_that.isEvaluated,_that.isDirty,_that.errorMessage,_that.missingScores,_that.hasMinOptions,_that.hasCriteria,_that.canEvaluate,_that.completionPercent,_that.optionDraft,_that.criterionDraft,_that.criterionWeightDraft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Decision? decision,  bool isLoading,  bool isSaving,  bool isEvaluated,  bool isDirty,  String? errorMessage,  int missingScores,  bool hasMinOptions,  bool hasCriteria,  bool canEvaluate,  int completionPercent,  String optionDraft,  String criterionDraft,  double criterionWeightDraft)?  $default,) {final _that = this;
switch (_that) {
case _DecisionEditorState() when $default != null:
return $default(_that.decision,_that.isLoading,_that.isSaving,_that.isEvaluated,_that.isDirty,_that.errorMessage,_that.missingScores,_that.hasMinOptions,_that.hasCriteria,_that.canEvaluate,_that.completionPercent,_that.optionDraft,_that.criterionDraft,_that.criterionWeightDraft);case _:
  return null;

}
}

}

/// @nodoc


class _DecisionEditorState implements DecisionEditorState {
  const _DecisionEditorState({this.decision, this.isLoading = false, this.isSaving = false, this.isEvaluated = false, this.isDirty = false, this.errorMessage, this.missingScores = 0, this.hasMinOptions = false, this.hasCriteria = false, this.canEvaluate = false, this.completionPercent = 0, this.optionDraft = '', this.criterionDraft = '', this.criterionWeightDraft = 1.0});
  

@override final  Decision? decision;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isEvaluated;
@override@JsonKey() final  bool isDirty;
@override final  String? errorMessage;
// Derived validation/status fields
@override@JsonKey() final  int missingScores;
@override@JsonKey() final  bool hasMinOptions;
@override@JsonKey() final  bool hasCriteria;
@override@JsonKey() final  bool canEvaluate;
@override@JsonKey() final  int completionPercent;
// Draft inputs managed by the cubit
@override@JsonKey() final  String optionDraft;
@override@JsonKey() final  String criterionDraft;
@override@JsonKey() final  double criterionWeightDraft;

/// Create a copy of DecisionEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionEditorStateCopyWith<_DecisionEditorState> get copyWith => __$DecisionEditorStateCopyWithImpl<_DecisionEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionEditorState&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isEvaluated, isEvaluated) || other.isEvaluated == isEvaluated)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.missingScores, missingScores) || other.missingScores == missingScores)&&(identical(other.hasMinOptions, hasMinOptions) || other.hasMinOptions == hasMinOptions)&&(identical(other.hasCriteria, hasCriteria) || other.hasCriteria == hasCriteria)&&(identical(other.canEvaluate, canEvaluate) || other.canEvaluate == canEvaluate)&&(identical(other.completionPercent, completionPercent) || other.completionPercent == completionPercent)&&(identical(other.optionDraft, optionDraft) || other.optionDraft == optionDraft)&&(identical(other.criterionDraft, criterionDraft) || other.criterionDraft == criterionDraft)&&(identical(other.criterionWeightDraft, criterionWeightDraft) || other.criterionWeightDraft == criterionWeightDraft));
}


@override
int get hashCode => Object.hash(runtimeType,decision,isLoading,isSaving,isEvaluated,isDirty,errorMessage,missingScores,hasMinOptions,hasCriteria,canEvaluate,completionPercent,optionDraft,criterionDraft,criterionWeightDraft);

@override
String toString() {
  return 'DecisionEditorState(decision: $decision, isLoading: $isLoading, isSaving: $isSaving, isEvaluated: $isEvaluated, isDirty: $isDirty, errorMessage: $errorMessage, missingScores: $missingScores, hasMinOptions: $hasMinOptions, hasCriteria: $hasCriteria, canEvaluate: $canEvaluate, completionPercent: $completionPercent, optionDraft: $optionDraft, criterionDraft: $criterionDraft, criterionWeightDraft: $criterionWeightDraft)';
}


}

/// @nodoc
abstract mixin class _$DecisionEditorStateCopyWith<$Res> implements $DecisionEditorStateCopyWith<$Res> {
  factory _$DecisionEditorStateCopyWith(_DecisionEditorState value, $Res Function(_DecisionEditorState) _then) = __$DecisionEditorStateCopyWithImpl;
@override @useResult
$Res call({
 Decision? decision, bool isLoading, bool isSaving, bool isEvaluated, bool isDirty, String? errorMessage, int missingScores, bool hasMinOptions, bool hasCriteria, bool canEvaluate, int completionPercent, String optionDraft, String criterionDraft, double criterionWeightDraft
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
@override @pragma('vm:prefer-inline') $Res call({Object? decision = freezed,Object? isLoading = null,Object? isSaving = null,Object? isEvaluated = null,Object? isDirty = null,Object? errorMessage = freezed,Object? missingScores = null,Object? hasMinOptions = null,Object? hasCriteria = null,Object? canEvaluate = null,Object? completionPercent = null,Object? optionDraft = null,Object? criterionDraft = null,Object? criterionWeightDraft = null,}) {
  return _then(_DecisionEditorState(
decision: freezed == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as Decision?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isEvaluated: null == isEvaluated ? _self.isEvaluated : isEvaluated // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,missingScores: null == missingScores ? _self.missingScores : missingScores // ignore: cast_nullable_to_non_nullable
as int,hasMinOptions: null == hasMinOptions ? _self.hasMinOptions : hasMinOptions // ignore: cast_nullable_to_non_nullable
as bool,hasCriteria: null == hasCriteria ? _self.hasCriteria : hasCriteria // ignore: cast_nullable_to_non_nullable
as bool,canEvaluate: null == canEvaluate ? _self.canEvaluate : canEvaluate // ignore: cast_nullable_to_non_nullable
as bool,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,optionDraft: null == optionDraft ? _self.optionDraft : optionDraft // ignore: cast_nullable_to_non_nullable
as String,criterionDraft: null == criterionDraft ? _self.criterionDraft : criterionDraft // ignore: cast_nullable_to_non_nullable
as String,criterionWeightDraft: null == criterionWeightDraft ? _self.criterionWeightDraft : criterionWeightDraft // ignore: cast_nullable_to_non_nullable
as double,
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
