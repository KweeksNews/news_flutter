import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/data/models/posts_model.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../fixtures/posts.dart';

void main() {
  final String testPostsJson = fixture('posts.json');
  final PostsModel testPostsModel = postsModel;

  group(
    'From JSON',
    () {
      test(
        'Should return a valid PostsModel',
        () async {
          final result = PostsModel.fromGraphQLJson(
            jsonDecode(testPostsJson)['posts'] as Map<String, dynamic>,
          );

          expect(
            result,
            testPostsModel,
          );
        },
      );
    },
  );
}
