// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:dio_http_cache/dio_http_cache.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i9;

import 'core/datasources/databases/database_utils.dart' as _i3;
import 'core/datasources/network/wordpress_apis.dart' as _i15;
import 'features/comments/data/repositories/comments_repository_impl.dart'
    as _i17;
import 'features/comments/domain/repositories/comments_repository.dart' as _i16;
import 'features/comments/domain/usecases/get_comments.dart' as _i20;
import 'features/comments/presentation/notifier/comments_notifier.dart' as _i30;
import 'features/contents/data/repositories/contents_repository_impl.dart'
    as _i19;
import 'features/contents/domain/repositories/contents_repository.dart' as _i18;
import 'features/contents/domain/usecases/get_posts.dart' as _i21;
import 'features/contents/presentation/notifier/contents_notifier.dart' as _i31;
import 'features/image_gallery/presentation/notifier/image_gallery_notifier.dart'
    as _i8;
import 'features/navbar/presentation/notifier/navbar_notifier.dart' as _i10;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i12;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i11;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i22;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i23;
import 'features/search/data/repositories/search_repository_impl.dart' as _i25;
import 'features/search/domain/repositories/search_repository.dart' as _i24;
import 'features/search/domain/usecases/search_posts.dart' as _i41;
import 'features/search/presentation/notifier/search_notifier.dart' as _i13;
import 'features/settings/data/datasources/identity_data_source.dart' as _i6;
import 'features/settings/data/datasources/theme_data_source.dart' as _i14;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i27;
import 'features/settings/domain/repositories/settings_repository.dart' as _i26;
import 'features/settings/domain/usecases/get_identity.dart' as _i34;
import 'features/settings/domain/usecases/get_theme.dart' as _i37;
import 'features/settings/domain/usecases/set_identity.dart' as _i42;
import 'features/settings/domain/usecases/set_theme.dart' as _i43;
import 'features/settings/presentation/notifier/identity_notifier.dart' as _i46;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i45;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i29;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i28;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i32;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i33;
import 'features/single_post/domain/usecases/get_post.dart' as _i35;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i36;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i38;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i39;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i40;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i44;
import 'injection.dart' as _i47; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
  gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i5.DioCacheManager>(() => registerModule.dioCacheManager);
  gh.lazySingleton<_i6.IdentityDataSource>(
      () => _i6.IdentityDataSourceImpl(box: get<_i7.Box<dynamic>>()));
  gh.factory<_i8.ImageGalleryNotifier>(() => _i8.ImageGalleryNotifier());
  gh.lazySingleton<_i9.InternetConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.factory<_i10.NavBarNotifier>(() => _i10.NavBarNotifier());
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i11.SavedPostsRepository>(() =>
      _i12.SavedPostsRepositoryImpl(savedPostsDao: get<_i3.SavedPostsDao>()));
  gh.factory<_i13.SearchFieldNotifier>(() => _i13.SearchFieldNotifier());
  gh.lazySingleton<_i14.ThemeDataSource>(
      () => _i14.ThemeDataSourceImpl(box: get<_i7.Box<dynamic>>()));
  gh.lazySingleton<_i15.WpApi>(() => _i15.WpApi(
      connectionChecker: get<_i9.InternetConnectionChecker>(),
      dio: get<_i4.Dio>(),
      dioCacheManager: get<_i5.DioCacheManager>()));
  gh.lazySingleton<_i16.CommentsRepository>(
      () => _i17.CommentsRepositoryImpl(wpApi: get<_i15.WpApi>()));
  gh.lazySingleton<_i18.ContentsRepository>(
      () => _i19.ContentsRepositoryImpl(wpApi: get<_i15.WpApi>()));
  gh.lazySingleton<_i20.GetComments>(
      () => _i20.GetComments(get<_i16.CommentsRepository>()));
  gh.lazySingleton<_i21.GetPosts>(
      () => _i21.GetPosts(get<_i18.ContentsRepository>()));
  gh.lazySingleton<_i22.GetSavedPosts>(
      () => _i22.GetSavedPosts(get<_i11.SavedPostsRepository>()));
  gh.factory<_i23.SavedPostsNotifier>(
      () => _i23.SavedPostsNotifier(getSavedPosts: get<_i22.GetSavedPosts>()));
  gh.lazySingleton<_i24.SearchRepository>(
      () => _i25.SearchRepositoryImpl(wpApi: get<_i15.WpApi>()));
  gh.lazySingleton<_i26.SettingsRepository>(() => _i27.SettingsRepositoryImpl(
      identityDataSource: get<_i6.IdentityDataSource>(),
      themeDataSource: get<_i14.ThemeDataSource>()));
  gh.lazySingleton<_i28.SinglePostRepository>(() =>
      _i29.SinglePostRepositoryImpl(
          savedPostsDao: get<_i3.SavedPostsDao>(), wpApi: get<_i15.WpApi>()));
  gh.factory<_i30.CommentsNotifier>(
      () => _i30.CommentsNotifier(getComments: get<_i20.GetComments>()));
  gh.factoryParam<_i31.ContentsNotifier, String?, dynamic>((catId, _) =>
      _i31.ContentsNotifier(catId: catId, getPosts: get<_i21.GetPosts>()));
  gh.lazySingleton<_i32.CreateSavedPost>(
      () => _i32.CreateSavedPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i33.DeleteSavedPost>(
      () => _i33.DeleteSavedPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i34.GetIdentity>(
      () => _i34.GetIdentity(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i35.GetPost>(
      () => _i35.GetPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i36.GetRelatedPosts>(
      () => _i36.GetRelatedPosts(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i37.GetTheme>(
      () => _i37.GetTheme(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i38.IsSavedPost>(
      () => _i38.IsSavedPost(get<_i28.SinglePostRepository>()));
  gh.factory<_i39.RelatedPostsNotifier>(() =>
      _i39.RelatedPostsNotifier(getRelatedPosts: get<_i36.GetRelatedPosts>()));
  gh.factory<_i40.SavedPostNotifier>(() => _i40.SavedPostNotifier(
      createSavedPost: get<_i32.CreateSavedPost>(),
      deleteSavedPost: get<_i33.DeleteSavedPost>(),
      isSavedPost: get<_i38.IsSavedPost>()));
  gh.lazySingleton<_i41.SearchPosts>(
      () => _i41.SearchPosts(get<_i24.SearchRepository>()));
  gh.lazySingleton<_i42.SetIdentity>(
      () => _i42.SetIdentity(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i43.SetTheme>(
      () => _i43.SetTheme(get<_i26.SettingsRepository>()));
  gh.factory<_i44.SinglePostNotifier>(
      () => _i44.SinglePostNotifier(getPost: get<_i35.GetPost>()));
  gh.factory<_i45.ThemeNotifier>(() => _i45.ThemeNotifier(
      getTheme: get<_i37.GetTheme>(), setTheme: get<_i43.SetTheme>()));
  gh.factory<_i46.IdentityNotifier>(() => _i46.IdentityNotifier(
      getIdentity: get<_i34.GetIdentity>(),
      setIdentity: get<_i42.SetIdentity>()));
  gh.factory<_i13.SearchNotifier>(
      () => _i13.SearchNotifier(searchPosts: get<_i41.SearchPosts>()));
  await gh.singletonAsync<_i7.Box<dynamic>>(() => registerModule.box,
      preResolve: true);
  return get;
}

class _$RegisterModule extends _i47.RegisterModule {}
