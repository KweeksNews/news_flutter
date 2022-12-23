import 'package:kweeksnews_app/core/data/models/category_model.dart';
import 'package:kweeksnews_app/core/domain/entities/category.dart';

const Category category = Category(
  id: 1,
  slug: 'test-category',
  name: 'Test Category',
  description: 'Test Category Description',
  children: [
    Category(
      id: 3,
      slug: 'test-child-category',
      name: 'Test Child Category',
      description: 'Test Child Category Description',
      children: [],
    ),
  ],
);

const CategoryModel categoryModel = CategoryModel(
  id: 1,
  slug: 'test-category',
  name: 'Test Category',
  description: 'Test Category Description',
  children: [
    CategoryModel(
      id: 3,
      slug: 'test-child-category',
      name: 'Test Child Category',
      description: 'Test Child Category Description',
      children: [],
    ),
  ],
);
