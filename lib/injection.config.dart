// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:drift/drift.dart' as _i9;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i63;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i5;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'core/databases/databases.dart' as _i13;
import 'core/datasources/saved_posts_local_data_source.dart' as _i16;
import 'core/datasources/wp_remote_data_source.dart' as _i12;
import 'features/home/data/repositories/home_repository_impl.dart' as _i15;
import 'features/home/domain/repositories/home_repository.dart' as _i14;
import 'features/home/domain/usecases/get_posts.dart' as _i39;
import 'features/home/presentation/notifier/content_group_notifier.dart'
    as _i60;
import 'features/home/presentation/notifier/featured_content_notifier.dart'
    as _i61;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i18;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i17;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i42;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i48;
import 'features/search/data/repositories/search_repository_impl.dart' as _i20;
import 'features/search/domain/repositories/search_repository.dart' as _i19;
import 'features/search/domain/usecases/search_posts.dart' as _i49;
import 'features/search/presentation/notifier/search_notifier.dart' as _i10;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i8;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i11;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i22;
import 'features/settings/domain/repositories/settings_repository.dart' as _i21;
import 'features/settings/domain/usecases/get_locale.dart' as _i35;
import 'features/settings/domain/usecases/get_theme.dart' as _i44;
import 'features/settings/domain/usecases/set_locale.dart' as _i50;
import 'features/settings/domain/usecases/set_theme.dart' as _i51;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i62;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i57;
import 'features/single_category/data/repositories/single_category_repository_impl.dart'
    as _i24;
import 'features/single_category/domain/repositories/single_category_repository.dart'
    as _i23;
import 'features/single_category/domain/usecases/get_category.dart' as _i34;
import 'features/single_category/domain/usecases/get_posts.dart' as _i38;
import 'features/single_category/presentation/notifier/category_posts_notifier.dart'
    as _i59;
import 'features/single_category/presentation/notifier/single_category_notifier.dart'
    as _i52;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i26;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i25;
import 'features/single_post/domain/usecases/check_post_save_status.dart'
    as _i31;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i32;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i33;
import 'features/single_post/domain/usecases/get_post.dart' as _i36;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i41;
import 'features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i6;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i46;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i47;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i53;
import 'features/single_tag/data/repositories/single_tag_repository_impl.dart'
    as _i28;
import 'features/single_tag/domain/repositories/single_tag_repository.dart'
    as _i27;
import 'features/single_tag/domain/usecases/get_posts.dart' as _i40;
import 'features/single_tag/domain/usecases/get_tag.dart' as _i43;
import 'features/single_tag/presentation/notifier/single_tag_notifier.dart'
    as _i54;
import 'features/single_tag/presentation/notifier/tag_posts_notifier.dart'
    as _i56;
import 'features/single_user/data/repositories/single_user_repository_impl.dart'
    as _i30;
import 'features/single_user/domain/repositories/single_user_repository.dart'
    as _i29;
import 'features/single_user/domain/usecases/get_posts.dart' as _i37;
import 'features/single_user/domain/usecases/get_user.dart' as _i45;
import 'features/single_user/presentation/notifier/single_user_notifier.dart'
    as _i55;
import 'features/single_user/presentation/notifier/user_posts_notifier.dart'
    as _i58;
