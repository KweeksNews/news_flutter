// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:drift/drift.dart' as _i10;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i64;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i6;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'core/databases/databases.dart' as _i14;
import 'core/datasources/saved_posts_local_data_source.dart' as _i17;
import 'core/datasources/wp_remote_data_source.dart' as _i13;
import 'features/home/data/repositories/home_repository_impl.dart' as _i16;
import 'features/home/domain/repositories/home_repository.dart' as _i15;
import 'features/home/domain/usecases/get_posts.dart' as _i38;
import 'features/home/presentation/notifier/content_group_notifier.dart'
    as _i61;
import 'features/home/presentation/notifier/featured_content_notifier.dart'
    as _i62;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i19;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i18;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i43;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i49;
import 'features/saved_posts/presentation/pages/saved_posts.dart' as _i5;
import 'features/search/data/repositories/search_repository_impl.dart' as _i21;
import 'features/search/domain/repositories/search_repository.dart' as _i20;
import 'features/search/domain/usecases/search_posts.dart' as _i50;
import 'features/search/presentation/notifier/search_notifier.dart' as _i11;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i9;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i12;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i23;
import 'features/settings/domain/repositories/settings_repository.dart' as _i22;
import 'features/settings/domain/usecases/get_locale.dart' as _i36;
import 'features/settings/domain/usecases/get_theme.dart' as _i45;
import 'features/settings/domain/usecases/set_locale.dart' as _i51;
import 'features/settings/domain/usecases/set_theme.dart' as _i52;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i63;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i58;
import 'features/single_category/data/repositories/single_category_repository_impl.dart'
    as _i25;
import 'features/single_category/domain/repositories/single_category_repository.dart'
    as _i24;
import 'features/single_category/domain/usecases/get_category.dart' as _i35;
import 'features/single_category/domain/usecases/get_posts.dart' as _i39;
import 'features/single_category/presentation/notifier/category_posts_notifier.dart'
    as _i60;
import 'features/single_category/presentation/notifier/single_category_notifier.dart'
    as _i53;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i27;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i26;
import 'features/single_post/domain/usecases/check_post_save_status.dart'
    as _i32;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i33;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i34;
import 'features/single_post/domain/usecases/get_post.dart' as _i37;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i42;
import 'features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i7;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i47;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i48;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i54;
import 'features/single_tag/data/repositories/single_tag_repository_impl.dart'
    as _i29;
import 'features/single_tag/domain/repositories/single_tag_repository.dart'
    as _i28;
import 'features/single_tag/domain/usecases/get_posts.dart' as _i40;
import 'features/single_tag/domain/usecases/get_tag.dart' as _i44;
import 'features/single_tag/presentation/notifier/single_tag_notifier.dart'
    as _i55;
import 'features/single_tag/presentation/notifier/tag_posts_notifier.dart'
    as _i57;
import 'features/single_user/data/repositories/single_user_repository_impl.dart'
    as _i31;
import 'features/single_user/domain/repositories/single_user_repository.dart'
    as _i30;
import 'features/single_user/domain/usecases/get_posts.dart' as _i41;
import 'features/single_user/domain/usecases/get_user.dart' as _i46;
import 'features/single_user/presentation/notifier/single_user_notifier.dart'
    as _i56;
import 'features/single_user/presentation/notifier/user_posts_notifier.dart'
    as _i59;
