import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/infrastructure/database/app_database.dart';
import 'package:kweeksnews_app/infrastructure/datasources/shared/saved_posts_local_data_source.dart';
import 'package:kweeksnews_app/infrastructure/dtos/post_model.dart';

import '../../fixtures/post.dart';

void main() {
  late AppDatabase database;
  late SavedPostsLocalDataSourceImpl dataSource;

  const int testPostsCount = 10;
  const int testPageKey = 1;
  final PostModel testPostModel = postModel;
  final PostModel testUpdatedPostModel = updatedPostModel;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = database.savedPostsLocalDataSourceImpl;

    addTearDown(database.close);
  });

  createSavedPosts() async {
    await dataSource.createSavedPost(
      post: testPostModel,
    );
  }

  readSavedPosts() {
    return dataSource.readSavedPosts(
      postsCount: testPostsCount,
      pageKey: testPageKey,
    );
  }

  test(
    'Should create and read a saved post',
    () async {
      // Act
      await createSavedPosts();

      final result = await readSavedPosts();

      // Assert
      expect(
        result.posts[0],
        PostModel.fromDB(testPostModel.toDB()),
      );
    },
  );

  test(
    'Should update the saved post',
    () async {
      // Arrange
      await createSavedPosts();

      // Act
      await dataSource.updateSavedPost(
        post: testUpdatedPostModel,
      );

      // Assert
      final result = await readSavedPosts();

      expect(
        result.posts[0],
        PostModel.fromDB(testUpdatedPostModel.toDB()),
      );
    },
  );

  test(
    'Should delete the saved post',
    () async {
      // Arrange
      await createSavedPosts();

      // Act
      await dataSource.deleteSavedPost(
        postId: testPostModel.id,
      );

      // Assert
      final result = await readSavedPosts();

      expect(
        result.posts.length,
        0,
      );
    },
  );

  test(
    'Should check if the post is saved',
    () async {
      // Arrange
      await createSavedPosts();

      // Act
      final result = await dataSource.checkPostSaveStatus(
        postId: testUpdatedPostModel.id,
      );

      // Assert
      expect(
        result,
        true,
      );
    },
  );
}
