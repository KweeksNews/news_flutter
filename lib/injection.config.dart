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
import 'core/datasources/wp_remote_data_source.dart' as _i16;
import 'core/router/root_router_delegate.dart' as _i21;
import 'core/router/route_config.dart' as _i9;
import 'core/router/route_parser.dart' as _i10;
import 'core/router/route_state_notifier.dart' as _i11;
import 'features/home/data/repositories/home_repository_impl.dart' as _i19;
import 'features/home/domain/repositories/home_repository.dart' as _i18;
import 'features/home/domain/usecases/get_posts.dart' as _i33;
import 'features/home/presentation/notifier/home_notifier.dart' as _i36;
import 'features/lightbox/presentation/notifier/lightbox_notifier.dart' as _i7;
import 'features/navbar/presentation/router/navbar_router_delegate.dart'
    as _i20;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i13;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i12;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i17;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i22;
import 'features/search/data/repositories/search_repository_impl.dart' as _i24;
import 'features/search/domain/repositories/search_repository.dart' as _i23;
import 'features/search/domain/usecases/search_posts.dart' as _i40;
import 'features/search/presentation/notifier/search_notifier.dart' as _i14;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i8;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i15;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i26;
import 'features/settings/domain/repositories/settings_repository.dart' as _i25;
import 'features/settings/domain/usecases/get_locale.dart' as _i31;
import 'features/settings/domain/usecases/get_theme.dart' as _i35;
import 'features/settings/domain/usecases/set_locale.dart' as _i41;
import 'features/settings/domain/usecases/set_theme.dart' as _i42;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i45;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i44;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i28;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i27;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i29;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i30;
import 'features/single_post/domain/usecases/get_post.dart' as _i32;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i34;
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
  gh.lazySingleton<_i8.LocaleLocalDataSource>(() =>
      _i8.LocaleLocalDataSourceImpl(
          get<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.singleton<_i5.RootBackButtonDispatcher>(
      registerModule.rootBackButtonDispatcher);
  gh.singleton<_i9.RouteConfig>(registerModule.initialRouteConfig);
  gh.singleton<_i10.RouteParser>(_i10.RouteParser(get<_i9.RouteConfig>()));
  gh.singleton<_i11.RouteStateNotifier>(_i11.RouteStateNotifier());
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i12.SavedPostsRepository>(
      () => _i13.SavedPostsRepositoryImpl(get<_i3.SavedPostsDao>()));
  gh.factory<_i14.SearchFieldNotifier>(() => _i14.SearchFieldNotifier());
  gh.lazySingleton<_i15.ThemeLocalDataSource>(() =>
      _i15.ThemeLocalDataSourceImpl(
          get<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i16.WpRemoteDataSource>(
      () => _i16.WpRemoteDataSourceImpl(get<_i6.GraphQLClient>()));
  gh.lazySingleton<_i17.GetSavedPosts>(
      () => _i17.GetSavedPosts(get<_i12.SavedPostsRepository>()));
  gh.lazySingleton<_i18.HomeRepository>(
      () => _i19.HomeRepositoryImpl(get<_i16.WpRemoteDataSource>()));
  gh.singleton<_i20.NavBarRouterDelegate>(_i20.NavBarRouterDelegate(
      get<_i5.GlobalKey<_i5.NavigatorState>>(
          instanceName: 'navBarNavigatorKey'),
      get<_i11.RouteStateNotifier>()));
  gh.singleton<_i21.RootRouterDelegate>(_i21.RootRouterDelegate(
      get<_i5.GlobalKey<_i5.NavigatorState>>(instanceName: 'rootNavigatorKey'),
      get<_i11.RouteStateNotifier>()));
  gh.factory<_i22.SavedPostsNotifier>(
      () => _i22.SavedPostsNotifier(get<_i17.GetSavedPosts>()));
  gh.lazySingleton<_i23.SearchRepository>(
      () => _i24.SearchRepositoryImpl(get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i25.SettingsRepository>(() => _i26.SettingsRepositoryImpl(
      get<_i15.ThemeLocalDataSource>(), get<_i8.LocaleLocalDataSource>()));
  gh.lazySingleton<_i27.SinglePostRepository>(() =>
      _i28.SinglePostRepositoryImpl(
          get<_i3.SavedPostsDao>(), get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i29.CreateSavedPost>(
      () => _i29.CreateSavedPost(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i30.DeleteSavedPost>(
      () => _i30.DeleteSavedPost(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i31.GetLocale>(
      () => _i31.GetLocale(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i32.GetPost>(
      () => _i32.GetPost(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i33.GetPosts>(
      () => _i33.GetPosts(get<_i18.HomeRepository>()));
  gh.lazySingleton<_i34.GetRelatedPosts>(
      () => _i34.GetRelatedPosts(get<_i27.SinglePostRepository>()));
  gh.lazySingleton<_i35.GetTheme>(
      () => _i35.GetTheme(get<_i25.SettingsRepository>()));
  gh.factoryParam<_i36.HomeNotifier, String, dynamic>(
      (_categoryId, _) => _i36.HomeNotifier(get<_i33.GetPosts>(), _categoryId));
  gh.lazySingleton<_i37.IsSavedPost>(
      () => _i37.IsSavedPost(get<_i27.SinglePostRepository>()));
  gh.factory<_i38.RelatedPostsNotifier>(
      () => _i38.RelatedPostsNotifier(get<_i34.GetRelatedPosts>()));
  gh.factory<_i39.SavedPostNotifier>(() => _i39.SavedPostNotifier(
      get<_i29.CreateSavedPost>(),
      get<_i30.DeleteSavedPost>(),
      get<_i37.IsSavedPost>()));
  gh.lazySingleton<_i40.SearchPosts>(
      () => _i40.SearchPosts(get<_i23.SearchRepository>()));
  gh.lazySingleton<_i41.SetLocale>(
      () => _i41.SetLocale(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i42.SetTheme>(
      () => _i42.SetTheme(get<_i25.SettingsRepository>()));
  gh.factory<_i43.SinglePostNotifier>(
      () => _i43.SinglePostNotifier(get<_i32.GetPost>()));
  gh.factory<_i44.ThemeNotifier>(
      () => _i44.ThemeNotifier(get<_i35.GetTheme>(), get<_i42.SetTheme>()));
  gh.factory<_i45.LocaleNotifier>(
      () => _i45.LocaleNotifier(get<_i31.GetLocale>(), get<_i41.SetLocale>()));
  gh.factory<_i14.SearchNotifier>(
      () => _i14.SearchNotifier(get<_i40.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i46.RegisterModule {}
