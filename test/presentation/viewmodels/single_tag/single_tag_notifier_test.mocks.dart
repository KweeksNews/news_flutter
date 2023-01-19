// Mocks generated by Mockito 5.3.2 from annotations
// in kweeksnews_app/test/presentation/viewmodels/single_tag/single_tag_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:kweeksnews_app/application/single_tag/get_tag.dart' as _i3;
import 'package:kweeksnews_app/domain/entities/tag.dart' as _i6;
import 'package:kweeksnews_app/domain/enums/tag_id_type.dart' as _i7;
import 'package:kweeksnews_app/domain/error/failures.dart' as _i5;
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

/// A class which mocks [GetTag].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTag extends _i1.Mock implements _i3.GetTag {
  MockGetTag() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Tag>> call({
    required String? id,
    required _i7.TagIdType? idType,
    required bool? forceRefresh,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #id: id,
            #idType: idType,
            #forceRefresh: forceRefresh,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Tag>>.value(
            _FakeEither_0<_i5.Failure, _i6.Tag>(
          this,
          Invocation.method(
            #call,
            [],
            {
              #id: id,
              #idType: idType,
              #forceRefresh: forceRefresh,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Tag>>);
}
