import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/models/user_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../../fixtures/user.dart';

void main() {
  final String testUserJson = fixture('user.json');
  const UserModel testUserModel = userModel;

  group(
    'From JSON',
    () {
      test(
        'Should return a valid UserModel',
        () async {
          final result = UserModel.fromGraphQLJson(
            jsonDecode(testUserJson)['user'] as Map<String, dynamic>,
          );

          expect(
            result,
            testUserModel,
          );
        },
      );
    },
  );
}
