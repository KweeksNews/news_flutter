// Mocks generated by Mockito 5.3.2 from annotations
// in news/test/presentation/viewmodels/saved_posts/saved_posts_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:news/application/saved_posts/get_saved_posts.dart' as _i3;
import 'package:news/domain/entities/posts.dart' as _i6;
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

/// A class which mocks [GetSavedPosts].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSavedPosts extends _i1.Mock implements _i3.GetSavedPosts {
  MockGetSavedPosts() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Posts>> call({
    required int? postsCount,
    required int? pageKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #postsCount: postsCount,
            #pageKey: pageKey,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Posts>>.value(
            _FakeEither_0<_i5.Failure, _i6.Posts>(
          this,
          Invocation.method(
            #call,
            [],
            {
              #postsCount: postsCount,
              #pageKey: pageKey,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Posts>>);
}
