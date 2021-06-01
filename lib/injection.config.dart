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
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import 'core/datasources/databases/database_utils.dart' as _i3;
import 'core/datasources/network/wordpress_apis.dart' as _i13;
import 'features/comments/data/repositories/comments_repository_impl.dart'
    as _i15;
import 'features/comments/domain/repositories/comments_repository.dart' as _i14;
import 'features/comments/domain/usecases/get_comments.dart' as _i18;
import 'features/comments/presentation/notifier/comments_notifier.dart' as _i29;
import 'features/contents/data/repositories/contents_repository_impl.dart'
    as _i17;
import 'features/contents/domain/repositories/contents_repository.dart' as _i16;
import 'features/contents/domain/usecases/get_posts.dart' as _i19;
import 'features/contents/presentation/notifier/contents_notifier.dart' as _i30;
import 'features/navbar/presentation/notifier/navbar_notifier.dart' as _i7;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i9;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i8;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i20;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i22;
import 'features/search/data/repositories/search_repository_impl.dart' as _i24;
import 'features/search/domain/repositories/search_repository.dart' as _i23;
import 'features/search/domain/usecases/search_posts.dart' as _i40;
import 'features/search/presentation/notifier/search_notifier.dart' as _i10;
import 'features/settings/data/datasources/identity_data_source.dart' as _i21;
import 'features/settings/data/datasources/theme_data_source.dart' as _i12;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i26;
import 'features/settings/domain/repositories/settings_repository.dart' as _i25;
import 'features/settings/domain/usecases/get_identity.dart' as _i33;
import 'features/settings/domain/usecases/get_theme.dart' as _i36;
import 'features/settings/domain/usecases/set_identity.dart' as _i41;
import 'features/settings/domain/usecases/set_theme.dart' as _i42;
import 'features/settings/presentation/notifier/identity_notifier.dart' as _i45;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i44;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i28;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i27;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i31;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i32;
import 'features/single_post/domain/usecases/get_post.dart' as _i34;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i35;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i37;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i38;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i39;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i43;
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
  gh.factory<_i10.SearchFieldNotifier>(() => _i10.SearchFieldNotifier());
  await gh.factoryAsync<_i11.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true);
  gh.lazySingleton<_i12.ThemeDataSource>(() => _i12.ThemeDataSourceImpl(
      sharedPreferences: get<_i11.SharedPreferences>()));
  gh.lazySingleton<_i13.WpApi>(() => _i13.WpApi(
      connectionChecker: get<_i6.InternetConnectionChecker>(),
      dio: get<_i4.Dio>(),
      dioCacheManager: get<_i5.DioCacheManager>()));
  gh.lazySingleton<_i14.CommentsRepository>(
      () => _i15.CommentsRepositoryImpl(wpApi: get<_i13.WpApi>()));
  gh.lazySingleton<_i16.ContentsRepository>(
      () => _i17.ContentsRepositoryImpl(wpApi: get<_i13.WpApi>()));
  gh.lazySingleton<_i18.GetComments>(
      () => _i18.GetComments(get<_i14.CommentsRepository>()));
  gh.lazySingleton<_i19.GetPosts>(
      () => _i19.GetPosts(get<_i16.ContentsRepository>()));
  gh.lazySingleton<_i20.GetSavedPosts>(
      () => _i20.GetSavedPosts(get<_i8.SavedPostsRepository>()));
  gh.lazySingleton<_i21.IdentityDataSource>(() => _i21.IdentityDataSourceImpl(
      sharedPreferences: get<_i11.SharedPreferences>()));
  gh.factory<_i22.SavedPostsNotifier>(
      () => _i22.SavedPostsNotifier(getSavedPosts: get<_i20.GetSavedPosts>()));
  gh.lazySingleton<_i23.SearchRepository>(
      () => _i24.SearchRepositoryImpl(wpApi: get<_i13.WpApi>()));
  gh.lazySingleton<_i25.SettingsRepository>(() => _i26.SettingsRepositoryImpl(
      identityDataSource: get<_i21.IdentityDataSource>(),
      themeDataSource: get<_i12.ThemeDataSource>()));
  gh.lazySingleton<_i27.SinglePostRepository>(() =>
      _i28.SinglePostRepositoryImpl(
          savedPostsDao: get<_i3.SavedPostsDao>(), wpApi: get<_i13.WpApi>()));
  gh.factory<_i29.CommentsNotifier>(
      () => _i29.CommentsNotifier(getComments: get<_i18.GetComments>()));
  gh.factoryParam<_i30.ContentsNotifier, String?, dynamic>((catId, _) =>
      _i30.ContentsNotifier(catId: catId, getPosts: get<_i19.GetPosts>()));
  gh.lazySingleton<_i31.CreateSavedPost>(
      () => _i31.CreateSavedPost(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i32.DeleteSavedPost>(
      () => _i32.DeleteSavedPost(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i33.GetIdentity>(
      () => _i33.GetIdentity(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i34.GetPost>(
      () => _i34.GetPost(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i35.GetRelatedPosts>(
      () => _i35.GetRelatedPosts(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i36.GetTheme>(
      () => _i36.GetTheme(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i37.IsSavedPost>(
      () => _i37.IsSavedPost(get<_i27.SinglePostRepository>()));
  gh.factory<_i38.RelatedPostsNotifier>(() =>
      _i38.RelatedPostsNotifier(getRelatedPosts: get<_i35.GetRelatedPosts>()));
  gh.factory<_i39.SavedPostNotifier>(() => _i39.SavedPostNotifier(
      createSavedPost: get<_i31.CreateSavedPost>(),
      deleteSavedPost: get<_i32.DeleteSavedPost>(),
      isSavedPost: get<_i37.IsSavedPost>()));
  gh.lazySingleton<_i40.SearchPosts>(
      () => _i40.SearchPosts(get<_i23.SearchRepository>()));
  gh.lazySingleton<_i41.SetIdentity>(
      () => _i41.SetIdentity(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i42.SetTheme>(
      () => _i42.SetTheme(get<_i25.SettingsRepository>()));
  gh.factory<_i43.SinglePostNotifier>(
      () => _i43.SinglePostNotifier(getPost: get<_i34.GetPost>()));
  gh.factory<_i44.ThemeNotifier>(() => _i44.ThemeNotifier(
      getTheme: get<_i36.GetTheme>(), setTheme: get<_i42.SetTheme>()));
  gh.factory<_i45.IdentityNotifier>(() => _i45.IdentityNotifier(
      getIdentity: get<_i33.GetIdentity>(),
      setIdentity: get<_i41.SetIdentity>()));
  gh.factory<_i10.SearchNotifier>(
      () => _i10.SearchNotifier(searchPosts: get<_i40.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i46.RegisterModule {}
