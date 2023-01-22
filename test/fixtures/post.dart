import 'package:news/domain/entities/category.dart';
import 'package:news/domain/entities/post.dart';
import 'package:news/domain/entities/tag.dart';
import 'package:news/domain/entities/user.dart';
import 'package:news/infrastructure/dtos/category_model.dart';
import 'package:news/infrastructure/dtos/post_model.dart';
import 'package:news/infrastructure/dtos/tag_model.dart';
import 'package:news/infrastructure/dtos/user_model.dart';

final Post post = Post(
  id: 1,
  date: DateTime.parse('1970-01-01T07:00:01'),
  slug: 'test-post',
  title: 'Test Post',
  content: 'Test Post Content',
  image: 'test-post-image.jpg',
  video: 'test-post-video.mp4',
  author: const User(
    id: 1,
    slug: 'test-user',
    name: 'Test User',
    description: 'Test User Description',
    avatar: 'test-user-avatar.png',
  ),
  categories: const [
    Category(
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
    ),
  ],
  tags: const [
    Tag(
      id: 2,
      slug: 'test-tag',
      name: 'Test Tag',
      description: 'Test Tag Description',
    ),
  ],
);

final PostModel postModel = PostModel(
  id: 1,
  date: DateTime.parse('1970-01-01T07:00:01'),
  slug: 'test-post',
  title: 'Test Post',
  content: 'Test Post Content',
  image: 'test-post-image.jpg',
  video: 'test-post-video.mp4',
  author: const UserModel(
    id: 1,
    slug: 'test-user',
    name: 'Test User',
    description: 'Test User Description',
    avatar: 'test-user-avatar.png',
  ),
  categories: const [
    CategoryModel(
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
    ),
  ],
  tags: const [
    TagModel(
      id: 2,
      slug: 'test-tag',
      name: 'Test Tag',
      description: 'Test Tag Description',
    ),
  ],
);

final PostModel updatedPostModel = PostModel(
  id: 1,
  date: DateTime.parse('1970-01-01T07:00:01'),
  slug: 'test-post',
  title: 'Updated Test Post',
  content: 'Test Post Content',
  image: 'test-post-image.jpg',
  video: 'test-post-video.mp4',
  author: const UserModel(
    id: 1,
    slug: 'test-user',
    name: 'Test User',
    description: 'Test User Description',
    avatar: 'test-user-avatar.png',
  ),
  categories: const [
    CategoryModel(
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
    ),
  ],
  tags: const [
    TagModel(
      id: 2,
      slug: 'test-tag',
      name: 'Test Tag',
      description: 'Test Tag Description',
    ),
  ],
);
