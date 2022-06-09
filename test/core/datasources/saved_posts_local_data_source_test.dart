import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/databases/databases.dart';
import 'package:kweeksnews_app/core/datasources/saved_posts_local_data_source.dart';
import 'package:kweeksnews_app/core/models/post_model.dart';

import '../../fixtures/post.dart';

void main() {
  late SavedPostsLocalDataSource savedPostsLocalDataSource;

  setUp(() {
    savedPostsLocalDataSource =
        AppDatabase(NativeDatabase.memory()).savedPostsLocalDataSource;
  });

  final PostModel testPostModel = postModel;
  final PostModel testUpdatedPostModel = updatedPostModel;
  const int testPageKey = 0;

  createSavedPosts() async {
    await savedPostsLocalDataSource.createSavedPost(
      post: testPostModel,
    );
  }

  readSavedPosts() {
    return savedPostsLocalDataSource.readSavedPosts(
      pageKey: testPageKey,
    );
  }

  test(
    'Should create a saved post',
    () async {
      await createSavedPosts();

      final result = await readSavedPosts();

      expect(
        result.posts[0],
        PostModel.fromDB(testPostModel.toDB()),
      );
    },
  );

  test(
    'Should update the saved post',
    () async {
      await createSavedPosts();

      await savedPostsLocalDataSource.updateSavedPost(
        post: testUpdatedPostModel,
      );

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
      await createSavedPosts();

      await savedPostsLocalDataSource.deleteSavedPost(
        postId: testPostModel.id,
      );

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
      await createSavedPosts();

      final result = await savedPostsLocalDataSource.checkPostSaveStatus(
        postId: testUpdatedPostModel.id,
      );

      expect(
        result,
        true,
      );
    },
  );

  tearDown(() async {
    await savedPostsLocalDataSource.attachedDatabase.close();
  });
}
