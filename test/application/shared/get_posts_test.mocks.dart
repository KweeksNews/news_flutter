// Mocks generated by Mockito 5.3.2 from annotations
// in kweeksnews_app/test/application/shared/get_posts_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:kweeksnews_app/domain/entities/category.dart' as _i8;
import 'package:kweeksnews_app/domain/entities/post.dart' as _i12;
import 'package:kweeksnews_app/domain/entities/posts.dart' as _i14;
import 'package:kweeksnews_app/domain/entities/tag.dart' as _i10;
import 'package:kweeksnews_app/domain/entities/user.dart' as _i6;
import 'package:kweeksnews_app/domain/enums/category_id_type.dart' as _i9;
import 'package:kweeksnews_app/domain/enums/post_id_type.dart' as _i13;
import 'package:kweeksnews_app/domain/enums/tag_id_type.dart' as _i11;
import 'package:kweeksnews_app/domain/enums/user_node_id_type.dart' as _i7;
import 'package:kweeksnews_app/domain/error/failures.dart' as _i5;
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

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

/// A class which mocks [WpRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWpRepository extends _i1.Mock implements _i3.WpRepository {
  MockWpRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> getUser({
    required String? id,
    required _i7.UserNodeIdType? idType,
    required bool? forceRefresh,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
          {
            #id: id,
            #idType: idType,
            #forceRefresh: forceRefresh,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
            _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #getUser,
            [],
            {
              #id: id,
              #idType: idType,
              #forceRefresh: forceRefresh,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.Category>> getCategory({
    required String? id,
    required _i9.CategoryIdType? idType,
    required bool? forceRefresh,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCategory,
          [],
          {
            #id: id,
            #idType: idType,
            #forceRefresh: forceRefresh,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i8.Category>>.value(
            _FakeEither_0<_i5.Failure, _i8.Category>(
          this,
          Invocation.method(
            #getCategory,
            [],
            {
              #id: id,
              #idType: idType,
              #forceRefresh: forceRefresh,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i8.Category>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i10.Tag>> getTag({
    required String? id,
    required _i11.TagIdType? idType,
    required bool? forceRefresh,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTag,
          [],
          {
            #id: id,
            #idType: idType,
            #forceRefresh: forceRefresh,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i10.Tag>>.value(
            _FakeEither_0<_i5.Failure, _i10.Tag>(
          this,
          Invocation.method(
            #getTag,
            [],
            {
              #id: id,
              #idType: idType,
              #forceRefresh: forceRefresh,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i10.Tag>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i12.Post>> getPost({
    required String? id,
    required _i13.PostIdType? idType,
    required bool? forceRefresh,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPost,
          [],
          {
            #id: id,
            #idType: idType,
            #forceRefresh: forceRefresh,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i12.Post>>.value(
            _FakeEither_0<_i5.Failure, _i12.Post>(
          this,
          Invocation.method(
            #getPost,
            [],
            {
              #id: id,
              #idType: idType,
              #forceRefresh: forceRefresh,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i12.Post>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i14.Posts>> getPosts({
    String? search,
    List<String>? notIn,
    List<String>? authorIn,
    List<String>? categoryIn,
    List<String>? categoryNotIn,
    List<String>? tagIn,
    List<String>? tagNotIn,
    int? first,
    String? after,
    int? last,
    String? before,
    required bool? forceRefresh,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPosts,
          [],
          {
            #search: search,
            #notIn: notIn,
            #authorIn: authorIn,
            #categoryIn: categoryIn,
            #categoryNotIn: categoryNotIn,
            #tagIn: tagIn,
            #tagNotIn: tagNotIn,
            #first: first,
            #after: after,
            #last: last,
            #before: before,
            #forceRefresh: forceRefresh,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i14.Posts>>.value(
            _FakeEither_0<_i5.Failure, _i14.Posts>(
          this,
          Invocation.method(
            #getPosts,
            [],
            {
              #search: search,
              #notIn: notIn,
              #authorIn: authorIn,
              #categoryIn: categoryIn,
              #categoryNotIn: categoryNotIn,
              #tagIn: tagIn,
              #tagNotIn: tagNotIn,
              #first: first,
              #after: after,
              #last: last,
              #before: before,
              #forceRefresh: forceRefresh,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i14.Posts>>);
}
