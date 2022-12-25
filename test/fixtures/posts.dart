import 'package:kweeksnews_app/core/data/models/category_model.dart';
import 'package:kweeksnews_app/core/data/models/post_list_model.dart';
import 'package:kweeksnews_app/core/data/models/post_model.dart';
import 'package:kweeksnews_app/core/data/models/tag_model.dart';
import 'package:kweeksnews_app/core/data/models/user_model.dart';
import 'package:kweeksnews_app/core/domain/entities/category.dart';
import 'package:kweeksnews_app/core/domain/entities/post.dart';
import 'package:kweeksnews_app/core/domain/entities/post_list.dart';
import 'package:kweeksnews_app/core/domain/entities/tag.dart';
import 'package:kweeksnews_app/core/domain/entities/user.dart';

final PostList posts = PostList(
  posts: [
    Post(
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
    ),
  ],
  hasNextPage: false,
  hasPreviousPage: false,
  startCursor: null,
  endCursor: null,
);

final PostList postsHasNextPage = PostList(
  posts: [
    Post(
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
    ),
  ],
  hasNextPage: true,
  hasPreviousPage: false,
  startCursor: null,
  endCursor: 'YXJyYXljb25uZWN0aW9uOjA=',
);

final PostListModel postsModel = PostListModel(
  posts: [
    PostModel(
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
    ),
  ],
);
