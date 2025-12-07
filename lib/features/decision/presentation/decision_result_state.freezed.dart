// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RankingEntry {

 OptionId get optionId; String get label; double get score;
/// Create a copy of RankingEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingEntryCopyWith<RankingEntry> get copyWith => _$RankingEntryCopyWithImpl<RankingEntry>(this as RankingEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingEntry&&(identical(other.optionId, optionId) || other.optionId == optionId)&&(identical(other.label, label) || other.label == label)&&(identical(other.score, score) || other.score == score));
}


@override
int get hashCode => Object.hash(runtimeType,optionId,label,score);

@override
String toString() {
  return 'RankingEntry(optionId: $optionId, label: $label, score: $score)';
}


}

/// @nodoc
abstract mixin class $RankingEntryCopyWith<$Res>  {
  factory $RankingEntryCopyWith(RankingEntry value, $Res Function(RankingEntry) _then) = _$RankingEntryCopyWithImpl;
@useResult
$Res call({
 OptionId optionId, String label, double score
});




}
/// @nodoc
class _$RankingEntryCopyWithImpl<$Res>
    implements $RankingEntryCopyWith<$Res> {
  _$RankingEntryCopyWithImpl(this._self, this._then);

  final RankingEntry _self;
  final $Res Function(RankingEntry) _then;

/// Create a copy of RankingEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionId = null,Object? label = null,Object? score = null,}) {
  return _then(_self.copyWith(
optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as OptionId,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingEntry].
extension RankingEntryPatterns on RankingEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingEntry value)  $default,){
final _that = this;
switch (_that) {
case _RankingEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RankingEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OptionId optionId,  String label,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingEntry() when $default != null:
return $default(_that.optionId,_that.label,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OptionId optionId,  String label,  double score)  $default,) {final _that = this;
switch (_that) {
case _RankingEntry():
return $default(_that.optionId,_that.label,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OptionId optionId,  String label,  double score)?  $default,) {final _that = this;
switch (_that) {
case _RankingEntry() when $default != null:
return $default(_that.optionId,_that.label,_that.score);case _:
  return null;

}
}

}

/// @nodoc


class _RankingEntry implements RankingEntry {
  const _RankingEntry({required this.optionId, required this.label, required this.score});
  

@override final  OptionId optionId;
@override final  String label;
@override final  double score;

/// Create a copy of RankingEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingEntryCopyWith<_RankingEntry> get copyWith => __$RankingEntryCopyWithImpl<_RankingEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingEntry&&(identical(other.optionId, optionId) || other.optionId == optionId)&&(identical(other.label, label) || other.label == label)&&(identical(other.score, score) || other.score == score));
}


@override
int get hashCode => Object.hash(runtimeType,optionId,label,score);

@override
String toString() {
  return 'RankingEntry(optionId: $optionId, label: $label, score: $score)';
}


}

