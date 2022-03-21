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
import 'core/datasources/wp_remote_data_source.dart' as _i17;
import 'core/router/root_router_delegate.dart' as _i22;
import 'core/router/route_config.dart' as _i10;
import 'core/router/route_parser.dart' as _i11;
import 'core/router/route_state_notifier.dart' as _i12;
import 'features/home/data/repositories/home_repository_impl.dart' as _i20;
import 'features/home/domain/repositories/home_repository.dart' as _i19;
import 'features/home/domain/usecases/get_posts.dart' as _i34;
import 'features/home/presentation/notifier/home_notifier.dart' as _i37;
import 'features/lightbox/presentation/notifier/lightbox_notifier.dart' as _i7;
import 'features/navbar/presentation/router/navbar_router_delegate.dart'
    as _i21;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i14;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i13;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i18;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i23;
import 'features/search/data/repositories/search_repository_impl.dart' as _i25;
import 'features/search/domain/repositories/search_repository.dart' as _i24;
import 'features/search/domain/usecases/search_posts.dart' as _i41;
import 'features/search/presentation/notifier/search_notifier.dart' as _i15;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i9;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i16;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i27;
import 'features/settings/domain/repositories/settings_repository.dart' as _i26;
import 'features/settings/domain/usecases/get_locale.dart' as _i32;
import 'features/settings/domain/usecases/get_theme.dart' as _i36;
import 'features/settings/domain/usecases/set_locale.dart' as _i42;
import 'features/settings/domain/usecases/set_theme.dart' as _i43;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i46;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i45;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i29;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i28;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i30;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i31;
import 'features/single_post/domain/usecases/get_post.dart' as _i33;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i35;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i38;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i39;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i40;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i44;
import 'features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i8;
import 'injection.dart' as _i47; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i10.RouteConfig>(registerModule.initialRouteConfig);
  gh.singleton<_i11.RouteParser>(_i11.RouteParser(get<_i10.RouteConfig>()));
  gh.singleton<_i12.RouteStateNotifier>(_i12.RouteStateNotifier());
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i13.SavedPostsRepository>(
      () => _i14.SavedPostsRepositoryImpl(get<_i3.SavedPostsDao>()));
  gh.factory<_i15.SearchFieldNotifier>(() => _i15.SearchFieldNotifier());
  gh.lazySingleton<_i16.ThemeLocalDataSource>(() =>
      _i16.ThemeLocalDataSourceImpl(
          get<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i17.WpRemoteDataSource>(
      () => _i17.WpRemoteDataSourceImpl(get<_i6.GraphQLClient>()));
  gh.lazySingleton<_i18.GetSavedPosts>(
      () => _i18.GetSavedPosts(get<_i13.SavedPostsRepository>()));
  gh.lazySingleton<_i19.HomeRepository>(
      () => _i20.HomeRepositoryImpl(get<_i17.WpRemoteDataSource>()));
  gh.singleton<_i21.NavBarRouterDelegate>(_i21.NavBarRouterDelegate(
      get<_i5.GlobalKey<_i5.NavigatorState>>(
          instanceName: 'navBarNavigatorKey'),
      get<_i12.RouteStateNotifier>()));
  gh.singleton<_i22.RootRouterDelegate>(_i22.RootRouterDelegate(
      get<_i5.GlobalKey<_i5.NavigatorState>>(instanceName: 'rootNavigatorKey'),
      get<_i12.RouteStateNotifier>()));
  gh.factory<_i23.SavedPostsNotifier>(
      () => _i23.SavedPostsNotifier(get<_i18.GetSavedPosts>()));
  gh.lazySingleton<_i24.SearchRepository>(
      () => _i25.SearchRepositoryImpl(get<_i17.WpRemoteDataSource>()));
  gh.lazySingleton<_i26.SettingsRepository>(() => _i27.SettingsRepositoryImpl(
      get<_i16.ThemeLocalDataSource>(), get<_i9.LocaleLocalDataSource>()));
  gh.lazySingleton<_i28.SinglePostRepository>(() =>
      _i29.SinglePostRepositoryImpl(
          get<_i3.SavedPostsDao>(), get<_i17.WpRemoteDataSource>()));
  gh.lazySingleton<_i30.CreateSavedPost>(
      () => _i30.CreateSavedPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i31.DeleteSavedPost>(
      () => _i31.DeleteSavedPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i32.GetLocale>(
      () => _i32.GetLocale(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i33.GetPost>(
      () => _i33.GetPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i34.GetPosts>(
      () => _i34.GetPosts(get<_i19.HomeRepository>()));
  gh.lazySingleton<_i35.GetRelatedPosts>(
      () => _i35.GetRelatedPosts(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i36.GetTheme>(
      () => _i36.GetTheme(get<_i26.SettingsRepository>()));
  gh.factoryParam<_i37.HomeNotifier, String, dynamic>(
      (_categoryId, _) => _i37.HomeNotifier(get<_i34.GetPosts>(), _categoryId));
  gh.lazySingleton<_i38.IsSavedPost>(
      () => _i38.IsSavedPost(get<_i28.SinglePostRepository>()));
  gh.factory<_i39.RelatedPostsNotifier>(
      () => _i39.RelatedPostsNotifier(get<_i35.GetRelatedPosts>()));
  gh.factory<_i40.SavedPostNotifier>(() => _i40.SavedPostNotifier(
      get<_i30.CreateSavedPost>(),
      get<_i31.DeleteSavedPost>(),
      get<_i38.IsSavedPost>()));
  gh.lazySingleton<_i41.SearchPosts>(
      () => _i41.SearchPosts(get<_i24.SearchRepository>()));
  gh.lazySingleton<_i42.SetLocale>(
      () => _i42.SetLocale(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i43.SetTheme>(
      () => _i43.SetTheme(get<_i26.SettingsRepository>()));
  gh.factory<_i44.SinglePostNotifier>(
      () => _i44.SinglePostNotifier(get<_i33.GetPost>()));
  gh.factory<_i45.ThemeNotifier>(
      () => _i45.ThemeNotifier(get<_i36.GetTheme>(), get<_i43.SetTheme>()));
  gh.factory<_i46.LocaleNotifier>(
      () => _i46.LocaleNotifier(get<_i32.GetLocale>(), get<_i42.SetLocale>()));
  gh.factory<_i15.SearchNotifier>(
      () => _i15.SearchNotifier(get<_i41.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i47.RegisterModule {}
