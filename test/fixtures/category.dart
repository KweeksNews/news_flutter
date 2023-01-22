import 'package:news/domain/entities/category.dart';
import 'package:news/infrastructure/dtos/category_model.dart';

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
