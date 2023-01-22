import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news/infrastructure/dtos/post_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../../fixtures/post.dart';

void main() {
  final String testPostJson = fixture('post.json');
  final PostModel testPostModel = postModel;

  group(
    'From JSON',
    () {
      test(
        'Should return a valid PostModel',
        () async {
          final result = PostModel.fromGraphQLJson(
            jsonDecode(testPostJson)['post'] as Map<String, dynamic>,
          );

          expect(
            result,
            testPostModel,
          );
        },
      );
    },
  );
}