/// @nodoc
abstract mixin class _$RankingEntryCopyWith<$Res> implements $RankingEntryCopyWith<$Res> {
  factory _$RankingEntryCopyWith(_RankingEntry value, $Res Function(_RankingEntry) _then) = __$RankingEntryCopyWithImpl;
@override @useResult
$Res call({
 OptionId optionId, String label, double score
});




}
/// @nodoc
class __$RankingEntryCopyWithImpl<$Res>
    implements _$RankingEntryCopyWith<$Res> {
  __$RankingEntryCopyWithImpl(this._self, this._then);

  final _RankingEntry _self;
  final $Res Function(_RankingEntry) _then;

/// Create a copy of RankingEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionId = null,Object? label = null,Object? score = null,}) {
  return _then(_RankingEntry(
optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as OptionId,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$DecisionResultState {

 Decision get decision; List<RankingEntry> get ranking; RankingEntry? get best; double get errorRate; double? get ahpConsistency; double? get stability; double? get fuzzyOverlapReliability; double? get marginReliability; double? get combinedReliability;
/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionResultStateCopyWith<DecisionResultState> get copyWith => _$DecisionResultStateCopyWithImpl<DecisionResultState>(this as DecisionResultState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionResultState&&(identical(other.decision, decision) || other.decision == decision)&&const DeepCollectionEquality().equals(other.ranking, ranking)&&(identical(other.best, best) || other.best == best)&&(identical(other.errorRate, errorRate) || other.errorRate == errorRate)&&(identical(other.ahpConsistency, ahpConsistency) || other.ahpConsistency == ahpConsistency)&&(identical(other.stability, stability) || other.stability == stability)&&(identical(other.fuzzyOverlapReliability, fuzzyOverlapReliability) || other.fuzzyOverlapReliability == fuzzyOverlapReliability)&&(identical(other.marginReliability, marginReliability) || other.marginReliability == marginReliability)&&(identical(other.combinedReliability, combinedReliability) || other.combinedReliability == combinedReliability));
}


@override
int get hashCode => Object.hash(runtimeType,decision,const DeepCollectionEquality().hash(ranking),best,errorRate,ahpConsistency,stability,fuzzyOverlapReliability,marginReliability,combinedReliability);

@override
String toString() {
  return 'DecisionResultState(decision: $decision, ranking: $ranking, best: $best, errorRate: $errorRate, ahpConsistency: $ahpConsistency, stability: $stability, fuzzyOverlapReliability: $fuzzyOverlapReliability, marginReliability: $marginReliability, combinedReliability: $combinedReliability)';
}


}

/// @nodoc
abstract mixin class $DecisionResultStateCopyWith<$Res>  {
  factory $DecisionResultStateCopyWith(DecisionResultState value, $Res Function(DecisionResultState) _then) = _$DecisionResultStateCopyWithImpl;
@useResult
$Res call({
 Decision decision, List<RankingEntry> ranking, RankingEntry? best, double errorRate, double? ahpConsistency, double? stability, double? fuzzyOverlapReliability, double? marginReliability, double? combinedReliability
});


$DecisionCopyWith<$Res> get decision;$RankingEntryCopyWith<$Res>? get best;

}
/// @nodoc
class _$DecisionResultStateCopyWithImpl<$Res>
    implements $DecisionResultStateCopyWith<$Res> {
  _$DecisionResultStateCopyWithImpl(this._self, this._then);

  final DecisionResultState _self;
  final $Res Function(DecisionResultState) _then;

/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decision = null,Object? ranking = null,Object? best = freezed,Object? errorRate = null,Object? ahpConsistency = freezed,Object? stability = freezed,Object? fuzzyOverlapReliability = freezed,Object? marginReliability = freezed,Object? combinedReliability = freezed,}) {
  return _then(_self.copyWith(
decision: null == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as Decision,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as List<RankingEntry>,best: freezed == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as RankingEntry?,errorRate: null == errorRate ? _self.errorRate : errorRate // ignore: cast_nullable_to_non_nullable
as double,ahpConsistency: freezed == ahpConsistency ? _self.ahpConsistency : ahpConsistency // ignore: cast_nullable_to_non_nullable
as double?,stability: freezed == stability ? _self.stability : stability // ignore: cast_nullable_to_non_nullable
as double?,fuzzyOverlapReliability: freezed == fuzzyOverlapReliability ? _self.fuzzyOverlapReliability : fuzzyOverlapReliability // ignore: cast_nullable_to_non_nullable
as double?,marginReliability: freezed == marginReliability ? _self.marginReliability : marginReliability // ignore: cast_nullable_to_non_nullable
as double?,combinedReliability: freezed == combinedReliability ? _self.combinedReliability : combinedReliability // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DecisionCopyWith<$Res> get decision {
  
  return $DecisionCopyWith<$Res>(_self.decision, (value) {
    return _then(_self.copyWith(decision: value));
  });
}/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingEntryCopyWith<$Res>? get best {
    if (_self.best == null) {
    return null;
  }

  return $RankingEntryCopyWith<$Res>(_self.best!, (value) {
    return _then(_self.copyWith(best: value));
  });
}
}


/// Adds pattern-matching-related methods to [DecisionResultState].
extension DecisionResultStatePatterns on DecisionResultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionResultState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionResultState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionResultState value)  $default,){
final _that = this;
switch (_that) {
case _DecisionResultState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionResultState value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionResultState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Decision decision,  List<RankingEntry> ranking,  RankingEntry? best,  double errorRate,  double? ahpConsistency,  double? stability,  double? fuzzyOverlapReliability,  double? marginReliability,  double? combinedReliability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionResultState() when $default != null:
return $default(_that.decision,_that.ranking,_that.best,_that.errorRate,_that.ahpConsistency,_that.stability,_that.fuzzyOverlapReliability,_that.marginReliability,_that.combinedReliability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Decision decision,  List<RankingEntry> ranking,  RankingEntry? best,  double errorRate,  double? ahpConsistency,  double? stability,  double? fuzzyOverlapReliability,  double? marginReliability,  double? combinedReliability)  $default,) {final _that = this;
switch (_that) {
case _DecisionResultState():
return $default(_that.decision,_that.ranking,_that.best,_that.errorRate,_that.ahpConsistency,_that.stability,_that.fuzzyOverlapReliability,_that.marginReliability,_that.combinedReliability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Decision decision,  List<RankingEntry> ranking,  RankingEntry? best,  double errorRate,  double? ahpConsistency,  double? stability,  double? fuzzyOverlapReliability,  double? marginReliability,  double? combinedReliability)?  $default,) {final _that = this;
switch (_that) {
case _DecisionResultState() when $default != null:
return $default(_that.decision,_that.ranking,_that.best,_that.errorRate,_that.ahpConsistency,_that.stability,_that.fuzzyOverlapReliability,_that.marginReliability,_that.combinedReliability);case _:
  return null;

}
}

}

/// @nodoc


class _DecisionResultState extends DecisionResultState {
  const _DecisionResultState({required this.decision, required final  List<RankingEntry> ranking, this.best, this.errorRate = 0, this.ahpConsistency, this.stability, this.fuzzyOverlapReliability, this.marginReliability, this.combinedReliability}): _ranking = ranking,super._();
  

@override final  Decision decision;
 final  List<RankingEntry> _ranking;
@override List<RankingEntry> get ranking {
  if (_ranking is EqualUnmodifiableListView) return _ranking;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ranking);
}

@override final  RankingEntry? best;
@override@JsonKey() final  double errorRate;
@override final  double? ahpConsistency;
@override final  double? stability;
@override final  double? fuzzyOverlapReliability;
@override final  double? marginReliability;
@override final  double? combinedReliability;

/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionResultStateCopyWith<_DecisionResultState> get copyWith => __$DecisionResultStateCopyWithImpl<_DecisionResultState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionResultState&&(identical(other.decision, decision) || other.decision == decision)&&const DeepCollectionEquality().equals(other._ranking, _ranking)&&(identical(other.best, best) || other.best == best)&&(identical(other.errorRate, errorRate) || other.errorRate == errorRate)&&(identical(other.ahpConsistency, ahpConsistency) || other.ahpConsistency == ahpConsistency)&&(identical(other.stability, stability) || other.stability == stability)&&(identical(other.fuzzyOverlapReliability, fuzzyOverlapReliability) || other.fuzzyOverlapReliability == fuzzyOverlapReliability)&&(identical(other.marginReliability, marginReliability) || other.marginReliability == marginReliability)&&(identical(other.combinedReliability, combinedReliability) || other.combinedReliability == combinedReliability));
}


