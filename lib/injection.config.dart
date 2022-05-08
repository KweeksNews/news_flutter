// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i6;
import 'package:hive/hive.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import 'core/databases/database_utils.dart' as _i3;
import 'core/datasources/wp_remote_data_source.dart' as _i14;
import 'features/home/data/repositories/home_repository_impl.dart' as _i17;
import 'features/home/domain/repositories/home_repository.dart' as _i16;
import 'features/home/domain/usecases/get_posts.dart' as _i29;
import 'features/home/presentation/notifier/content_group_notifier.dart'
    as _i40;
import 'features/home/presentation/notifier/featured_content_notifier.dart'
    as _i41;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i11;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i10;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i15;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i18;
import 'features/search/data/repositories/search_repository_impl.dart' as _i20;
import 'features/search/domain/repositories/search_repository.dart' as _i19;
import 'features/search/domain/usecases/search_posts.dart' as _i35;
import 'features/search/presentation/notifier/search_notifier.dart' as _i12;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i9;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i13;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i22;
import 'features/settings/domain/repositories/settings_repository.dart' as _i21;
import 'features/settings/domain/usecases/get_locale.dart' as _i27;
import 'features/settings/domain/usecases/get_theme.dart' as _i31;
import 'features/settings/domain/usecases/set_locale.dart' as _i36;
import 'features/settings/domain/usecases/set_theme.dart' as _i37;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i42;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i39;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i24;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i23;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i25;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i26;
import 'features/single_post/domain/usecases/get_post.dart' as _i28;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i30;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i32;
import 'features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i7;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i33;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i34;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i38;
import 'features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i8;
import 'injection.dart' as _i43; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
  await gh.singletonAsync<_i4.Box<dynamic>>(() => registerModule.gqlCacheBox,
      instanceName: 'gqlCacheBox', preResolve: true);
  await gh.singletonAsync<_i4.Box<dynamic>>(() => registerModule.settingsBox,
      instanceName: 'settingsBox', preResolve: true);
  gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      registerModule.navBarNavigatorKey,
      instanceName: 'navBarNavigatorKey');
  gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      registerModule.rootNavigatorKey,
      instanceName: 'rootNavigatorKey');
  gh.lazySingleton<_i6.GraphQLClient>(() => registerModule
      .gqlClient(get<_i4.Box<dynamic>>(instanceName: 'gqlCacheBox')));
  gh.factory<_i7.LightboxNotifier>(() => _i7.LightboxNotifier());
  gh.factory<_i8.LoadingProgressNotifier>(() => _i8.LoadingProgressNotifier());
  gh.lazySingleton<_i9.LocaleLocalDataSource>(() =>
      _i9.LocaleLocalDataSourceImpl(
          get<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.singleton<_i5.RootBackButtonDispatcher>(
      registerModule.rootBackButtonDispatcher);
  gh.singleton<_i5.RouteInformationParser<Uri>>(
      registerModule.routeInformationParser);
  gh.singleton<_i5.RouterDelegate<Uri>>(registerModule.rootRouterDelegate,
      instanceName: 'rootRouterDelegate');
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i10.SavedPostsRepository>(
      () => _i11.SavedPostsRepositoryImpl(get<_i3.SavedPostsDao>()));
  gh.factory<_i12.SearchFieldNotifier>(() => _i12.SearchFieldNotifier());
  gh.lazySingleton<_i13.ThemeLocalDataSource>(() =>
      _i13.ThemeLocalDataSourceImpl(
          get<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i14.WpRemoteDataSource>(
      () => _i14.WpRemoteDataSourceImpl(get<_i6.GraphQLClient>()));
  gh.lazySingleton<_i15.GetSavedPosts>(
      () => _i15.GetSavedPosts(get<_i10.SavedPostsRepository>()));
  gh.lazySingleton<_i16.HomeRepository>(
      () => _i17.HomeRepositoryImpl(get<_i14.WpRemoteDataSource>()));
  gh.factory<_i18.SavedPostsNotifier>(
      () => _i18.SavedPostsNotifier(get<_i15.GetSavedPosts>()));
  gh.lazySingleton<_i19.SearchRepository>(
      () => _i20.SearchRepositoryImpl(get<_i14.WpRemoteDataSource>()));
  gh.lazySingleton<_i21.SettingsRepository>(() => _i22.SettingsRepositoryImpl(
      get<_i13.ThemeLocalDataSource>(), get<_i9.LocaleLocalDataSource>()));
  gh.lazySingleton<_i23.SinglePostRepository>(() =>
      _i24.SinglePostRepositoryImpl(
          get<_i3.SavedPostsDao>(), get<_i14.WpRemoteDataSource>()));
  gh.lazySingleton<_i25.CreateSavedPost>(
      () => _i25.CreateSavedPost(get<_i23.SinglePostRepository>()));
  gh.lazySingleton<_i26.DeleteSavedPost>(
      () => _i26.DeleteSavedPost(get<_i23.SinglePostRepository>()));
  gh.lazySingleton<_i27.GetLocale>(
      () => _i27.GetLocale(get<_i21.SettingsRepository>()));
  gh.lazySingleton<_i28.GetPost>(
      () => _i28.GetPost(get<_i23.SinglePostRepository>()));
  gh.lazySingleton<_i29.GetPosts>(
      () => _i29.GetPosts(get<_i16.HomeRepository>()));
  gh.lazySingleton<_i30.GetRelatedPosts>(
      () => _i30.GetRelatedPosts(get<_i23.SinglePostRepository>()));
  gh.lazySingleton<_i31.GetTheme>(
      () => _i31.GetTheme(get<_i21.SettingsRepository>()));
  gh.lazySingleton<_i32.IsSavedPost>(
      () => _i32.IsSavedPost(get<_i23.SinglePostRepository>()));
  gh.factory<_i33.RelatedPostsNotifier>(
      () => _i33.RelatedPostsNotifier(get<_i30.GetRelatedPosts>()));
  gh.factory<_i34.SavedPostNotifier>(() => _i34.SavedPostNotifier(
      get<_i25.CreateSavedPost>(),
      get<_i26.DeleteSavedPost>(),
      get<_i32.IsSavedPost>()));
  gh.lazySingleton<_i35.SearchPosts>(
      () => _i35.SearchPosts(get<_i19.SearchRepository>()));
  gh.lazySingleton<_i36.SetLocale>(
      () => _i36.SetLocale(get<_i21.SettingsRepository>()));
  gh.lazySingleton<_i37.SetTheme>(
      () => _i37.SetTheme(get<_i21.SettingsRepository>()));
  gh.factory<_i38.SinglePostNotifier>(
      () => _i38.SinglePostNotifier(get<_i28.GetPost>()));
  gh.factory<_i39.ThemeNotifier>(
      () => _i39.ThemeNotifier(get<_i31.GetTheme>(), get<_i37.SetTheme>()));
  gh.factory<_i40.ContentGroupNotifier>(
      () => _i40.ContentGroupNotifier(get<_i29.GetPosts>()));
  gh.factory<_i41.FeaturedContentNotifier>(
      () => _i41.FeaturedContentNotifier(get<_i29.GetPosts>()));
  gh.factory<_i42.LocaleNotifier>(
      () => _i42.LocaleNotifier(get<_i27.GetLocale>(), get<_i36.SetLocale>()));
  gh.factory<_i12.SearchNotifier>(
      () => _i12.SearchNotifier(get<_i35.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i43.RegisterModule {}
