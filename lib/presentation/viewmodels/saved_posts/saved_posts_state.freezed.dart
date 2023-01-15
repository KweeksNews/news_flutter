// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_posts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SavedPostsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts, int nextPageKey) appendPage,
    required TResult Function(List<Post> posts) appendLastPage,
    required TResult Function() failedToLoadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult? Function(List<Post> posts)? appendLastPage,
    TResult? Function()? failedToLoadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult Function(List<Post> posts)? appendLastPage,
    TResult Function()? failedToLoadData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_AppendPage value) appendPage,
    required TResult Function(_AppendLastPage value) appendLastPage,
    required TResult Function(_Error value) failedToLoadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AppendPage value)? appendPage,
    TResult? Function(_AppendLastPage value)? appendLastPage,
    TResult? Function(_Error value)? failedToLoadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_AppendPage value)? appendPage,
    TResult Function(_AppendLastPage value)? appendLastPage,
    TResult Function(_Error value)? failedToLoadData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedPostsStateCopyWith<$Res> {
  factory $SavedPostsStateCopyWith(
          SavedPostsState value, $Res Function(SavedPostsState) then) =
      _$SavedPostsStateCopyWithImpl<$Res, SavedPostsState>;
}

/// @nodoc
class _$SavedPostsStateCopyWithImpl<$Res, $Val extends SavedPostsState>
    implements $SavedPostsStateCopyWith<$Res> {
  _$SavedPostsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$SavedPostsStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading with DiagnosticableTreeMixin implements _Loading {
  const _$_Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SavedPostsState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'SavedPostsState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts, int nextPageKey) appendPage,
    required TResult Function(List<Post> posts) appendLastPage,
    required TResult Function() failedToLoadData,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult? Function(List<Post> posts)? appendLastPage,
    TResult? Function()? failedToLoadData,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult Function(List<Post> posts)? appendLastPage,
    TResult Function()? failedToLoadData,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_AppendPage value) appendPage,
    required TResult Function(_AppendLastPage value) appendLastPage,
    required TResult Function(_Error value) failedToLoadData,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AppendPage value)? appendPage,
    TResult? Function(_AppendLastPage value)? appendLastPage,
    TResult? Function(_Error value)? failedToLoadData,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_AppendPage value)? appendPage,
    TResult Function(_AppendLastPage value)? appendLastPage,
    TResult Function(_Error value)? failedToLoadData,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SavedPostsState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_AppendPageCopyWith<$Res> {
  factory _$$_AppendPageCopyWith(
          _$_AppendPage value, $Res Function(_$_AppendPage) then) =
      __$$_AppendPageCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Post> posts, int nextPageKey});
}

/// @nodoc
class __$$_AppendPageCopyWithImpl<$Res>
    extends _$SavedPostsStateCopyWithImpl<$Res, _$_AppendPage>
    implements _$$_AppendPageCopyWith<$Res> {
  __$$_AppendPageCopyWithImpl(
      _$_AppendPage _value, $Res Function(_$_AppendPage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? nextPageKey = null,
  }) {
    return _then(_$_AppendPage(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      nextPageKey: null == nextPageKey
          ? _value.nextPageKey
          : nextPageKey // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_AppendPage with DiagnosticableTreeMixin implements _AppendPage {
  const _$_AppendPage(
      {required final List<Post> posts, required this.nextPageKey})
      : _posts = posts;

  final List<Post> _posts;
  @override
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  final int nextPageKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SavedPostsState.appendPage(posts: $posts, nextPageKey: $nextPageKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SavedPostsState.appendPage'))
      ..add(DiagnosticsProperty('posts', posts))
      ..add(DiagnosticsProperty('nextPageKey', nextPageKey));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppendPage &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.nextPageKey, nextPageKey) ||
                other.nextPageKey == nextPageKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_posts), nextPageKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppendPageCopyWith<_$_AppendPage> get copyWith =>
      __$$_AppendPageCopyWithImpl<_$_AppendPage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts, int nextPageKey) appendPage,
    required TResult Function(List<Post> posts) appendLastPage,
    required TResult Function() failedToLoadData,
  }) {
    return appendPage(posts, nextPageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult? Function(List<Post> posts)? appendLastPage,
    TResult? Function()? failedToLoadData,
  }) {
    return appendPage?.call(posts, nextPageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult Function(List<Post> posts)? appendLastPage,
    TResult Function()? failedToLoadData,
    required TResult orElse(),
  }) {
    if (appendPage != null) {
      return appendPage(posts, nextPageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_AppendPage value) appendPage,
    required TResult Function(_AppendLastPage value) appendLastPage,
    required TResult Function(_Error value) failedToLoadData,
  }) {
    return appendPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AppendPage value)? appendPage,
    TResult? Function(_AppendLastPage value)? appendLastPage,
    TResult? Function(_Error value)? failedToLoadData,
  }) {
    return appendPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_AppendPage value)? appendPage,
    TResult Function(_AppendLastPage value)? appendLastPage,
    TResult Function(_Error value)? failedToLoadData,
    required TResult orElse(),
  }) {
    if (appendPage != null) {
      return appendPage(this);
    }
    return orElse();
  }
}

