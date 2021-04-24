// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:dio_http_cache/dio_http_cache.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import 'core/datasources/databases/database_utils.dart' as _i3;
import 'core/datasources/network/wordpress_apis.dart' as _i11;
import 'features/comments/data/repositories/comments_repository_impl.dart'
    as _i13;
import 'features/comments/domain/repositories/comments_repository.dart' as _i12;
import 'features/comments/domain/usecases/get_comments.dart' as _i16;
import 'features/comments/presentation/notifier/comments_notifier.dart' as _i27;
import 'features/contents/data/repositories/contents_repository_impl.dart'
    as _i15;
import 'features/contents/domain/repositories/contents_repository.dart' as _i14;
import 'features/contents/domain/usecases/get_posts.dart' as _i17;
import 'features/contents/presentation/notifier/contents_notifier.dart' as _i28;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i8;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i7;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i18;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i20;
import 'features/search/data/repositories/search_repository_impl.dart' as _i22;
import 'features/search/domain/repositories/search_repository.dart' as _i21;
import 'features/search/domain/usecases/search_posts.dart' as _i37;
import 'features/search/presentation/notifier/search_notifier.dart' as _i42;
import 'features/settings/data/datasources/identity_data_source.dart' as _i19;
import 'features/settings/data/datasources/theme_data_source.dart' as _i10;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i24;
import 'features/settings/domain/repositories/settings_repository.dart' as _i23;
import 'features/settings/domain/usecases/get_identity.dart' as _i31;
import 'features/settings/domain/usecases/get_theme.dart' as _i33;
import 'features/settings/domain/usecases/set_identity.dart' as _i38;
import 'features/settings/domain/usecases/set_theme.dart' as _i39;
import 'features/settings/presentation/notifier/identity_notifier.dart' as _i41;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i40;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i26;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i25;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i29;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i30;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i32;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i34;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i35;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i36;
import 'injection.dart' as _i43; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
  gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i5.DioCacheManager>(() => registerModule.dioCacheManager);
  gh.lazySingleton<_i6.InternetConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i7.SavedPostsRepository>(() =>
      _i8.SavedPostsRepositoryImpl(savedPostsDao: get<_i3.SavedPostsDao>()));
  await gh.factoryAsync<_i9.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true);
  gh.lazySingleton<_i10.ThemeDataSource>(() => _i10.ThemeDataSourceImpl(
      sharedPreferences: get<_i9.SharedPreferences>()));
  gh.lazySingleton<_i11.WpApi>(() => _i11.WpApi(
      connectionChecker: get<_i6.InternetConnectionChecker>(),
      dio: get<_i4.Dio>(),
      dioCacheManager: get<_i5.DioCacheManager>()));
  gh.lazySingleton<_i12.CommentsRepository>(
      () => _i13.CommentsRepositoryImpl(wpApi: get<_i11.WpApi>()));
  gh.lazySingleton<_i14.ContentsRepository>(
      () => _i15.ContentsRepositoryImpl(wpApi: get<_i11.WpApi>()));
  gh.lazySingleton<_i16.GetComments>(
      () => _i16.GetComments(get<_i12.CommentsRepository>()));
  gh.lazySingleton<_i17.GetPosts>(
      () => _i17.GetPosts(get<_i14.ContentsRepository>()));
  gh.lazySingleton<_i18.GetSavedPosts>(
      () => _i18.GetSavedPosts(get<_i7.SavedPostsRepository>()));
  gh.lazySingleton<_i19.IdentityDataSource>(() => _i19.IdentityDataSourceImpl(
      sharedPreferences: get<_i9.SharedPreferences>()));
  gh.lazySingleton<_i20.SavedPostsNotifier>(
      () => _i20.SavedPostsNotifier(getSavedPosts: get<_i18.GetSavedPosts>()));
  gh.lazySingleton<_i21.SearchRepository>(
      () => _i22.SearchRepositoryImpl(wpApi: get<_i11.WpApi>()));
  gh.lazySingleton<_i23.SettingsRepository>(() => _i24.SettingsRepositoryImpl(
      identityDataSource: get<_i19.IdentityDataSource>(),
      themeDataSource: get<_i10.ThemeDataSource>()));
  gh.lazySingleton<_i25.SinglePostRepository>(() =>
      _i26.SinglePostRepositoryImpl(
          savedPostsDao: get<_i3.SavedPostsDao>(), wpApi: get<_i11.WpApi>()));
  gh.factory<_i27.CommentsNotifier>(
      () => _i27.CommentsNotifier(getComments: get<_i16.GetComments>()));
  gh.factory<_i28.ContentsNotifier>(
      () => _i28.ContentsNotifier(getPosts: get<_i17.GetPosts>()));
  gh.lazySingleton<_i29.CreateSavedPost>(
      () => _i29.CreateSavedPost(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i30.DeleteSavedPost>(
      () => _i30.DeleteSavedPost(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i31.GetIdentity>(
      () => _i31.GetIdentity(get<_i23.SettingsRepository>()));
  gh.lazySingleton<_i32.GetRelatedPosts>(
      () => _i32.GetRelatedPosts(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i33.GetTheme>(
      () => _i33.GetTheme(get<_i23.SettingsRepository>()));
  gh.lazySingleton<_i34.IsSavedPost>(
      () => _i34.IsSavedPost(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i35.RelatedPostsNotifier>(() =>
      _i35.RelatedPostsNotifier(getRelatedPosts: get<_i32.GetRelatedPosts>()));
  gh.lazySingleton<_i36.SavedPostNotifier>(() => _i36.SavedPostNotifier(
      createSavedPost: get<_i29.CreateSavedPost>(),
      deleteSavedPost: get<_i30.DeleteSavedPost>(),
      isSavedPost: get<_i34.IsSavedPost>()));
  gh.lazySingleton<_i37.SearchPosts>(
      () => _i37.SearchPosts(get<_i21.SearchRepository>()));
  gh.lazySingleton<_i38.SetIdentity>(
      () => _i38.SetIdentity(get<_i23.SettingsRepository>()));
  gh.lazySingleton<_i39.SetTheme>(
      () => _i39.SetTheme(get<_i23.SettingsRepository>()));
  gh.factory<_i40.ThemeNotifier>(() => _i40.ThemeNotifier(
      getTheme: get<_i33.GetTheme>(), setTheme: get<_i39.SetTheme>()));
  gh.factory<_i41.IdentityNotifier>(() => _i41.IdentityNotifier(
      getIdentity: get<_i31.GetIdentity>(),
      setIdentity: get<_i38.SetIdentity>()));
  gh.factory<_i42.SearchNotifier>(
      () => _i42.SearchNotifier(searchPosts: get<_i37.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i43.RegisterModule {}
