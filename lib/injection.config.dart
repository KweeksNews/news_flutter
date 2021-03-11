// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:dio_http_cache/dio_http_cache.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import 'core/datasources/databases/database_utils.dart' as _i3;
import 'core/datasources/network/wordpress_apis.dart' as _i10;
import 'features/comments/data/repositories/comments_repository_impl.dart'
    as _i12;
import 'features/comments/domain/repositories/comments_repository.dart' as _i11;
import 'features/comments/domain/usecases/get_comments.dart' as _i15;
import 'features/comments/presentation/notifier/comments_notifier.dart' as _i26;
import 'features/contents/data/repositories/contents_repository_impl.dart'
    as _i14;
import 'features/contents/domain/repositories/contents_repository.dart' as _i13;
import 'features/contents/domain/usecases/get_posts.dart' as _i16;
import 'features/contents/presentation/notifier/contents_notifier.dart' as _i27;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i7;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i6;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i17;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i19;
import 'features/search/data/repositories/search_repository_impl.dart' as _i21;
import 'features/search/domain/repositories/search_repository.dart' as _i20;
import 'features/search/domain/usecases/search_posts.dart' as _i36;
import 'features/search/presentation/notifier/search_notifier.dart' as _i41;
import 'features/settings/data/datasources/identity_data_source.dart' as _i18;
import 'features/settings/data/datasources/theme_data_source.dart' as _i9;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i23;
import 'features/settings/domain/repositories/settings_repository.dart' as _i22;
import 'features/settings/domain/usecases/get_identity.dart' as _i30;
import 'features/settings/domain/usecases/get_theme.dart' as _i32;
import 'features/settings/domain/usecases/set_identity.dart' as _i37;
import 'features/settings/domain/usecases/set_theme.dart' as _i38;
import 'features/settings/presentation/notifier/identity_notifier.dart' as _i40;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i39;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i25;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i24;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i28;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i29;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i31;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i33;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i34;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i35;
import 'injection.dart' as _i42; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
  gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i5.DioCacheManager>(() => registerModule.dioCacheManager);
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i6.SavedPostsRepository>(() =>
      _i7.SavedPostsRepositoryImpl(savedPostsDao: get<_i3.SavedPostsDao>()));
  await gh.factoryAsync<_i8.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true);
  gh.lazySingleton<_i9.ThemeDataSource>(() =>
      _i9.ThemeDataSourceImpl(sharedPreferences: get<_i8.SharedPreferences>()));
  gh.lazySingleton<_i10.WpApi>(() => _i10.WpApi(
      dio: get<_i4.Dio>(), dioCacheManager: get<_i5.DioCacheManager>()));
  gh.lazySingleton<_i11.CommentsRepository>(
      () => _i12.CommentsRepositoryImpl(wpApi: get<_i10.WpApi>()));
  gh.lazySingleton<_i13.ContentsRepository>(
      () => _i14.ContentsRepositoryImpl(wpApi: get<_i10.WpApi>()));
  gh.lazySingleton<_i15.GetComments>(
      () => _i15.GetComments(get<_i11.CommentsRepository>()));
  gh.lazySingleton<_i16.GetPosts>(
      () => _i16.GetPosts(get<_i13.ContentsRepository>()));
  gh.lazySingleton<_i17.GetSavedPosts>(
      () => _i17.GetSavedPosts(get<_i6.SavedPostsRepository>()));
  gh.lazySingleton<_i18.IdentityDataSource>(() => _i18.IdentityDataSourceImpl(
      sharedPreferences: get<_i8.SharedPreferences>()));
  gh.lazySingleton<_i19.SavedPostsNotifier>(
      () => _i19.SavedPostsNotifier(getSavedPosts: get<_i17.GetSavedPosts>()));
  gh.lazySingleton<_i20.SearchRepository>(
      () => _i21.SearchRepositoryImpl(wpApi: get<_i10.WpApi>()));
  gh.lazySingleton<_i22.SettingsRepository>(() => _i23.SettingsRepositoryImpl(
      identityDataSource: get<_i18.IdentityDataSource>(),
      themeDataSource: get<_i9.ThemeDataSource>()));
  gh.lazySingleton<_i24.SinglePostRepository>(() =>
      _i25.SinglePostRepositoryImpl(
          savedPostsDao: get<_i3.SavedPostsDao>(), wpApi: get<_i10.WpApi>()));
  gh.factory<_i26.CommentsNotifier>(
      () => _i26.CommentsNotifier(getComments: get<_i15.GetComments>()));
  gh.factory<_i27.ContentsNotifier>(
      () => _i27.ContentsNotifier(getPosts: get<_i16.GetPosts>()));
  gh.lazySingleton<_i28.CreateSavedPost>(
      () => _i28.CreateSavedPost(get<_i24.SinglePostRepository>()));
  gh.lazySingleton<_i29.DeleteSavedPost>(
      () => _i29.DeleteSavedPost(get<_i24.SinglePostRepository>()));
  gh.lazySingleton<_i30.GetIdentity>(
      () => _i30.GetIdentity(get<_i22.SettingsRepository>()));
  gh.lazySingleton<_i31.GetRelatedPosts>(
      () => _i31.GetRelatedPosts(get<_i24.SinglePostRepository>()));
  gh.lazySingleton<_i32.GetTheme>(
      () => _i32.GetTheme(get<_i22.SettingsRepository>()));
  gh.lazySingleton<_i33.IsSavedPost>(
      () => _i33.IsSavedPost(get<_i24.SinglePostRepository>()));
  gh.lazySingleton<_i34.RelatedPostsNotifier>(() =>
      _i34.RelatedPostsNotifier(getRelatedPosts: get<_i31.GetRelatedPosts>()));
  gh.lazySingleton<_i35.SavedPostNotifier>(() => _i35.SavedPostNotifier(
      createSavedPost: get<_i28.CreateSavedPost>(),
      deleteSavedPost: get<_i29.DeleteSavedPost>(),
      isSavedPost: get<_i33.IsSavedPost>()));
  gh.lazySingleton<_i36.SearchPosts>(
      () => _i36.SearchPosts(get<_i20.SearchRepository>()));
  gh.lazySingleton<_i37.SetIdentity>(
      () => _i37.SetIdentity(get<_i22.SettingsRepository>()));
  gh.lazySingleton<_i38.SetTheme>(
      () => _i38.SetTheme(get<_i22.SettingsRepository>()));
  gh.factory<_i39.ThemeNotifier>(() => _i39.ThemeNotifier(
      getTheme: get<_i32.GetTheme>(), setTheme: get<_i38.SetTheme>()));
  gh.factory<_i40.IdentityNotifier>(() => _i40.IdentityNotifier(
      getIdentity: get<_i30.GetIdentity>(),
      setIdentity: get<_i37.SetIdentity>()));
  gh.factory<_i41.SearchNotifier>(
      () => _i41.SearchNotifier(searchPosts: get<_i36.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i42.RegisterModule {}