import 'features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i7;
import 'injection.dart' as _i64; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.singletonAsync<_i3.Box<Map<dynamic, dynamic>>>(
      () => registerModule.gqlCacheBox,
      instanceName: 'gqlCacheBox',
      preResolve: true);
  await gh.singletonAsync<_i3.Box<dynamic>>(() => registerModule.settingsBox,
      instanceName: 'settingsBox', preResolve: true);
  gh.singleton<_i4.GlobalKey<_i4.NavigatorState>>(
      registerModule.navBarNavigatorKey,
      instanceName: 'navBarNavigatorKey');
  gh.singleton<_i4.GlobalKey<_i4.NavigatorState>>(
      registerModule.rootNavigatorKey,
      instanceName: 'rootNavigatorKey');
  gh.lazySingleton<_i5.GraphQLClient>(() => registerModule.gqlClient(
      get<_i3.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
  gh.factory<_i6.LightboxNotifier>(() => _i6.LightboxNotifier());
  gh.factory<_i7.LoadingProgressNotifier>(() => _i7.LoadingProgressNotifier());
  gh.lazySingleton<_i8.LocaleLocalDataSource>(() =>
      _i8.LocaleLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.singleton<_i9.QueryExecutor>(registerModule.queryExecutor);
  gh.singleton<_i4.RootBackButtonDispatcher>(
      registerModule.rootBackButtonDispatcher);
  gh.singleton<_i4.RouteInformationParser<Uri>>(
      registerModule.routeInformationParser);
  gh.singleton<_i4.RouterDelegate<Uri>>(registerModule.rootRouterDelegate,
      instanceName: 'rootRouterDelegate');
  gh.factory<_i10.SearchBarFilledStatusNotifier>(
      () => _i10.SearchBarFilledStatusNotifier());
  gh.factory<_i10.SearchTermNotifier>(() => _i10.SearchTermNotifier());
  gh.lazySingleton<_i11.ThemeLocalDataSource>(() =>
      _i11.ThemeLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i12.WpRemoteDataSource>(
      () => _i12.WpRemoteDataSourceImpl(get<_i5.GraphQLClient>()));
  gh.lazySingleton<_i13.AppDatabase>(
      () => _i13.AppDatabase(get<_i9.QueryExecutor>()));
  gh.lazySingleton<_i14.HomeRepository>(
      () => _i15.HomeRepositoryImpl(get<_i12.WpRemoteDataSource>()));
  gh.lazySingleton<_i16.SavedPostsLocalDataSource>(
      () => _i16.SavedPostsLocalDataSource(get<_i13.AppDatabase>()));
  gh.lazySingleton<_i17.SavedPostsRepository>(() =>
      _i18.SavedPostsRepositoryImpl(get<_i16.SavedPostsLocalDataSource>()));
  gh.lazySingleton<_i19.SearchRepository>(
      () => _i20.SearchRepositoryImpl(get<_i12.WpRemoteDataSource>()));
  gh.lazySingleton<_i21.SettingsRepository>(() => _i22.SettingsRepositoryImpl(
      get<_i11.ThemeLocalDataSource>(), get<_i8.LocaleLocalDataSource>()));
  gh.lazySingleton<_i23.SingleCategoryRepository>(
      () => _i24.SingleCategoryRepositoryImpl(get<_i12.WpRemoteDataSource>()));
  gh.lazySingleton<_i25.SinglePostRepository>(() =>
      _i26.SinglePostRepositoryImpl(get<_i16.SavedPostsLocalDataSource>(),
          get<_i12.WpRemoteDataSource>()));
  gh.lazySingleton<_i27.SingleTagRepository>(
      () => _i28.SingleTagRepositoryImpl(get<_i12.WpRemoteDataSource>()));
  gh.lazySingleton<_i29.SingleUserRepository>(
      () => _i30.SingleUserRepositoryImpl(get<_i12.WpRemoteDataSource>()));
  gh.lazySingleton<_i31.CheckPostSaveStatus>(
      () => _i31.CheckPostSaveStatus(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i32.CreateSavedPost>(
      () => _i32.CreateSavedPost(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i33.DeleteSavedPost>(
      () => _i33.DeleteSavedPost(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i34.GetCategory>(
      () => _i34.GetCategory(get<_i23.SingleCategoryRepository>()));
  gh.lazySingleton<_i35.GetLocale>(
      () => _i35.GetLocale(get<_i21.SettingsRepository>()));
  gh.lazySingleton<_i36.GetPost>(
      () => _i36.GetPost(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i37.GetPosts>(
      () => _i37.GetPosts(get<_i29.SingleUserRepository>()));
  gh.lazySingleton<_i38.GetPosts>(
      () => _i38.GetPosts(get<_i23.SingleCategoryRepository>()));
  gh.lazySingleton<_i39.GetPosts>(
      () => _i39.GetPosts(get<_i14.HomeRepository>()));
  gh.lazySingleton<_i40.GetPosts>(
      () => _i40.GetPosts(get<_i27.SingleTagRepository>()));
  gh.lazySingleton<_i41.GetRelatedPosts>(
      () => _i41.GetRelatedPosts(get<_i25.SinglePostRepository>()));
  gh.lazySingleton<_i42.GetSavedPosts>(
      () => _i42.GetSavedPosts(get<_i17.SavedPostsRepository>()));
  gh.lazySingleton<_i43.GetTag>(
      () => _i43.GetTag(get<_i27.SingleTagRepository>()));
  gh.lazySingleton<_i44.GetTheme>(
      () => _i44.GetTheme(get<_i21.SettingsRepository>()));
  gh.lazySingleton<_i45.GetUser>(
      () => _i45.GetUser(get<_i29.SingleUserRepository>()));
  gh.factory<_i46.RelatedPostsNotifier>(
      () => _i46.RelatedPostsNotifier(get<_i41.GetRelatedPosts>()));
  gh.factory<_i47.SavedPostNotifier>(() => _i47.SavedPostNotifier(
      get<_i32.CreateSavedPost>(),
      get<_i33.DeleteSavedPost>(),
      get<_i31.CheckPostSaveStatus>()));
  gh.factory<_i48.SavedPostsNotifier>(
      () => _i48.SavedPostsNotifier(get<_i42.GetSavedPosts>()));
  gh.lazySingleton<_i49.SearchPosts>(
      () => _i49.SearchPosts(get<_i19.SearchRepository>()));
  gh.lazySingleton<_i50.SetLocale>(
      () => _i50.SetLocale(get<_i21.SettingsRepository>()));
  gh.lazySingleton<_i51.SetTheme>(
      () => _i51.SetTheme(get<_i21.SettingsRepository>()));
  gh.factory<_i52.SingleCategoryNotifier>(
      () => _i52.SingleCategoryNotifier(get<_i34.GetCategory>()));
  gh.factory<_i53.SinglePostNotifier>(
      () => _i53.SinglePostNotifier(get<_i36.GetPost>()));
  gh.factory<_i54.SingleTagNotifier>(
      () => _i54.SingleTagNotifier(get<_i43.GetTag>()));
  gh.factory<_i55.SingleUserNotifier>(
      () => _i55.SingleUserNotifier(get<_i45.GetUser>()));
  gh.factory<_i56.TagPostsNotifier>(
      () => _i56.TagPostsNotifier(get<_i40.GetPosts>()));
  gh.factory<_i57.ThemeNotifier>(
      () => _i57.ThemeNotifier(get<_i44.GetTheme>(), get<_i51.SetTheme>()));
  gh.factory<_i58.UserPostsNotifier>(
      () => _i58.UserPostsNotifier(get<_i37.GetPosts>()));
  gh.factory<_i59.CategoryPostsNotifier>(
      () => _i59.CategoryPostsNotifier(get<_i38.GetPosts>()));
  gh.factory<_i60.ContentGroupNotifier>(
      () => _i60.ContentGroupNotifier(get<_i39.GetPosts>()));
  gh.factory<_i61.FeaturedContentNotifier>(
      () => _i61.FeaturedContentNotifier(get<_i39.GetPosts>()));
  gh.factory<_i62.LocaleNotifier>(
      () => _i62.LocaleNotifier(get<_i35.GetLocale>(), get<_i50.SetLocale>()));
  gh.factoryParam<_i10.SearchNotifier, _i63.Reader, dynamic>(
      (_read, _) => _i10.SearchNotifier(get<_i49.SearchPosts>(), _read));
  return get;
}

class _$RegisterModule extends _i64.RegisterModule {}