import 'features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i8;
import 'injection.dart' as _i65; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.singletonAsync<_i3.Box<dynamic>>(() => registerModule.settingsBox,
      instanceName: 'settingsBox', preResolve: true);
  await gh.singletonAsync<_i3.Box<Map<dynamic, dynamic>>>(
      () => registerModule.gqlCacheBox,
      instanceName: 'gqlCacheBox',
      preResolve: true);
  gh.singleton<_i4.GlobalKey<_i5.SavedPostsPageState>>(
      registerModule.savedPostsPageKey,
      instanceName: 'savedPostsPageKey');
  gh.singleton<_i4.GlobalKey<_i4.NavigatorState>>(
      registerModule.navBarNavigatorKey,
      instanceName: 'navBarNavigatorKey');
  gh.singleton<_i4.GlobalKey<_i4.NavigatorState>>(
      registerModule.rootNavigatorKey,
      instanceName: 'rootNavigatorKey');
  gh.lazySingleton<_i6.GraphQLClient>(() => registerModule.gqlClient(
      get<_i3.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
  gh.factory<_i7.LightboxNotifier>(() => _i7.LightboxNotifier());
  gh.factory<_i8.LoadingProgressNotifier>(() => _i8.LoadingProgressNotifier());
  gh.lazySingleton<_i9.LocaleLocalDataSource>(() =>
      _i9.LocaleLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.singleton<_i10.QueryExecutor>(registerModule.queryExecutor);
  gh.singleton<_i4.RootBackButtonDispatcher>(
      registerModule.rootBackButtonDispatcher);
  gh.singleton<_i4.RouteInformationParser<Uri>>(
      registerModule.routeInformationParser);
  gh.singleton<_i4.RouterDelegate<Uri>>(registerModule.rootRouterDelegate,
      instanceName: 'rootRouterDelegate');
  gh.factory<_i11.SearchBarFilledStatusNotifier>(
      () => _i11.SearchBarFilledStatusNotifier());
  gh.factory<_i11.SearchTermNotifier>(() => _i11.SearchTermNotifier());
  gh.lazySingleton<_i12.ThemeLocalDataSource>(() =>
      _i12.ThemeLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i13.WpRemoteDataSource>(
      () => _i13.WpRemoteDataSourceImpl(get<_i6.GraphQLClient>()));
  gh.lazySingleton<_i14.AppDatabase>(
      () => _i14.AppDatabase(get<_i10.QueryExecutor>()));
  gh.lazySingleton<_i15.HomeRepository>(
      () => _i16.HomeRepositoryImpl(get<_i13.WpRemoteDataSource>()));
  gh.lazySingleton<_i17.SavedPostsLocalDataSource>(
      () => _i17.SavedPostsLocalDataSource(get<_i14.AppDatabase>()));
  gh.lazySingleton<_i18.SavedPostsRepository>(() =>
      _i19.SavedPostsRepositoryImpl(get<_i17.SavedPostsLocalDataSource>()));
  gh.lazySingleton<_i20.SearchRepository>(
      () => _i21.SearchRepositoryImpl(get<_i13.WpRemoteDataSource>()));
  gh.lazySingleton<_i22.SettingsRepository>(() => _i23.SettingsRepositoryImpl(
      get<_i12.ThemeLocalDataSource>(), get<_i9.LocaleLocalDataSource>()));
  gh.lazySingleton<_i24.SingleCategoryRepository>(
      () => _i25.SingleCategoryRepositoryImpl(get<_i13.WpRemoteDataSource>()));
  gh.lazySingleton<_i26.SinglePostRepository>(() =>
      _i27.SinglePostRepositoryImpl(get<_i17.SavedPostsLocalDataSource>(),
          get<_i13.WpRemoteDataSource>()));
  gh.lazySingleton<_i28.SingleTagRepository>(
      () => _i29.SingleTagRepositoryImpl(get<_i13.WpRemoteDataSource>()));
  gh.lazySingleton<_i30.SingleUserRepository>(
      () => _i31.SingleUserRepositoryImpl(get<_i13.WpRemoteDataSource>()));
  gh.lazySingleton<_i32.CheckPostSaveStatus>(
      () => _i32.CheckPostSaveStatus(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i33.CreateSavedPost>(
      () => _i33.CreateSavedPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i34.DeleteSavedPost>(
      () => _i34.DeleteSavedPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i35.GetCategory>(
      () => _i35.GetCategory(get<_i24.SingleCategoryRepository>()));
  gh.lazySingleton<_i36.GetLocale>(
      () => _i36.GetLocale(get<_i22.SettingsRepository>()));
  gh.lazySingleton<_i37.GetPost>(
      () => _i37.GetPost(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i38.GetPosts>(
      () => _i38.GetPosts(get<_i15.HomeRepository>()));
  gh.lazySingleton<_i39.GetPosts>(
      () => _i39.GetPosts(get<_i24.SingleCategoryRepository>()));
  gh.lazySingleton<_i40.GetPosts>(
      () => _i40.GetPosts(get<_i28.SingleTagRepository>()));
  gh.lazySingleton<_i41.GetPosts>(
      () => _i41.GetPosts(get<_i30.SingleUserRepository>()));
  gh.lazySingleton<_i42.GetRelatedPosts>(
      () => _i42.GetRelatedPosts(get<_i26.SinglePostRepository>()));
  gh.lazySingleton<_i43.GetSavedPosts>(
      () => _i43.GetSavedPosts(get<_i18.SavedPostsRepository>()));
  gh.lazySingleton<_i44.GetTag>(
      () => _i44.GetTag(get<_i28.SingleTagRepository>()));
  gh.lazySingleton<_i45.GetTheme>(
      () => _i45.GetTheme(get<_i22.SettingsRepository>()));
  gh.lazySingleton<_i46.GetUser>(
      () => _i46.GetUser(get<_i30.SingleUserRepository>()));
  gh.factory<_i47.RelatedPostsNotifier>(
      () => _i47.RelatedPostsNotifier(get<_i42.GetRelatedPosts>()));
  gh.factory<_i48.SavedPostNotifier>(() => _i48.SavedPostNotifier(
      get<_i33.CreateSavedPost>(),
      get<_i34.DeleteSavedPost>(),
      get<_i32.CheckPostSaveStatus>(),
      get<_i4.GlobalKey<_i5.SavedPostsPageState>>(
          instanceName: 'savedPostsPageKey')));
  gh.factory<_i49.SavedPostsNotifier>(
      () => _i49.SavedPostsNotifier(get<_i43.GetSavedPosts>()));
  gh.lazySingleton<_i50.SearchPosts>(
      () => _i50.SearchPosts(get<_i20.SearchRepository>()));
  gh.lazySingleton<_i51.SetLocale>(
      () => _i51.SetLocale(get<_i22.SettingsRepository>()));
  gh.lazySingleton<_i52.SetTheme>(
      () => _i52.SetTheme(get<_i22.SettingsRepository>()));
  gh.factory<_i53.SingleCategoryNotifier>(
      () => _i53.SingleCategoryNotifier(get<_i35.GetCategory>()));
  gh.factory<_i54.SinglePostNotifier>(
      () => _i54.SinglePostNotifier(get<_i37.GetPost>()));
  gh.factory<_i55.SingleTagNotifier>(
      () => _i55.SingleTagNotifier(get<_i44.GetTag>()));
  gh.factory<_i56.SingleUserNotifier>(
      () => _i56.SingleUserNotifier(get<_i46.GetUser>()));
  gh.factory<_i57.TagPostsNotifier>(
      () => _i57.TagPostsNotifier(get<_i40.GetPosts>()));
  gh.factory<_i58.ThemeNotifier>(
      () => _i58.ThemeNotifier(get<_i45.GetTheme>(), get<_i52.SetTheme>()));
  gh.factory<_i59.UserPostsNotifier>(
      () => _i59.UserPostsNotifier(get<_i41.GetPosts>()));
  gh.factory<_i60.CategoryPostsNotifier>(
      () => _i60.CategoryPostsNotifier(get<_i39.GetPosts>()));
  gh.factory<_i61.ContentGroupNotifier>(
      () => _i61.ContentGroupNotifier(get<_i38.GetPosts>()));
  gh.factory<_i62.FeaturedContentNotifier>(
      () => _i62.FeaturedContentNotifier(get<_i38.GetPosts>()));
  gh.factory<_i63.LocaleNotifier>(
      () => _i63.LocaleNotifier(get<_i36.GetLocale>(), get<_i51.SetLocale>()));
  gh.factoryParam<_i11.SearchNotifier, _i64.Reader, dynamic>(
      (_read, _) => _i11.SearchNotifier(get<_i50.SearchPosts>(), _read));
  return get;
}

class _$RegisterModule extends _i65.RegisterModule {}
