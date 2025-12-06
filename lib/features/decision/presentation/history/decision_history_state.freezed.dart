// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DecisionHistoryState {

 List<Decision> get decisions; bool get isLoading; bool get isLoadingMore; bool get isDeleting; bool get hasMore; int get page; String get searchTerm; String? get errorMessage;
/// Create a copy of DecisionHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionHistoryStateCopyWith<DecisionHistoryState> get copyWith => _$DecisionHistoryStateCopyWithImpl<DecisionHistoryState>(this as DecisionHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionHistoryState&&const DeepCollectionEquality().equals(other.decisions, decisions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(decisions),isLoading,isLoadingMore,isDeleting,hasMore,page,searchTerm,errorMessage);

@override
String toString() {
  return 'DecisionHistoryState(decisions: $decisions, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isDeleting: $isDeleting, hasMore: $hasMore, page: $page, searchTerm: $searchTerm, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DecisionHistoryStateCopyWith<$Res>  {
  factory $DecisionHistoryStateCopyWith(DecisionHistoryState value, $Res Function(DecisionHistoryState) _then) = _$DecisionHistoryStateCopyWithImpl;
@useResult
$Res call({
 List<Decision> decisions, bool isLoading, bool isLoadingMore, bool isDeleting, bool hasMore, int page, String searchTerm, String? errorMessage
});




}
/// @nodoc
class _$DecisionHistoryStateCopyWithImpl<$Res>
    implements $DecisionHistoryStateCopyWith<$Res> {
  _$DecisionHistoryStateCopyWithImpl(this._self, this._then);

  final DecisionHistoryState _self;
  final $Res Function(DecisionHistoryState) _then;

/// Create a copy of DecisionHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decisions = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isDeleting = null,Object? hasMore = null,Object? page = null,Object? searchTerm = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
decisions: null == decisions ? _self.decisions : decisions // ignore: cast_nullable_to_non_nullable
as List<Decision>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DecisionHistoryState].
extension DecisionHistoryStatePatterns on DecisionHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionHistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _DecisionHistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionHistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Decision> decisions,  bool isLoading,  bool isLoadingMore,  bool isDeleting,  bool hasMore,  int page,  String searchTerm,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionHistoryState() when $default != null:
return $default(_that.decisions,_that.isLoading,_that.isLoadingMore,_that.isDeleting,_that.hasMore,_that.page,_that.searchTerm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Decision> decisions,  bool isLoading,  bool isLoadingMore,  bool isDeleting,  bool hasMore,  int page,  String searchTerm,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DecisionHistoryState():
return $default(_that.decisions,_that.isLoading,_that.isLoadingMore,_that.isDeleting,_that.hasMore,_that.page,_that.searchTerm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Decision> decisions,  bool isLoading,  bool isLoadingMore,  bool isDeleting,  bool hasMore,  int page,  String searchTerm,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DecisionHistoryState() when $default != null:
return $default(_that.decisions,_that.isLoading,_that.isLoadingMore,_that.isDeleting,_that.hasMore,_that.page,_that.searchTerm,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DecisionHistoryState implements DecisionHistoryState {
  const _DecisionHistoryState({final  List<Decision> decisions = const [], this.isLoading = false, this.isLoadingMore = false, this.isDeleting = false, this.hasMore = true, this.page = 0, this.searchTerm = '', this.errorMessage}): _decisions = decisions;
  

 final  List<Decision> _decisions;
@override@JsonKey() List<Decision> get decisions {
  if (_decisions is EqualUnmodifiableListView) return _decisions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_decisions);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isDeleting;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int page;
@override@JsonKey() final  String searchTerm;
@override final  String? errorMessage;

/// Create a copy of DecisionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionHistoryStateCopyWith<_DecisionHistoryState> get copyWith => __$DecisionHistoryStateCopyWithImpl<_DecisionHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionHistoryState&&const DeepCollectionEquality().equals(other._decisions, _decisions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_decisions),isLoading,isLoadingMore,isDeleting,hasMore,page,searchTerm,errorMessage);

@override
String toString() {
  return 'DecisionHistoryState(decisions: $decisions, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isDeleting: $isDeleting, hasMore: $hasMore, page: $page, searchTerm: $searchTerm, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DecisionHistoryStateCopyWith<$Res> implements $DecisionHistoryStateCopyWith<$Res> {
  factory _$DecisionHistoryStateCopyWith(_DecisionHistoryState value, $Res Function(_DecisionHistoryState) _then) = __$DecisionHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<Decision> decisions, bool isLoading, bool isLoadingMore, bool isDeleting, bool hasMore, int page, String searchTerm, String? errorMessage
});




}
/// @nodoc
class __$DecisionHistoryStateCopyWithImpl<$Res>
    implements _$DecisionHistoryStateCopyWith<$Res> {
  __$DecisionHistoryStateCopyWithImpl(this._self, this._then);

  final _DecisionHistoryState _self;
  final $Res Function(_DecisionHistoryState) _then;

/// Create a copy of DecisionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decisions = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isDeleting = null,Object? hasMore = null,Object? page = null,Object? searchTerm = null,Object? errorMessage = freezed,}) {
  return _then(_DecisionHistoryState(
decisions: null == decisions ? _self._decisions : decisions // ignore: cast_nullable_to_non_nullable
as List<Decision>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
