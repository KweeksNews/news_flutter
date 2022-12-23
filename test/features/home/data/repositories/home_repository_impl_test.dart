import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/data/datasources/wp_remote_data_source.dart';
import 'package:kweeksnews_app/core/data/models/post_list_model.dart';
import 'package:kweeksnews_app/core/domain/error/exceptions.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/posts.dart';
import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([WpRemoteDataSource])
void main() {
  late MockWpRemoteDataSource mockWpRemoteDataSource;
  late HomeRepositoryImpl repository;

  setUp(
    () {
      mockWpRemoteDataSource = MockWpRemoteDataSource();
      repository = HomeRepositoryImpl(mockWpRemoteDataSource);
    },
  );

  group(
    'Get Posts',
    () {
      const int testPostsCount = 1;
      const bool testForceRefresh = false;
      final PostListModel testPostsModel = postsModel;

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
                postsCount: testPostsCount,
                forceRefresh: testForceRefresh,
              );

              verify(
                mockWpRemoteDataSource.getPosts(
                  first: testPostsCount,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Right<Failure, PostListModel>(testPostsModel),
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
                postsCount: testPostsCount,
                forceRefresh: testForceRefresh,
              );

              verify(
                mockWpRemoteDataSource.getPosts(
                  first: testPostsCount,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, PostListModel>(RequestFailure()),
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
                postsCount: testPostsCount,
                forceRefresh: testForceRefresh,
              );

              verify(
                mockWpRemoteDataSource.getPosts(
                  first: testPostsCount,
                  forceRefresh: testForceRefresh,
                ),
              );

              expect(
                result,
                Left<Failure, PostListModel>(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );
}