abstract class _AppendPage implements SavedPostsState {
  const factory _AppendPage(
      {required final List<Post> posts,
      required final int nextPageKey}) = _$_AppendPage;

  List<Post> get posts;
  int get nextPageKey;
  @JsonKey(ignore: true)
  _$$_AppendPageCopyWith<_$_AppendPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AppendLastPageCopyWith<$Res> {
  factory _$$_AppendLastPageCopyWith(
          _$_AppendLastPage value, $Res Function(_$_AppendLastPage) then) =
      __$$_AppendLastPageCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Post> posts});
}

/// @nodoc
class __$$_AppendLastPageCopyWithImpl<$Res>
    extends _$SavedPostsStateCopyWithImpl<$Res, _$_AppendLastPage>
    implements _$$_AppendLastPageCopyWith<$Res> {
  __$$_AppendLastPageCopyWithImpl(
      _$_AppendLastPage _value, $Res Function(_$_AppendLastPage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_$_AppendLastPage(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _$_AppendLastPage
    with DiagnosticableTreeMixin
    implements _AppendLastPage {
  const _$_AppendLastPage({required final List<Post> posts}) : _posts = posts;

  final List<Post> _posts;
  @override
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SavedPostsState.appendLastPage(posts: $posts)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SavedPostsState.appendLastPage'))
      ..add(DiagnosticsProperty('posts', posts));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppendLastPage &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_posts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppendLastPageCopyWith<_$_AppendLastPage> get copyWith =>
      __$$_AppendLastPageCopyWithImpl<_$_AppendLastPage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts, int nextPageKey) appendPage,
    required TResult Function(List<Post> posts) appendLastPage,
    required TResult Function() failedToLoadData,
  }) {
    return appendLastPage(posts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult? Function(List<Post> posts)? appendLastPage,
    TResult? Function()? failedToLoadData,
  }) {
    return appendLastPage?.call(posts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult Function(List<Post> posts)? appendLastPage,
    TResult Function()? failedToLoadData,
    required TResult orElse(),
  }) {
    if (appendLastPage != null) {
      return appendLastPage(posts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_AppendPage value) appendPage,
    required TResult Function(_AppendLastPage value) appendLastPage,
    required TResult Function(_Error value) failedToLoadData,
  }) {
    return appendLastPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AppendPage value)? appendPage,
    TResult? Function(_AppendLastPage value)? appendLastPage,
    TResult? Function(_Error value)? failedToLoadData,
  }) {
    return appendLastPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_AppendPage value)? appendPage,
    TResult Function(_AppendLastPage value)? appendLastPage,
    TResult Function(_Error value)? failedToLoadData,
    required TResult orElse(),
  }) {
    if (appendLastPage != null) {
      return appendLastPage(this);
    }
    return orElse();
  }
}

abstract class _AppendLastPage implements SavedPostsState {
  const factory _AppendLastPage({required final List<Post> posts}) =
      _$_AppendLastPage;

  List<Post> get posts;
  @JsonKey(ignore: true)
  _$$_AppendLastPageCopyWith<_$_AppendLastPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$SavedPostsStateCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Error with DiagnosticableTreeMixin implements _Error {
  const _$_Error();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SavedPostsState.failedToLoadData()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'SavedPostsState.failedToLoadData'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Error);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts, int nextPageKey) appendPage,
    required TResult Function(List<Post> posts) appendLastPage,
    required TResult Function() failedToLoadData,
  }) {
    return failedToLoadData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult? Function(List<Post> posts)? appendLastPage,
    TResult? Function()? failedToLoadData,
  }) {
    return failedToLoadData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts, int nextPageKey)? appendPage,
    TResult Function(List<Post> posts)? appendLastPage,
    TResult Function()? failedToLoadData,
    required TResult orElse(),
  }) {
    if (failedToLoadData != null) {
      return failedToLoadData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_AppendPage value) appendPage,
    required TResult Function(_AppendLastPage value) appendLastPage,
    required TResult Function(_Error value) failedToLoadData,
  }) {
    return failedToLoadData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_AppendPage value)? appendPage,
    TResult? Function(_AppendLastPage value)? appendLastPage,
    TResult? Function(_Error value)? failedToLoadData,
  }) {
    return failedToLoadData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_AppendPage value)? appendPage,
    TResult Function(_AppendLastPage value)? appendLastPage,
    TResult Function(_Error value)? failedToLoadData,
    required TResult orElse(),
  }) {
    if (failedToLoadData != null) {
      return failedToLoadData(this);
    }
    return orElse();
  }
}

abstract class _Error implements SavedPostsState {
  const factory _Error() = _$_Error;
}
