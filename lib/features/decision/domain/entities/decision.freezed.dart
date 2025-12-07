// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DecisionOption {

 OptionId get id; String get label; String? get description;
/// Create a copy of DecisionOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionOptionCopyWith<DecisionOption> get copyWith => _$DecisionOptionCopyWithImpl<DecisionOption>(this as DecisionOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,description);

@override
String toString() {
  return 'DecisionOption(id: $id, label: $label, description: $description)';
}


}

/// @nodoc
abstract mixin class $DecisionOptionCopyWith<$Res>  {
  factory $DecisionOptionCopyWith(DecisionOption value, $Res Function(DecisionOption) _then) = _$DecisionOptionCopyWithImpl;
@useResult
$Res call({
 OptionId id, String label, String? description
});




}
/// @nodoc
class _$DecisionOptionCopyWithImpl<$Res>
    implements $DecisionOptionCopyWith<$Res> {
  _$DecisionOptionCopyWithImpl(this._self, this._then);

  final DecisionOption _self;
  final $Res Function(DecisionOption) _then;

/// Create a copy of DecisionOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as OptionId,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DecisionOption].
extension DecisionOptionPatterns on DecisionOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionOption value)  $default,){
final _that = this;
switch (_that) {
case _DecisionOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionOption value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OptionId id,  String label,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionOption() when $default != null:
return $default(_that.id,_that.label,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OptionId id,  String label,  String? description)  $default,) {final _that = this;
switch (_that) {
case _DecisionOption():
return $default(_that.id,_that.label,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OptionId id,  String label,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _DecisionOption() when $default != null:
return $default(_that.id,_that.label,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _DecisionOption implements DecisionOption {
  const _DecisionOption({required this.id, required this.label, this.description});
  

@override final  OptionId id;
@override final  String label;
@override final  String? description;

/// Create a copy of DecisionOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionOptionCopyWith<_DecisionOption> get copyWith => __$DecisionOptionCopyWithImpl<_DecisionOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,description);

@override
String toString() {
  return 'DecisionOption(id: $id, label: $label, description: $description)';
}


}

/// @nodoc
abstract mixin class _$DecisionOptionCopyWith<$Res> implements $DecisionOptionCopyWith<$Res> {
  factory _$DecisionOptionCopyWith(_DecisionOption value, $Res Function(_DecisionOption) _then) = __$DecisionOptionCopyWithImpl;
@override @useResult
$Res call({
 OptionId id, String label, String? description
});




}
/// @nodoc
class __$DecisionOptionCopyWithImpl<$Res>
    implements _$DecisionOptionCopyWith<$Res> {
  __$DecisionOptionCopyWithImpl(this._self, this._then);

  final _DecisionOption _self;
  final $Res Function(_DecisionOption) _then;

/// Create a copy of DecisionOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? description = freezed,}) {
  return _then(_DecisionOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as OptionId,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$DecisionCriterion {

 CriterionId get id; String get label; double get weight;
/// Create a copy of DecisionCriterion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionCriterionCopyWith<DecisionCriterion> get copyWith => _$DecisionCriterionCopyWithImpl<DecisionCriterion>(this as DecisionCriterion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionCriterion&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.weight, weight) || other.weight == weight));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,weight);

@override
String toString() {
  return 'DecisionCriterion(id: $id, label: $label, weight: $weight)';
}


}

/// @nodoc
abstract mixin class $DecisionCriterionCopyWith<$Res>  {
  factory $DecisionCriterionCopyWith(DecisionCriterion value, $Res Function(DecisionCriterion) _then) = _$DecisionCriterionCopyWithImpl;
@useResult
$Res call({
 CriterionId id, String label, double weight
});




}
/// @nodoc
class _$DecisionCriterionCopyWithImpl<$Res>
    implements $DecisionCriterionCopyWith<$Res> {
  _$DecisionCriterionCopyWithImpl(this._self, this._then);

  final DecisionCriterion _self;
  final $Res Function(DecisionCriterion) _then;

/// Create a copy of DecisionCriterion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? weight = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as CriterionId,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DecisionCriterion].
extension DecisionCriterionPatterns on DecisionCriterion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionCriterion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionCriterion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionCriterion value)  $default,){
final _that = this;
switch (_that) {
case _DecisionCriterion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionCriterion value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionCriterion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CriterionId id,  String label,  double weight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionCriterion() when $default != null:
return $default(_that.id,_that.label,_that.weight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CriterionId id,  String label,  double weight)  $default,) {final _that = this;
switch (_that) {
case _DecisionCriterion():
return $default(_that.id,_that.label,_that.weight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CriterionId id,  String label,  double weight)?  $default,) {final _that = this;
switch (_that) {
case _DecisionCriterion() when $default != null:
return $default(_that.id,_that.label,_that.weight);case _:
  return null;

}
}

}

/// @nodoc


class _DecisionCriterion implements DecisionCriterion {
  const _DecisionCriterion({required this.id, required this.label, this.weight = 1.0});
  

@override final  CriterionId id;
@override final  String label;
@override@JsonKey() final  double weight;

/// Create a copy of DecisionCriterion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionCriterionCopyWith<_DecisionCriterion> get copyWith => __$DecisionCriterionCopyWithImpl<_DecisionCriterion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionCriterion&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.weight, weight) || other.weight == weight));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,weight);

@override
String toString() {
  return 'DecisionCriterion(id: $id, label: $label, weight: $weight)';
}


}

/// @nodoc
abstract mixin class _$DecisionCriterionCopyWith<$Res> implements $DecisionCriterionCopyWith<$Res> {
  factory _$DecisionCriterionCopyWith(_DecisionCriterion value, $Res Function(_DecisionCriterion) _then) = __$DecisionCriterionCopyWithImpl;
@override @useResult
$Res call({
 CriterionId id, String label, double weight
});




}
/// @nodoc
class __$DecisionCriterionCopyWithImpl<$Res>
    implements _$DecisionCriterionCopyWith<$Res> {
  __$DecisionCriterionCopyWithImpl(this._self, this._then);

  final _DecisionCriterion _self;
  final $Res Function(_DecisionCriterion) _then;

/// Create a copy of DecisionCriterion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? weight = null,}) {
  return _then(_DecisionCriterion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as CriterionId,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$DecisionResult {

 OptionId get bestOptionId; Map<OptionId, double> get scores; List<OptionId> get ranking; double get errorRate; Map<String, dynamic>? get debug;
/// Create a copy of DecisionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionResultCopyWith<DecisionResult> get copyWith => _$DecisionResultCopyWithImpl<DecisionResult>(this as DecisionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionResult&&(identical(other.bestOptionId, bestOptionId) || other.bestOptionId == bestOptionId)&&const DeepCollectionEquality().equals(other.scores, scores)&&const DeepCollectionEquality().equals(other.ranking, ranking)&&(identical(other.errorRate, errorRate) || other.errorRate == errorRate)&&const DeepCollectionEquality().equals(other.debug, debug));
}


@override
int get hashCode => Object.hash(runtimeType,bestOptionId,const DeepCollectionEquality().hash(scores),const DeepCollectionEquality().hash(ranking),errorRate,const DeepCollectionEquality().hash(debug));

@override
String toString() {
  return 'DecisionResult(bestOptionId: $bestOptionId, scores: $scores, ranking: $ranking, errorRate: $errorRate, debug: $debug)';
}


}

/// @nodoc
abstract mixin class $DecisionResultCopyWith<$Res>  {
  factory $DecisionResultCopyWith(DecisionResult value, $Res Function(DecisionResult) _then) = _$DecisionResultCopyWithImpl;
@useResult
$Res call({
 OptionId bestOptionId, Map<OptionId, double> scores, List<OptionId> ranking, double errorRate, Map<String, dynamic>? debug
});




}
/// @nodoc
class _$DecisionResultCopyWithImpl<$Res>
    implements $DecisionResultCopyWith<$Res> {
  _$DecisionResultCopyWithImpl(this._self, this._then);

  final DecisionResult _self;
  final $Res Function(DecisionResult) _then;

/// Create a copy of DecisionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bestOptionId = null,Object? scores = null,Object? ranking = null,Object? errorRate = null,Object? debug = freezed,}) {
  return _then(_self.copyWith(
bestOptionId: null == bestOptionId ? _self.bestOptionId : bestOptionId // ignore: cast_nullable_to_non_nullable
as OptionId,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as Map<OptionId, double>,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as List<OptionId>,errorRate: null == errorRate ? _self.errorRate : errorRate // ignore: cast_nullable_to_non_nullable
as double,debug: freezed == debug ? _self.debug : debug // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [DecisionResult].
extension DecisionResultPatterns on DecisionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionResult value)  $default,){
final _that = this;
switch (_that) {
case _DecisionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionResult value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OptionId bestOptionId,  Map<OptionId, double> scores,  List<OptionId> ranking,  double errorRate,  Map<String, dynamic>? debug)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionResult() when $default != null:
return $default(_that.bestOptionId,_that.scores,_that.ranking,_that.errorRate,_that.debug);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OptionId bestOptionId,  Map<OptionId, double> scores,  List<OptionId> ranking,  double errorRate,  Map<String, dynamic>? debug)  $default,) {final _that = this;
switch (_that) {
case _DecisionResult():
return $default(_that.bestOptionId,_that.scores,_that.ranking,_that.errorRate,_that.debug);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OptionId bestOptionId,  Map<OptionId, double> scores,  List<OptionId> ranking,  double errorRate,  Map<String, dynamic>? debug)?  $default,) {final _that = this;
switch (_that) {
case _DecisionResult() when $default != null:
return $default(_that.bestOptionId,_that.scores,_that.ranking,_that.errorRate,_that.debug);case _:
  return null;

}
}

}

/// @nodoc


class _DecisionResult implements DecisionResult {
  const _DecisionResult({required this.bestOptionId, required final  Map<OptionId, double> scores, required final  List<OptionId> ranking, this.errorRate = 0.0, final  Map<String, dynamic>? debug}): _scores = scores,_ranking = ranking,_debug = debug;
  

@override final  OptionId bestOptionId;
 final  Map<OptionId, double> _scores;
@override Map<OptionId, double> get scores {
  if (_scores is EqualUnmodifiableMapView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scores);
}

 final  List<OptionId> _ranking;
@override List<OptionId> get ranking {
  if (_ranking is EqualUnmodifiableListView) return _ranking;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ranking);
}

@override@JsonKey() final  double errorRate;
 final  Map<String, dynamic>? _debug;
@override Map<String, dynamic>? get debug {
  final value = _debug;
  if (value == null) return null;
  if (_debug is EqualUnmodifiableMapView) return _debug;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of DecisionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionResultCopyWith<_DecisionResult> get copyWith => __$DecisionResultCopyWithImpl<_DecisionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionResult&&(identical(other.bestOptionId, bestOptionId) || other.bestOptionId == bestOptionId)&&const DeepCollectionEquality().equals(other._scores, _scores)&&const DeepCollectionEquality().equals(other._ranking, _ranking)&&(identical(other.errorRate, errorRate) || other.errorRate == errorRate)&&const DeepCollectionEquality().equals(other._debug, _debug));
}


@override
int get hashCode => Object.hash(runtimeType,bestOptionId,const DeepCollectionEquality().hash(_scores),const DeepCollectionEquality().hash(_ranking),errorRate,const DeepCollectionEquality().hash(_debug));

@override
String toString() {
  return 'DecisionResult(bestOptionId: $bestOptionId, scores: $scores, ranking: $ranking, errorRate: $errorRate, debug: $debug)';
}


}

/// @nodoc
abstract mixin class _$DecisionResultCopyWith<$Res> implements $DecisionResultCopyWith<$Res> {
  factory _$DecisionResultCopyWith(_DecisionResult value, $Res Function(_DecisionResult) _then) = __$DecisionResultCopyWithImpl;
@override @useResult
$Res call({
 OptionId bestOptionId, Map<OptionId, double> scores, List<OptionId> ranking, double errorRate, Map<String, dynamic>? debug
});




}
/// @nodoc
class __$DecisionResultCopyWithImpl<$Res>
    implements _$DecisionResultCopyWith<$Res> {
  __$DecisionResultCopyWithImpl(this._self, this._then);

  final _DecisionResult _self;
  final $Res Function(_DecisionResult) _then;

/// Create a copy of DecisionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bestOptionId = null,Object? scores = null,Object? ranking = null,Object? errorRate = null,Object? debug = freezed,}) {
  return _then(_DecisionResult(
bestOptionId: null == bestOptionId ? _self.bestOptionId : bestOptionId // ignore: cast_nullable_to_non_nullable
as OptionId,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as Map<OptionId, double>,ranking: null == ranking ? _self._ranking : ranking // ignore: cast_nullable_to_non_nullable
as List<OptionId>,errorRate: null == errorRate ? _self.errorRate : errorRate // ignore: cast_nullable_to_non_nullable
as double,debug: freezed == debug ? _self._debug : debug // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc
mixin _$Decision {

 DecisionId? get id; String get title; String? get description; DecisionMethod get method; List<DecisionOption> get options; List<DecisionCriterion> get criteria; Map<ScoreKey, double> get scores; List<List<double>>? get ahpMatrix; double? get fuzzySpread; DecisionResult? get result; DateTime? get createdAt; DateTime? get updatedAt; DateTime? get deletedAt;
/// Create a copy of Decision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionCopyWith<Decision> get copyWith => _$DecisionCopyWithImpl<Decision>(this as Decision, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Decision&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.criteria, criteria)&&const DeepCollectionEquality().equals(other.scores, scores)&&const DeepCollectionEquality().equals(other.ahpMatrix, ahpMatrix)&&(identical(other.fuzzySpread, fuzzySpread) || other.fuzzySpread == fuzzySpread)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,method,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(criteria),const DeepCollectionEquality().hash(scores),const DeepCollectionEquality().hash(ahpMatrix),fuzzySpread,result,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Decision(id: $id, title: $title, description: $description, method: $method, options: $options, criteria: $criteria, scores: $scores, ahpMatrix: $ahpMatrix, fuzzySpread: $fuzzySpread, result: $result, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $DecisionCopyWith<$Res>  {
  factory $DecisionCopyWith(Decision value, $Res Function(Decision) _then) = _$DecisionCopyWithImpl;
@useResult
$Res call({
 DecisionId? id, String title, String? description, DecisionMethod method, List<DecisionOption> options, List<DecisionCriterion> criteria, Map<ScoreKey, double> scores, List<List<double>>? ahpMatrix, double? fuzzySpread, DecisionResult? result, DateTime? createdAt, DateTime? updatedAt, DateTime? deletedAt
});


$DecisionResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$DecisionCopyWithImpl<$Res>
    implements $DecisionCopyWith<$Res> {
  _$DecisionCopyWithImpl(this._self, this._then);

  final Decision _self;
  final $Res Function(Decision) _then;

/// Create a copy of Decision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = freezed,Object? method = null,Object? options = null,Object? criteria = null,Object? scores = null,Object? ahpMatrix = freezed,Object? fuzzySpread = freezed,Object? result = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as DecisionId?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as DecisionMethod,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<DecisionOption>,criteria: null == criteria ? _self.criteria : criteria // ignore: cast_nullable_to_non_nullable
as List<DecisionCriterion>,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as Map<ScoreKey, double>,ahpMatrix: freezed == ahpMatrix ? _self.ahpMatrix : ahpMatrix // ignore: cast_nullable_to_non_nullable
as List<List<double>>?,fuzzySpread: freezed == fuzzySpread ? _self.fuzzySpread : fuzzySpread // ignore: cast_nullable_to_non_nullable
as double?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as DecisionResult?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Decision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DecisionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $DecisionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [Decision].
extension DecisionPatterns on Decision {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Decision value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Decision() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Decision value)  $default,){
final _that = this;
switch (_that) {
case _Decision():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Decision value)?  $default,){
final _that = this;
switch (_that) {
case _Decision() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DecisionId? id,  String title,  String? description,  DecisionMethod method,  List<DecisionOption> options,  List<DecisionCriterion> criteria,  Map<ScoreKey, double> scores,  List<List<double>>? ahpMatrix,  double? fuzzySpread,  DecisionResult? result,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Decision() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.method,_that.options,_that.criteria,_that.scores,_that.ahpMatrix,_that.fuzzySpread,_that.result,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DecisionId? id,  String title,  String? description,  DecisionMethod method,  List<DecisionOption> options,  List<DecisionCriterion> criteria,  Map<ScoreKey, double> scores,  List<List<double>>? ahpMatrix,  double? fuzzySpread,  DecisionResult? result,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Decision():
return $default(_that.id,_that.title,_that.description,_that.method,_that.options,_that.criteria,_that.scores,_that.ahpMatrix,_that.fuzzySpread,_that.result,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DecisionId? id,  String title,  String? description,  DecisionMethod method,  List<DecisionOption> options,  List<DecisionCriterion> criteria,  Map<ScoreKey, double> scores,  List<List<double>>? ahpMatrix,  double? fuzzySpread,  DecisionResult? result,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Decision() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.method,_that.options,_that.criteria,_that.scores,_that.ahpMatrix,_that.fuzzySpread,_that.result,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Decision implements Decision {
  const _Decision({this.id, required this.title, this.description, this.method = DecisionMethod.weightedSum, final  List<DecisionOption> options = const [], final  List<DecisionCriterion> criteria = const [], final  Map<ScoreKey, double> scores = const <ScoreKey, double>{}, final  List<List<double>>? ahpMatrix, this.fuzzySpread, this.result, this.createdAt, this.updatedAt, this.deletedAt}): _options = options,_criteria = criteria,_scores = scores,_ahpMatrix = ahpMatrix;
  

@override final  DecisionId? id;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  DecisionMethod method;
 final  List<DecisionOption> _options;
@override@JsonKey() List<DecisionOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  List<DecisionCriterion> _criteria;
@override@JsonKey() List<DecisionCriterion> get criteria {
  if (_criteria is EqualUnmodifiableListView) return _criteria;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_criteria);
}

 final  Map<ScoreKey, double> _scores;
@override@JsonKey() Map<ScoreKey, double> get scores {
  if (_scores is EqualUnmodifiableMapView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scores);
}

 final  List<List<double>>? _ahpMatrix;
@override List<List<double>>? get ahpMatrix {
  final value = _ahpMatrix;
  if (value == null) return null;
  if (_ahpMatrix is EqualUnmodifiableListView) return _ahpMatrix;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  double? fuzzySpread;
@override final  DecisionResult? result;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? deletedAt;

/// Create a copy of Decision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionCopyWith<_Decision> get copyWith => __$DecisionCopyWithImpl<_Decision>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Decision&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._criteria, _criteria)&&const DeepCollectionEquality().equals(other._scores, _scores)&&const DeepCollectionEquality().equals(other._ahpMatrix, _ahpMatrix)&&(identical(other.fuzzySpread, fuzzySpread) || other.fuzzySpread == fuzzySpread)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,method,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_criteria),const DeepCollectionEquality().hash(_scores),const DeepCollectionEquality().hash(_ahpMatrix),fuzzySpread,result,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Decision(id: $id, title: $title, description: $description, method: $method, options: $options, criteria: $criteria, scores: $scores, ahpMatrix: $ahpMatrix, fuzzySpread: $fuzzySpread, result: $result, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$DecisionCopyWith<$Res> implements $DecisionCopyWith<$Res> {
  factory _$DecisionCopyWith(_Decision value, $Res Function(_Decision) _then) = __$DecisionCopyWithImpl;
@override @useResult
$Res call({
 DecisionId? id, String title, String? description, DecisionMethod method, List<DecisionOption> options, List<DecisionCriterion> criteria, Map<ScoreKey, double> scores, List<List<double>>? ahpMatrix, double? fuzzySpread, DecisionResult? result, DateTime? createdAt, DateTime? updatedAt, DateTime? deletedAt
});


@override $DecisionResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$DecisionCopyWithImpl<$Res>
    implements _$DecisionCopyWith<$Res> {
  __$DecisionCopyWithImpl(this._self, this._then);

  final _Decision _self;
  final $Res Function(_Decision) _then;

/// Create a copy of Decision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = freezed,Object? method = null,Object? options = null,Object? criteria = null,Object? scores = null,Object? ahpMatrix = freezed,Object? fuzzySpread = freezed,Object? result = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_Decision(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as DecisionId?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as DecisionMethod,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<DecisionOption>,criteria: null == criteria ? _self._criteria : criteria // ignore: cast_nullable_to_non_nullable
as List<DecisionCriterion>,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as Map<ScoreKey, double>,ahpMatrix: freezed == ahpMatrix ? _self._ahpMatrix : ahpMatrix // ignore: cast_nullable_to_non_nullable
as List<List<double>>?,fuzzySpread: freezed == fuzzySpread ? _self.fuzzySpread : fuzzySpread // ignore: cast_nullable_to_non_nullable
as double?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as DecisionResult?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Decision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DecisionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $DecisionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
