// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ministry_flame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectionData {

 Vector2 get anchor; Rect get region;
/// Create a copy of SelectionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionDataCopyWith<SelectionData> get copyWith => _$SelectionDataCopyWithImpl<SelectionData>(this as SelectionData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionData&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.region, region) || other.region == region));
}


@override
int get hashCode => Object.hash(runtimeType,anchor,region);

@override
String toString() {
  return 'SelectionData(anchor: $anchor, region: $region)';
}


}

/// @nodoc
abstract mixin class $SelectionDataCopyWith<$Res>  {
  factory $SelectionDataCopyWith(SelectionData value, $Res Function(SelectionData) _then) = _$SelectionDataCopyWithImpl;
@useResult
$Res call({
 Vector2 anchor, Rect region
});




}
/// @nodoc
class _$SelectionDataCopyWithImpl<$Res>
    implements $SelectionDataCopyWith<$Res> {
  _$SelectionDataCopyWithImpl(this._self, this._then);

  final SelectionData _self;
  final $Res Function(SelectionData) _then;

/// Create a copy of SelectionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? anchor = null,Object? region = null,}) {
  return _then(_self.copyWith(
anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as Vector2,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Rect,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectionData].
extension SelectionDataPatterns on SelectionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectionData value)  $default,){
final _that = this;
switch (_that) {
case _SelectionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectionData value)?  $default,){
final _that = this;
switch (_that) {
case _SelectionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Vector2 anchor,  Rect region)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectionData() when $default != null:
return $default(_that.anchor,_that.region);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Vector2 anchor,  Rect region)  $default,) {final _that = this;
switch (_that) {
case _SelectionData():
return $default(_that.anchor,_that.region);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Vector2 anchor,  Rect region)?  $default,) {final _that = this;
switch (_that) {
case _SelectionData() when $default != null:
return $default(_that.anchor,_that.region);case _:
  return null;

}
}

}

/// @nodoc


class _SelectionData extends SelectionData {
  const _SelectionData({required this.anchor, required this.region}): super._();
  

@override final  Vector2 anchor;
@override final  Rect region;

/// Create a copy of SelectionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionDataCopyWith<_SelectionData> get copyWith => __$SelectionDataCopyWithImpl<_SelectionData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionData&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.region, region) || other.region == region));
}


@override
int get hashCode => Object.hash(runtimeType,anchor,region);

@override
String toString() {
  return 'SelectionData(anchor: $anchor, region: $region)';
}


}

/// @nodoc
abstract mixin class _$SelectionDataCopyWith<$Res> implements $SelectionDataCopyWith<$Res> {
  factory _$SelectionDataCopyWith(_SelectionData value, $Res Function(_SelectionData) _then) = __$SelectionDataCopyWithImpl;
@override @useResult
$Res call({
 Vector2 anchor, Rect region
});




}
/// @nodoc
class __$SelectionDataCopyWithImpl<$Res>
    implements _$SelectionDataCopyWith<$Res> {
  __$SelectionDataCopyWithImpl(this._self, this._then);

  final _SelectionData _self;
  final $Res Function(_SelectionData) _then;

/// Create a copy of SelectionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? anchor = null,Object? region = null,}) {
  return _then(_SelectionData(
anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as Vector2,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Rect,
  ));
}


}

/// @nodoc
mixin _$DragData {

 Selection get selection; Location get origin; Vector2 get cursor;
/// Create a copy of DragData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DragDataCopyWith<DragData> get copyWith => _$DragDataCopyWithImpl<DragData>(this as DragData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DragData&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}


@override
int get hashCode => Object.hash(runtimeType,selection,origin,cursor);

@override
String toString() {
  return 'DragData(selection: $selection, origin: $origin, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class $DragDataCopyWith<$Res>  {
  factory $DragDataCopyWith(DragData value, $Res Function(DragData) _then) = _$DragDataCopyWithImpl;
@useResult
$Res call({
 Selection selection, Location origin, Vector2 cursor
});




}
/// @nodoc
class _$DragDataCopyWithImpl<$Res>
    implements $DragDataCopyWith<$Res> {
  _$DragDataCopyWithImpl(this._self, this._then);

  final DragData _self;
  final $Res Function(DragData) _then;

/// Create a copy of DragData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selection = null,Object? origin = null,Object? cursor = null,}) {
  return _then(_self.copyWith(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as Location,cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as Vector2,
  ));
}

}


/// Adds pattern-matching-related methods to [DragData].
extension DragDataPatterns on DragData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DragData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DragData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DragData value)  $default,){
final _that = this;
switch (_that) {
case _DragData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DragData value)?  $default,){
final _that = this;
switch (_that) {
case _DragData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selection selection,  Location origin,  Vector2 cursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DragData() when $default != null:
return $default(_that.selection,_that.origin,_that.cursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selection selection,  Location origin,  Vector2 cursor)  $default,) {final _that = this;
switch (_that) {
case _DragData():
return $default(_that.selection,_that.origin,_that.cursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selection selection,  Location origin,  Vector2 cursor)?  $default,) {final _that = this;
switch (_that) {
case _DragData() when $default != null:
return $default(_that.selection,_that.origin,_that.cursor);case _:
  return null;

}
}

}

/// @nodoc


class _DragData extends DragData {
  const _DragData({required this.selection, required this.origin, required this.cursor}): super._();
  

@override final  Selection selection;
@override final  Location origin;
@override final  Vector2 cursor;

/// Create a copy of DragData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DragDataCopyWith<_DragData> get copyWith => __$DragDataCopyWithImpl<_DragData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DragData&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}


@override
int get hashCode => Object.hash(runtimeType,selection,origin,cursor);

@override
String toString() {
  return 'DragData(selection: $selection, origin: $origin, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class _$DragDataCopyWith<$Res> implements $DragDataCopyWith<$Res> {
  factory _$DragDataCopyWith(_DragData value, $Res Function(_DragData) _then) = __$DragDataCopyWithImpl;
@override @useResult
$Res call({
 Selection selection, Location origin, Vector2 cursor
});




}
/// @nodoc
class __$DragDataCopyWithImpl<$Res>
    implements _$DragDataCopyWith<$Res> {
  __$DragDataCopyWithImpl(this._self, this._then);

  final _DragData _self;
  final $Res Function(_DragData) _then;

/// Create a copy of DragData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selection = null,Object? origin = null,Object? cursor = null,}) {
  return _then(_DragData(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as Location,cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as Vector2,
  ));
}


}

// dart format on
