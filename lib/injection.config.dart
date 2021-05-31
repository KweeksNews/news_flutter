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
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import 'core/datasources/databases/database_utils.dart' as _i3;
import 'core/datasources/network/wordpress_apis.dart' as _i12;
import 'features/comments/data/repositories/comments_repository_impl.dart'
    as _i14;
import 'features/comments/domain/repositories/comments_repository.dart' as _i13;
import 'features/comments/domain/usecases/get_comments.dart' as _i17;
import 'features/comments/presentation/notifier/comments_notifier.dart' as _i28;
import 'features/contents/data/repositories/contents_repository_impl.dart'
    as _i16;
import 'features/contents/domain/repositories/contents_repository.dart' as _i15;
import 'features/contents/domain/usecases/get_posts.dart' as _i18;
import 'features/contents/presentation/notifier/contents_notifier.dart' as _i29;
import 'features/navbar/presentation/notifier/navbar_notifier.dart' as _i7;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i9;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i8;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i19;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i21;
import 'features/search/data/repositories/search_repository_impl.dart' as _i23;
import 'features/search/domain/repositories/search_repository.dart' as _i22;
import 'features/search/domain/usecases/search_posts.dart' as _i39;
import 'features/search/presentation/notifier/search_notifier.dart' as _i45;
import 'features/settings/data/datasources/identity_data_source.dart' as _i20;
import 'features/settings/data/datasources/theme_data_source.dart' as _i11;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i25;
import 'features/settings/domain/repositories/settings_repository.dart' as _i24;
import 'features/settings/domain/usecases/get_identity.dart' as _i32;
import 'features/settings/domain/usecases/get_theme.dart' as _i35;
import 'features/settings/domain/usecases/set_identity.dart' as _i40;
import 'features/settings/domain/usecases/set_theme.dart' as _i41;
import 'features/settings/presentation/notifier/identity_notifier.dart' as _i44;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i43;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i27;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i26;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i30;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i31;
import 'features/single_post/domain/usecases/get_post.dart' as _i33;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i34;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i36;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i37;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i38;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i42;
import 'injection.dart' as _i46; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.NavBarNotifier>(() => _i7.NavBarNotifier());
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i8.SavedPostsRepository>(() =>
      _i9.SavedPostsRepositoryImpl(savedPostsDao: get<_i3.SavedPostsDao>()));
  await gh.factoryAsync<_i10.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true);
  gh.lazySingleton<_i11.ThemeDataSource>(() => _i11.ThemeDataSourceImpl(
      sharedPreferences: get<_i10.SharedPreferences>()));
  gh.lazySingleton<_i12.WpApi>(() => _i12.WpApi(
      connectionChecker: get<_i6.InternetConnectionChecker>(),
      dio: get<_i4.Dio>(),
      dioCacheManager: get<_i5.DioCacheManager>()));
  gh.lazySingleton<_i13.CommentsRepository>(
      () => _i14.CommentsRepositoryImpl(wpApi: get<_i12.WpApi>()));
  gh.lazySingleton<_i15.ContentsRepository>(
      () => _i16.ContentsRepositoryImpl(wpApi: get<_i12.WpApi>()));
  gh.lazySingleton<_i17.GetComments>(
      () => _i17.GetComments(get<_i13.CommentsRepository>()));
  gh.lazySingleton<_i18.GetPosts>(
      () => _i18.GetPosts(get<_i15.ContentsRepository>()));
  gh.lazySingleton<_i19.GetSavedPosts>(
      () => _i19.GetSavedPosts(get<_i8.SavedPostsRepository>()));
  gh.lazySingleton<_i20.IdentityDataSource>(() => _i20.IdentityDataSourceImpl(
      sharedPreferences: get<_i10.SharedPreferences>()));
  gh.factory<_i21.SavedPostsNotifier>(
      () => _i21.SavedPostsNotifier(getSavedPosts: get<_i19.GetSavedPosts>()));
  gh.lazySingleton<_i22.SearchRepository>(
      () => _i23.SearchRepositoryImpl(wpApi: get<_i12.WpApi>()));
  gh.lazySingleton<_i24.SettingsRepository>(() => _i25.SettingsRepositoryImpl(
      identityDataSource: get<_i20.IdentityDataSource>(),
      themeDataSource: get<_i11.ThemeDataSource>()));
  gh.lazySingleton<_i26.SinglePostRepository>(() =>
      _i27.SinglePostRepositoryImpl(
          savedPostsDao: get<_i3.SavedPostsDao>(), wpApi: get<_i12.WpApi>()));
  gh.factory<_i28.CommentsNotifier>(
      () => _i28.CommentsNotifier(getComments: get<_i17.GetComments>()));
  gh.factoryParam<_i29.ContentsNotifier, String?, dynamic>((catId, _) =>
      _i29.ContentsNotifier(catId: catId, getPosts: get<_i18.GetPosts>()));
  gh.lazySingleton<_i30.CreateSavedPost>(
      () => _i30.CreateSavedPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i31.DeleteSavedPost>(
      () => _i31.DeleteSavedPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i32.GetIdentity>(
      () => _i32.GetIdentity(get<_i24.SettingsRepository>()));
  gh.lazySingleton<_i33.GetPost>(
      () => _i33.GetPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i34.GetRelatedPosts>(
      () => _i34.GetRelatedPosts(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i35.GetTheme>(
      () => _i35.GetTheme(get<_i24.SettingsRepository>()));
  gh.lazySingleton<_i36.IsSavedPost>(
      () => _i36.IsSavedPost(get<_i26.SinglePostRepository>()));
  gh.factory<_i37.RelatedPostsNotifier>(() =>
      _i37.RelatedPostsNotifier(getRelatedPosts: get<_i34.GetRelatedPosts>()));
  gh.factory<_i38.SavedPostNotifier>(() => _i38.SavedPostNotifier(
      createSavedPost: get<_i30.CreateSavedPost>(),
      deleteSavedPost: get<_i31.DeleteSavedPost>(),
      isSavedPost: get<_i36.IsSavedPost>()));
  gh.lazySingleton<_i39.SearchPosts>(
      () => _i39.SearchPosts(get<_i22.SearchRepository>()));
  gh.lazySingleton<_i40.SetIdentity>(
      () => _i40.SetIdentity(get<_i24.SettingsRepository>()));
  gh.lazySingleton<_i41.SetTheme>(
      () => _i41.SetTheme(get<_i24.SettingsRepository>()));
  gh.factory<_i42.SinglePostNotifier>(
      () => _i42.SinglePostNotifier(getPost: get<_i33.GetPost>()));
  gh.factory<_i43.ThemeNotifier>(() => _i43.ThemeNotifier(
      getTheme: get<_i35.GetTheme>(), setTheme: get<_i41.SetTheme>()));
  gh.factory<_i44.IdentityNotifier>(() => _i44.IdentityNotifier(
      getIdentity: get<_i32.GetIdentity>(),
      setIdentity: get<_i40.SetIdentity>()));
  gh.factory<_i45.SearchNotifier>(
      () => _i45.SearchNotifier(searchPosts: get<_i39.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i46.RegisterModule {}
