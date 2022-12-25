import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/data/datasources/wp_remote_data_source.dart';
import 'package:kweeksnews_app/core/data/models/posts_model.dart';
import 'package:kweeksnews_app/core/data/repositories/wp_repository_impl.dart';
import 'package:kweeksnews_app/core/domain/error/exceptions.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/posts.dart';
import 'wp_repository_impl_test.mocks.dart';

@GenerateMocks([WpRemoteDataSource])
void main() {
  late MockWpRemoteDataSource mockWpRemoteDataSource;
  late WpRepositoryImpl repository;

  setUp(
    () {
      mockWpRemoteDataSource = MockWpRemoteDataSource();
      repository = WpRepositoryImpl(mockWpRemoteDataSource);
    },
  );

  group(
    'Get Posts',
    () {
      const String testSearchTerm = 'test';
      const int testPostsCount = 1;
      const String testPageKey = 'test';
      const bool testForceRefresh = false;
      final PostsModel testPostsModel = postsModel;

      group(
        'Device is online',
        () {
          test(
            'Should return data when the call to remote data source is successful',
            () async {
              when(
                mockWpRemoteDataSource.getPosts(
                  search: anyNamed('search'),
                  notIn: anyNamed('notIn'),
                  authorIn: anyNamed('authorIn'),
                  categoryIn: anyNamed('categoryIn'),
                  categoryNotIn: anyNamed('categoryNotIn'),
                  tagIn: anyNamed('tagIn'),
                  tagNotIn: anyNamed('tagNotIn'),
                  first: anyNamed('first'),
                  after: anyNamed('after'),
                  last: anyNamed('last'),
                  before: anyNamed('before'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenAnswer(
                (_) async => testPostsModel,
              );

              final result = await repository.getPosts(
                search: testSearchTerm,
                first: testPostsCount,
                after: testPageKey,
                forceRefresh: testForceRefresh,
              );

              verify(
                mockWpRemoteDataSource.getPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Right<Failure, PostsModel>(testPostsModel),
              );
            },
          );

          test(
            'Should return request failure when the call to remote data source is unsuccessful',
            () async {
              when(
                mockWpRemoteDataSource.getPosts(
                  search: anyNamed('search'),
                  notIn: anyNamed('notIn'),
                  authorIn: anyNamed('authorIn'),
                  categoryIn: anyNamed('categoryIn'),
                  categoryNotIn: anyNamed('categoryNotIn'),
                  tagIn: anyNamed('tagIn'),
                  tagNotIn: anyNamed('tagNotIn'),
                  first: anyNamed('first'),
                  after: anyNamed('after'),
                  last: anyNamed('last'),
                  before: anyNamed('before'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                RequestException(),
              );

              final result = await repository.getPosts(
                search: testSearchTerm,
                first: testPostsCount,
                after: testPageKey,
                forceRefresh: testForceRefresh,
              );

              verify(
                mockWpRemoteDataSource.getPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, PostsModel>(RequestFailure()),
              );
            },
          );
        },
      );

      group(
        'Device is offline',
        () {
          test(
            'Should return network failure when the call to remote data source indicating that device is offline',
            () async {
              when(
                mockWpRemoteDataSource.getPosts(
                  search: anyNamed('search'),
                  notIn: anyNamed('notIn'),
                  authorIn: anyNamed('authorIn'),
                  categoryIn: anyNamed('categoryIn'),
                  categoryNotIn: anyNamed('categoryNotIn'),
                  tagIn: anyNamed('tagIn'),
                  tagNotIn: anyNamed('tagNotIn'),
                  first: anyNamed('first'),
                  after: anyNamed('after'),
                  last: anyNamed('last'),
                  before: anyNamed('before'),
                  forceRefresh: anyNamed('forceRefresh'),
                ),
              ).thenThrow(
                NetworkException(),
              );

              final result = await repository.getPosts(
                search: testSearchTerm,
                first: testPostsCount,
                after: testPageKey,
                forceRefresh: testForceRefresh,
              );

              verify(
                mockWpRemoteDataSource.getPosts(
                  search: testSearchTerm,
                  first: testPostsCount,
                  after: testPageKey,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, PostsModel>(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );
}
