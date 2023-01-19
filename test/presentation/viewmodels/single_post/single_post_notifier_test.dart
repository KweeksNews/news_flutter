import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/application/single_post/get_post.dart';
import 'package:kweeksnews_app/domain/entities/post.dart';
import 'package:kweeksnews_app/domain/enums/post_id_type.dart';
import 'package:kweeksnews_app/domain/error/failures.dart';
import 'package:kweeksnews_app/presentation/viewmodels/single_post/notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/post.dart';
import 'single_post_notifier_test.mocks.dart';

@GenerateMocks([GetPost])
void main() {
  late MockGetPost mockGetPost;
  late ProviderContainer container;
  late StateNotifierProvider<SinglePostNotifier, SinglePostState>
      singlePostProvider;

  const String testId = '1';
  const PostIdType testIdType = PostIdType.id;
  const bool testForceRefresh = true;
  final Post testPost = post;

  setUp(() {
    mockGetPost = MockGetPost();
    container = ProviderContainer();
    singlePostProvider =
        StateNotifierProvider<SinglePostNotifier, SinglePostState>(
      (ref) => SinglePostNotifier(mockGetPost),
    );

    addTearDown(container.dispose);
  });

  test(
    'Should get data from the use case and return Post on success',
    () async {
      // Arrange
      when(
        mockGetPost(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Right(testPost),
      );

      expect(
        container.read(singlePostProvider),
        const SinglePostState.loading(),
      );

      // Act
      container.read(singlePostProvider.notifier).fetchPost(
            id: testId,
            idType: testIdType,
          );

      await untilCalled(
        mockGetPost(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetPost(
          id: testId,
          idType: testIdType,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singlePostProvider),
        SinglePostState.loaded(
          post: post,
        ),
      );
    },
  );

  test(
    'Should get data from the use case and return error on failure',
    () async {
      // Arrange
      when(
        mockGetPost(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Left(RequestFailure()),
      );

      expect(
        container.read(singlePostProvider),
        const SinglePostState.loading(),
      );

      // Act
      container.read(singlePostProvider.notifier).fetchPost(
            id: testId,
            idType: testIdType,
          );

      await untilCalled(
        mockGetPost(
          id: anyNamed('id'),
          idType: anyNamed('idType'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      );

      // Assert
      verify(
        mockGetPost(
          id: testId,
          idType: testIdType,
          forceRefresh: testForceRefresh,
        ),
      );

      expect(
        container.read(singlePostProvider),
        const SinglePostState.failedToLoadData(),
      );
    },
  );
}