@override
int get hashCode => Object.hash(runtimeType,decision,const DeepCollectionEquality().hash(_ranking),best,errorRate,ahpConsistency,stability,fuzzyOverlapReliability,marginReliability,combinedReliability);

@override
String toString() {
  return 'DecisionResultState(decision: $decision, ranking: $ranking, best: $best, errorRate: $errorRate, ahpConsistency: $ahpConsistency, stability: $stability, fuzzyOverlapReliability: $fuzzyOverlapReliability, marginReliability: $marginReliability, combinedReliability: $combinedReliability)';
}


}

/// @nodoc
abstract mixin class _$DecisionResultStateCopyWith<$Res> implements $DecisionResultStateCopyWith<$Res> {
  factory _$DecisionResultStateCopyWith(_DecisionResultState value, $Res Function(_DecisionResultState) _then) = __$DecisionResultStateCopyWithImpl;
@override @useResult
$Res call({
 Decision decision, List<RankingEntry> ranking, RankingEntry? best, double errorRate, double? ahpConsistency, double? stability, double? fuzzyOverlapReliability, double? marginReliability, double? combinedReliability
});


@override $DecisionCopyWith<$Res> get decision;@override $RankingEntryCopyWith<$Res>? get best;

}
/// @nodoc
class __$DecisionResultStateCopyWithImpl<$Res>
    implements _$DecisionResultStateCopyWith<$Res> {
  __$DecisionResultStateCopyWithImpl(this._self, this._then);

  final _DecisionResultState _self;
  final $Res Function(_DecisionResultState) _then;

/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decision = null,Object? ranking = null,Object? best = freezed,Object? errorRate = null,Object? ahpConsistency = freezed,Object? stability = freezed,Object? fuzzyOverlapReliability = freezed,Object? marginReliability = freezed,Object? combinedReliability = freezed,}) {
  return _then(_DecisionResultState(
decision: null == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as Decision,ranking: null == ranking ? _self._ranking : ranking // ignore: cast_nullable_to_non_nullable
as List<RankingEntry>,best: freezed == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as RankingEntry?,errorRate: null == errorRate ? _self.errorRate : errorRate // ignore: cast_nullable_to_non_nullable
as double,ahpConsistency: freezed == ahpConsistency ? _self.ahpConsistency : ahpConsistency // ignore: cast_nullable_to_non_nullable
as double?,stability: freezed == stability ? _self.stability : stability // ignore: cast_nullable_to_non_nullable
as double?,fuzzyOverlapReliability: freezed == fuzzyOverlapReliability ? _self.fuzzyOverlapReliability : fuzzyOverlapReliability // ignore: cast_nullable_to_non_nullable
as double?,marginReliability: freezed == marginReliability ? _self.marginReliability : marginReliability // ignore: cast_nullable_to_non_nullable
as double?,combinedReliability: freezed == combinedReliability ? _self.combinedReliability : combinedReliability // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DecisionCopyWith<$Res> get decision {
  
  return $DecisionCopyWith<$Res>(_self.decision, (value) {
    return _then(_self.copyWith(decision: value));
  });
}/// Create a copy of DecisionResultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingEntryCopyWith<$Res>? get best {
    if (_self.best == null) {
    return null;
  }

  return $RankingEntryCopyWith<$Res>(_self.best!, (value) {
    return _then(_self.copyWith(best: value));
  });
}
}

// dart format on
