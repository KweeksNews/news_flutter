import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_post/add_saved_post.dart';
import 'package:kweeksnews_app/application/single_post/check_post_save_status.dart';
import 'package:kweeksnews_app/application/single_post/delete_saved_post.dart';
import 'package:kweeksnews_app/domain/entities/post.dart';
import 'package:kweeksnews_app/presentation/pages/saved_posts/saved_posts_page.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_post/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/post.dart';
import 'saved_post_notifier_test.mocks.dart';

@GenerateMocks([
  AddSavedPost,
  DeleteSavedPost,
  CheckPostSaveStatus,
  GlobalKey<SavedPostsPageState>
])
void main() {
  late MockAddSavedPost mockAddSavedPost;
  late MockDeleteSavedPost mockDeleteSavedPost;
  late MockCheckPostSaveStatus mockCheckPostSaveStatus;
  late MockGlobalKey<SavedPostsPageState> mockGlobalKey;
  late ProviderContainer container;
  late StateNotifierProvider<SavedPostNotifier, bool> savedPostsProvider;

  const int testPostId = 1;
  final Post testPost = post;

  setUp(() {
    mockAddSavedPost = MockAddSavedPost();
    mockDeleteSavedPost = MockDeleteSavedPost();
    mockCheckPostSaveStatus = MockCheckPostSaveStatus();
    mockGlobalKey = MockGlobalKey<SavedPostsPageState>();
    container = ProviderContainer();
    savedPostsProvider = StateNotifierProvider<SavedPostNotifier, bool>(
      (ref) => SavedPostNotifier(
        mockAddSavedPost,
        mockDeleteSavedPost,
        mockCheckPostSaveStatus,
        mockGlobalKey,
      ),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should add saved post using use case and refresh saved posts page',
    () async {
      // Arrange
      when(
        mockAddSavedPost(
          post: anyNamed('post'),
        ),
      ).thenAnswer(
        (_) async => const Right(testPostId),
      );

      when(
        mockGlobalKey.currentState?.refresh(),
      ).thenReturn(
        null,
      );

      expect(
        container.read(savedPostsProvider),
        false,
      );

      // Act
      container.read(savedPostsProvider.notifier).createPost(
            post: testPost,
          );

      await untilCalled(
        mockAddSavedPost(
          post: anyNamed('post'),
        ),
      );

      // Assert
      verify(
        mockAddSavedPost(
          post: testPost,
        ),
      );

      verify(
        mockGlobalKey.currentState?.refresh(),
      );

      expect(
        container.read(savedPostsProvider),
        true,
      );
    },
  );

  test(
    'Should delete saved post using use case and refresh saved posts page',
    () async {
      // Arrange
      when(
        mockDeleteSavedPost(
          postId: anyNamed('postId'),
        ),
      ).thenAnswer(
        (_) async => const Right(testPostId),
      );

      when(
        mockGlobalKey.currentState?.refresh(),
      ).thenReturn(
        null,
      );

      // Act
      container.read(savedPostsProvider.notifier).deletePost(
            postId: testPostId,
          );

      await untilCalled(
        mockDeleteSavedPost(
          postId: anyNamed('postId'),
        ),
      );

      // Assert
      verify(
        mockDeleteSavedPost(
          postId: testPostId,
        ),
      );

      verify(
        mockGlobalKey.currentState?.refresh(),
      );

      expect(
        container.read(savedPostsProvider),
        false,
      );
    },
  );

  test(
    'Should check post save status using use case',
    () async {
      // Arrange
      when(
        mockCheckPostSaveStatus(
          postId: anyNamed('postId'),
        ),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      expect(
        container.read(savedPostsProvider),
        false,
      );

      // Act
      container.read(savedPostsProvider.notifier).checkPostSaveStatus(
            postId: testPostId,
          );

      await untilCalled(
        mockCheckPostSaveStatus(
          postId: anyNamed('postId'),
        ),
      );

      // Assert
      verify(
        mockCheckPostSaveStatus(
          postId: testPostId,
        ),
      );

      expect(
        container.read(savedPostsProvider),
        true,
      );
    },
  );
}
