import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/entities/post_list.dart';
import 'package:kweeksnews_app/core/error/failures.dart';
import 'package:kweeksnews_app/features/search/domain/repositories/search_repository.dart';
import 'package:kweeksnews_app/features/search/domain/usecases/search_posts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/posts.dart';
import 'search_posts_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  late MockSearchRepository mockSearchRepository;
  late SearchPosts usecase;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    usecase = SearchPosts(mockSearchRepository);
  });

  const String testSearchTerm = 'test';
  const int testPostsCount = 1;
  const String testPageKey = 'test';
  const bool testForceRefresh = false;
  final PostList testPosts = posts;

  test(
    'Should get posts from repository',
    () async {
      when(
        mockSearchRepository.searchPosts(
          searchTerm: anyNamed('searchTerm'),
          postsCount: anyNamed('postsCount'),
          pageKey: anyNamed('pageKey'),
          forceRefresh: anyNamed('forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Right(testPosts),
      );

      final result = await usecase(
        searchTerm: testSearchTerm,
        postsCount: testPostsCount,
        pageKey: testPageKey,
        forceRefresh: testForceRefresh,
      );

      expect(
        result,
        Right<Failure, PostList>(testPosts),
      );

      verify(
        mockSearchRepository.searchPosts(
          searchTerm: testSearchTerm,
          postsCount: testPostsCount,
          pageKey: testPageKey,
          forceRefresh: testForceRefresh,
        ),
      );

      verifyNoMoreInteractions(
        mockSearchRepository,
      );
    },
  );
}
