import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/infrastructure/dtos/category_model.dart';

import '../../fixtures/category.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  final String testCategoryJson = fixture('category.json');
  const CategoryModel testCategoryModel = categoryModel;

  group(
    'From JSON',
    () {
      test(
        'Should return a valid CategoryModel',
        () async {
          final CategoryModel result = CategoryModel.fromGraphQLJson(
            jsonDecode(testCategoryJson)['category'] as Map<String, dynamic>,
          );

          expect(
            result,
            testCategoryModel,
          );
        },
      );
    },
  );
}
