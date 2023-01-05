import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/infrastructure/dtos/tag_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../../fixtures/tag.dart';

void main() {
  final String testTagJson = fixture('tag.json');
  const TagModel testTagModel = tagModel;

  group(
    'From JSON',
    () {
      test(
        'Should return a valid TagModel',
        () async {
          final result = TagModel.fromGraphQLJson(
            jsonDecode(testTagJson)['tag'] as Map<String, dynamic>,
          );

          expect(
            result,
            testTagModel,
          );
        },
      );
    },
  );
}
