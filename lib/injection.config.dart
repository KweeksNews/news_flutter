// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import 'core/databases/database_utils.dart' as _i3;
import 'core/datasources/wp_remote_data_source.dart' as _i15;
import 'core/router/root_router_delegate.dart' as _i20;
import 'core/router/route_config.dart' as _i8;
import 'core/router/route_parser.dart' as _i9;
import 'core/router/route_state_notifier.dart' as _i10;
import 'features/home/data/repositories/home_repository_impl.dart' as _i18;
import 'features/home/domain/repositories/home_repository.dart' as _i17;
import 'features/home/domain/usecases/get_posts.dart' as _i31;
import 'features/home/presentation/notifier/home_notifier.dart' as _i34;
import 'features/lightbox/presentation/notifier/lightbox_notifier.dart' as _i7;
import 'features/navbar/presentation/router/navbar_router_delegate.dart'
    as _i19;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i12;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i11;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i16;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i21;
import 'features/search/data/repositories/search_repository_impl.dart' as _i23;
import 'features/search/domain/repositories/search_repository.dart' as _i22;
import 'features/search/domain/usecases/search_posts.dart' as _i38;
import 'features/search/presentation/notifier/search_notifier.dart' as _i13;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i14;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i25;
import 'features/settings/domain/repositories/settings_repository.dart' as _i24;
import 'features/settings/domain/usecases/get_theme.dart' as _i33;
import 'features/settings/domain/usecases/set_theme.dart' as _i39;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i41;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i27;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i26;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i28;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i29;
import 'features/single_post/domain/usecases/get_post.dart' as _i30;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i32;
import 'features/single_post/domain/usecases/is_saved_post.dart' as _i35;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i36;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i37;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i40;
import 'injection.dart' as _i42; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
  await gh.singletonAsync<_i4.Box<dynamic>>(() => registerModule.box,
      preResolve: true);
  gh.lazySingleton<_i5.Dio>(() => registerModule.dio);
  gh.singleton<_i6.GlobalKey<_i6.NavigatorState>>(
      registerModule.navBarNavigatorKey,
      instanceName: 'navBarNavigatorKey');
  gh.singleton<_i6.GlobalKey<_i6.NavigatorState>>(
      registerModule.rootNavigatorKey,
      instanceName: 'rootNavigatorKey');
  gh.factory<_i7.LightboxNotifier>(() => _i7.LightboxNotifier());
  gh.singleton<_i6.RootBackButtonDispatcher>(
      registerModule.rootBackButtonDispatcher);
  gh.singleton<_i8.RouteConfig>(registerModule.initialRouteConfig);
  gh.singleton<_i9.RouteParser>(_i9.RouteParser(get<_i8.RouteConfig>()));
  gh.singleton<_i10.RouteStateNotifier>(_i10.RouteStateNotifier());
  gh.lazySingleton<_i3.SavedPostsDao>(
      () => _i3.SavedPostsDao(get<_i3.AppDatabase>()));
  gh.lazySingleton<_i11.SavedPostsRepository>(
      () => _i12.SavedPostsRepositoryImpl(get<_i3.SavedPostsDao>()));
  gh.factory<_i13.SearchFieldNotifier>(() => _i13.SearchFieldNotifier());
  gh.lazySingleton<_i14.ThemeLocalDataSource>(
      () => _i14.ThemeLocalDataSourceImpl(get<_i4.Box<dynamic>>()));
  gh.lazySingleton<_i15.WPRemoteDataSource>(
      () => _i15.WPRemoteDataSourceImpl(get<_i5.Dio>()));
  gh.lazySingleton<_i16.GetSavedPosts>(
      () => _i16.GetSavedPosts(get<_i11.SavedPostsRepository>()));
  gh.lazySingleton<_i17.HomeRepository>(
      () => _i18.HomeRepositoryImpl(get<_i15.WPRemoteDataSource>()));
  gh.singleton<_i19.NavBarRouterDelegate>(_i19.NavBarRouterDelegate(
      get<_i6.GlobalKey<_i6.NavigatorState>>(
          instanceName: 'navBarNavigatorKey'),
      get<_i10.RouteStateNotifier>()));
  gh.singleton<_i20.RootRouterDelegate>(_i20.RootRouterDelegate(
      get<_i6.GlobalKey<_i6.NavigatorState>>(instanceName: 'rootNavigatorKey'),
      get<_i10.RouteStateNotifier>()));
  gh.factory<_i21.SavedPostsNotifier>(
      () => _i21.SavedPostsNotifier(get<_i16.GetSavedPosts>()));
  gh.lazySingleton<_i22.SearchRepository>(
      () => _i23.SearchRepositoryImpl(get<_i15.WPRemoteDataSource>()));
  gh.lazySingleton<_i24.SettingsRepository>(
      () => _i25.SettingsRepositoryImpl(get<_i14.ThemeLocalDataSource>()));
  gh.lazySingleton<_i26.SinglePostRepository>(() =>
      _i27.SinglePostRepositoryImpl(
          get<_i3.SavedPostsDao>(), get<_i15.WPRemoteDataSource>()));
  gh.lazySingleton<_i28.CreateSavedPost>(
      () => _i28.CreateSavedPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i29.DeleteSavedPost>(
      () => _i29.DeleteSavedPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i30.GetPost>(
      () => _i30.GetPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i31.GetPosts>(
      () => _i31.GetPosts(get<_i17.HomeRepository>()));
  gh.lazySingleton<_i32.GetRelatedPosts>(
      () => _i32.GetRelatedPosts(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i33.GetTheme>(
      () => _i33.GetTheme(get<_i24.SettingsRepository>()));
  gh.factoryParam<_i34.HomeNotifier, String, dynamic>(
      (_categoryId, _) => _i34.HomeNotifier(get<_i31.GetPosts>(), _categoryId));
  gh.lazySingleton<_i35.IsSavedPost>(
      () => _i35.IsSavedPost(get<_i26.SinglePostRepository>()));
  gh.factory<_i36.RelatedPostsNotifier>(
      () => _i36.RelatedPostsNotifier(get<_i32.GetRelatedPosts>()));
  gh.factory<_i37.SavedPostNotifier>(() => _i37.SavedPostNotifier(
      get<_i28.CreateSavedPost>(),
      get<_i29.DeleteSavedPost>(),
      get<_i35.IsSavedPost>()));
  gh.lazySingleton<_i38.SearchPosts>(
      () => _i38.SearchPosts(get<_i22.SearchRepository>()));
  gh.lazySingleton<_i39.SetTheme>(
      () => _i39.SetTheme(get<_i24.SettingsRepository>()));
  gh.factory<_i40.SinglePostNotifier>(
      () => _i40.SinglePostNotifier(get<_i30.GetPost>()));
  gh.factory<_i41.ThemeNotifier>(
      () => _i41.ThemeNotifier(get<_i33.GetTheme>(), get<_i39.SetTheme>()));
  gh.factory<_i13.SearchNotifier>(
      () => _i13.SearchNotifier(get<_i38.SearchPosts>()));
  return get;
}

class _$RegisterModule extends _i42.RegisterModule {}
