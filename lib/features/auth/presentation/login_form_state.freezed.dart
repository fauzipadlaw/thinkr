// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginFormState {

 String get email; String get password; String get confirmPassword; bool get isSignup; bool get isSubmitting; bool get isDirty; String? get errorMessage; String? get successMessage; String? get emailError; String? get passwordError; String? get confirmError;
/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFormStateCopyWith<LoginFormState> get copyWith => _$LoginFormStateCopyWithImpl<LoginFormState>(this as LoginFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFormState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isSignup, isSignup) || other.isSignup == isSignup)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmError, confirmError) || other.confirmError == confirmError));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword,isSignup,isSubmitting,isDirty,errorMessage,successMessage,emailError,passwordError,confirmError);

@override
String toString() {
  return 'LoginFormState(email: $email, password: $password, confirmPassword: $confirmPassword, isSignup: $isSignup, isSubmitting: $isSubmitting, isDirty: $isDirty, errorMessage: $errorMessage, successMessage: $successMessage, emailError: $emailError, passwordError: $passwordError, confirmError: $confirmError)';
}


}

/// @nodoc
abstract mixin class $LoginFormStateCopyWith<$Res>  {
  factory $LoginFormStateCopyWith(LoginFormState value, $Res Function(LoginFormState) _then) = _$LoginFormStateCopyWithImpl;
@useResult
$Res call({
 String email, String password, String confirmPassword, bool isSignup, bool isSubmitting, bool isDirty, String? errorMessage, String? successMessage, String? emailError, String? passwordError, String? confirmError
});




}
/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._self, this._then);

  final LoginFormState _self;
  final $Res Function(LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? confirmPassword = null,Object? isSignup = null,Object? isSubmitting = null,Object? isDirty = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? emailError = freezed,Object? passwordError = freezed,Object? confirmError = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isSignup: null == isSignup ? _self.isSignup : isSignup // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmError: freezed == confirmError ? _self.confirmError : confirmError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginFormState].
extension LoginFormStatePatterns on LoginFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginFormState value)  $default,){
final _that = this;
switch (_that) {
case _LoginFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginFormState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  String confirmPassword,  bool isSignup,  bool isSubmitting,  bool isDirty,  String? errorMessage,  String? successMessage,  String? emailError,  String? passwordError,  String? confirmError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.email,_that.password,_that.confirmPassword,_that.isSignup,_that.isSubmitting,_that.isDirty,_that.errorMessage,_that.successMessage,_that.emailError,_that.passwordError,_that.confirmError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  String confirmPassword,  bool isSignup,  bool isSubmitting,  bool isDirty,  String? errorMessage,  String? successMessage,  String? emailError,  String? passwordError,  String? confirmError)  $default,) {final _that = this;
switch (_that) {
case _LoginFormState():
return $default(_that.email,_that.password,_that.confirmPassword,_that.isSignup,_that.isSubmitting,_that.isDirty,_that.errorMessage,_that.successMessage,_that.emailError,_that.passwordError,_that.confirmError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  String confirmPassword,  bool isSignup,  bool isSubmitting,  bool isDirty,  String? errorMessage,  String? successMessage,  String? emailError,  String? passwordError,  String? confirmError)?  $default,) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.email,_that.password,_that.confirmPassword,_that.isSignup,_that.isSubmitting,_that.isDirty,_that.errorMessage,_that.successMessage,_that.emailError,_that.passwordError,_that.confirmError);case _:
  return null;

}
}

}

/// @nodoc


class _LoginFormState extends LoginFormState {
  const _LoginFormState({this.email = '', this.password = '', this.confirmPassword = '', this.isSignup = false, this.isSubmitting = false, this.isDirty = false, this.errorMessage, this.successMessage, this.emailError, this.passwordError, this.confirmError}): super._();
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  String confirmPassword;
@override@JsonKey() final  bool isSignup;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isDirty;
@override final  String? errorMessage;
@override final  String? successMessage;
@override final  String? emailError;
@override final  String? passwordError;
@override final  String? confirmError;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFormStateCopyWith<_LoginFormState> get copyWith => __$LoginFormStateCopyWithImpl<_LoginFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFormState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isSignup, isSignup) || other.isSignup == isSignup)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmError, confirmError) || other.confirmError == confirmError));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword,isSignup,isSubmitting,isDirty,errorMessage,successMessage,emailError,passwordError,confirmError);

@override
String toString() {
  return 'LoginFormState(email: $email, password: $password, confirmPassword: $confirmPassword, isSignup: $isSignup, isSubmitting: $isSubmitting, isDirty: $isDirty, errorMessage: $errorMessage, successMessage: $successMessage, emailError: $emailError, passwordError: $passwordError, confirmError: $confirmError)';
}


}

/// @nodoc
abstract mixin class _$LoginFormStateCopyWith<$Res> implements $LoginFormStateCopyWith<$Res> {
  factory _$LoginFormStateCopyWith(_LoginFormState value, $Res Function(_LoginFormState) _then) = __$LoginFormStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String confirmPassword, bool isSignup, bool isSubmitting, bool isDirty, String? errorMessage, String? successMessage, String? emailError, String? passwordError, String? confirmError
});




}
/// @nodoc
class __$LoginFormStateCopyWithImpl<$Res>
    implements _$LoginFormStateCopyWith<$Res> {
  __$LoginFormStateCopyWithImpl(this._self, this._then);

  final _LoginFormState _self;
  final $Res Function(_LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? confirmPassword = null,Object? isSignup = null,Object? isSubmitting = null,Object? isDirty = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? emailError = freezed,Object? passwordError = freezed,Object? confirmError = freezed,}) {
  return _then(_LoginFormState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isSignup: null == isSignup ? _self.isSignup : isSignup // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmError: freezed == confirmError ? _self.confirmError : confirmError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
