// Mocks generated by Mockito 5.3.2 from annotations
// in news/test/presentation/viewmodels/single_post/saved_post_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter/src/widgets/framework.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:news/application/single_post/add_saved_post.dart' as _i3;
import 'package:news/application/single_post/check_post_save_status.dart'
    as _i8;
import 'package:news/application/single_post/delete_saved_post.dart' as _i7;
import 'package:news/domain/entities/post.dart' as _i6;
import 'package:news/domain/error/failures.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddSavedPost].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddSavedPost extends _i1.Mock implements _i3.AddSavedPost {
  MockAddSavedPost() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> call({required _i6.Post? post}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#post: post},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
            _FakeEither_0<_i5.Failure, int>(
          this,
          Invocation.method(
            #call,
            [],
            {#post: post},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, int>>);
}

/// A class which mocks [DeleteSavedPost].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteSavedPost extends _i1.Mock implements _i7.DeleteSavedPost {
  MockDeleteSavedPost() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> call({required int? postId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#postId: postId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
            _FakeEither_0<_i5.Failure, int>(
          this,
          Invocation.method(
            #call,
            [],
            {#postId: postId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, int>>);
}

/// A class which mocks [CheckPostSaveStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockCheckPostSaveStatus extends _i1.Mock
    implements _i8.CheckPostSaveStatus {
  MockCheckPostSaveStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> call({required int? postId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#postId: postId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #call,
            [],
            {#postId: postId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}

/// A class which mocks [GlobalKey].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockGlobalKey<T extends _i9.State<_i9.StatefulWidget>> extends _i1.Mock
    implements _i9.GlobalKey<T> {
  MockGlobalKey() {
    _i1.throwOnMissingStub(this);
  }
}
