// Mocks generated by Mockito 5.3.2 from annotations
// in kweeksnews_app/test/features/search/data/repositories/search_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:kweeksnews_app/core/datasources/wp_remote_data_source.dart'
    as _i7;
import 'package:kweeksnews_app/core/models/category_model.dart' as _i3;
import 'package:kweeksnews_app/core/models/post_list_model.dart' as _i5;
import 'package:kweeksnews_app/core/models/post_model.dart' as _i6;
import 'package:kweeksnews_app/core/models/tag_model.dart' as _i4;
import 'package:kweeksnews_app/core/models/user_model.dart' as _i2;
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

class _FakeUserModel_0 extends _i1.SmartFake implements _i2.UserModel {
  _FakeUserModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCategoryModel_1 extends _i1.SmartFake implements _i3.CategoryModel {
  _FakeCategoryModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTagModel_2 extends _i1.SmartFake implements _i4.TagModel {
  _FakeTagModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePostListModel_3 extends _i1.SmartFake implements _i5.PostListModel {
  _FakePostListModel_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePostModel_4 extends _i1.SmartFake implements _i6.PostModel {
  _FakePostModel_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WpRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWpRemoteDataSource extends _i1.Mock
    implements _i7.WpRemoteDataSource {
  MockWpRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.UserModel> getUser({
    required String? id,
    required String? idType,
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
        returnValue: _i8.Future<_i2.UserModel>.value(_FakeUserModel_0(
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
      ) as _i8.Future<_i2.UserModel>);
  @override
  _i8.Future<_i3.CategoryModel> getCategory({
    required String? id,
    required String? idType,
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
        returnValue: _i8.Future<_i3.CategoryModel>.value(_FakeCategoryModel_1(
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
      ) as _i8.Future<_i3.CategoryModel>);
  @override
  _i8.Future<_i4.TagModel> getTag({
    required String? id,
    required String? idType,
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
        returnValue: _i8.Future<_i4.TagModel>.value(_FakeTagModel_2(
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
      ) as _i8.Future<_i4.TagModel>);
  @override
  _i8.Future<_i5.PostListModel> getPosts({
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
        returnValue: _i8.Future<_i5.PostListModel>.value(_FakePostListModel_3(
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
      ) as _i8.Future<_i5.PostListModel>);
  @override
  _i8.Future<_i6.PostModel> getPost({
    required String? id,
    required String? idType,
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
        returnValue: _i8.Future<_i6.PostModel>.value(_FakePostModel_4(
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
      ) as _i8.Future<_i6.PostModel>);
}
