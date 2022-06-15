// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:drift/drift.dart' as _i12;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i66;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i8;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'core/databases/databases.dart' as _i16;
import 'core/datasources/saved_posts_local_data_source.dart' as _i19;
import 'core/datasources/wp_remote_data_source.dart' as _i15;
import 'features/home/data/repositories/home_repository_impl.dart' as _i18;
import 'features/home/domain/repositories/home_repository.dart' as _i17;
import 'features/home/domain/usecases/get_posts.dart' as _i40;
import 'features/home/presentation/notifier/content_group_notifier.dart'
    as _i63;
import 'features/home/presentation/notifier/featured_content_notifier.dart'
    as _i64;
import 'features/home/presentation/widgets/content_group.dart' as _i5;
import 'features/home/presentation/widgets/featured_content.dart' as _i7;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i21;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i20;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i45;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i51;
import 'features/saved_posts/presentation/pages/saved_posts.dart' as _i6;
import 'features/search/data/repositories/search_repository_impl.dart' as _i23;
import 'features/search/domain/repositories/search_repository.dart' as _i22;
import 'features/search/domain/usecases/search_posts.dart' as _i52;
import 'features/search/presentation/notifier/search_notifier.dart' as _i13;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i11;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i14;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i25;
import 'features/settings/domain/repositories/settings_repository.dart' as _i24;
import 'features/settings/domain/usecases/get_locale.dart' as _i38;
import 'features/settings/domain/usecases/get_theme.dart' as _i47;
import 'features/settings/domain/usecases/set_locale.dart' as _i53;
import 'features/settings/domain/usecases/set_theme.dart' as _i54;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i65;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i60;
import 'features/single_category/data/repositories/single_category_repository_impl.dart'
    as _i27;
import 'features/single_category/domain/repositories/single_category_repository.dart'
    as _i26;
import 'features/single_category/domain/usecases/get_category.dart' as _i37;
import 'features/single_category/domain/usecases/get_posts.dart' as _i42;
import 'features/single_category/presentation/notifier/category_posts_notifier.dart'
    as _i62;
import 'features/single_category/presentation/notifier/single_category_notifier.dart'
    as _i55;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i29;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i28;
import 'features/single_post/domain/usecases/check_post_save_status.dart'
    as _i34;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i35;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i36;
import 'features/single_post/domain/usecases/get_post.dart' as _i39;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i44;
import 'features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i9;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i49;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i50;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i56;
import 'features/single_tag/data/repositories/single_tag_repository_impl.dart'
    as _i31;
import 'features/single_tag/domain/repositories/single_tag_repository.dart'
    as _i30;
import 'features/single_tag/domain/usecases/get_posts.dart' as _i43;
import 'features/single_tag/domain/usecases/get_tag.dart' as _i46;
import 'features/single_tag/presentation/notifier/single_tag_notifier.dart'
    as _i57;
import 'features/single_tag/presentation/notifier/tag_posts_notifier.dart'
    as _i59;
import 'features/single_user/data/repositories/single_user_repository_impl.dart'
    as _i33;
import 'features/single_user/domain/repositories/single_user_repository.dart'
    as _i32;
import 'features/single_user/domain/usecases/get_posts.dart' as _i41;
import 'features/single_user/domain/usecases/get_user.dart' as _i48;
import 'features/single_user/presentation/notifier/single_user_notifier.dart'
    as _i58;
import 'features/single_user/presentation/notifier/user_posts_notifier.dart'
    as _i61;
import 'features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i10;
import 'injection.dart' as _i67; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i4.GlobalKey<_i5.ContentGroupState>>(
      registerModule.contentGroupWidgetKey1,
      instanceName: 'contentGroupWidgetKey1');
  gh.singleton<_i4.GlobalKey<_i4.NavigatorState>>(
      registerModule.navBarNavigatorKey,
      instanceName: 'navBarNavigatorKey');
  gh.singleton<_i4.GlobalKey<_i4.NavigatorState>>(
      registerModule.rootNavigatorKey,
      instanceName: 'rootNavigatorKey');
  gh.singleton<_i4.GlobalKey<_i5.ContentGroupState>>(
      registerModule.contentGroupWidgetKey3,
      instanceName: 'contentGroupWidgetKey3');
  gh.singleton<_i4.GlobalKey<_i5.ContentGroupState>>(
      registerModule.contentGroupWidgetKey4,
      instanceName: 'contentGroupWidgetKey4');
  gh.singleton<_i4.GlobalKey<_i5.ContentGroupState>>(
      registerModule.contentGroupWidgetKey2,
      instanceName: 'contentGroupWidgetKey2');
  gh.singleton<_i4.GlobalKey<_i6.SavedPostsPageState>>(
      registerModule.savedPostsPageKey,
      instanceName: 'savedPostsPageKey');
  gh.singleton<_i4.GlobalKey<_i7.FeaturedContentState>>(
      registerModule.featuredContentWidgetKey,
      instanceName: 'featuredContentWidgetKey');
  gh.lazySingleton<_i8.GraphQLClient>(() => registerModule.gqlClient(
      get<_i3.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
  gh.factory<_i9.LightboxNotifier>(() => _i9.LightboxNotifier());
  gh.factory<_i10.LoadingProgressNotifier>(
      () => _i10.LoadingProgressNotifier());
  gh.lazySingleton<_i11.LocaleLocalDataSource>(() =>
      _i11.LocaleLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.singleton<_i12.QueryExecutor>(registerModule.queryExecutor);
  gh.singleton<_i4.RootBackButtonDispatcher>(
      registerModule.rootBackButtonDispatcher);
  gh.singleton<_i4.RouteInformationParser<Uri>>(
      registerModule.routeInformationParser);
  gh.singleton<_i4.RouterDelegate<Uri>>(registerModule.rootRouterDelegate,
      instanceName: 'rootRouterDelegate');
  gh.factory<_i13.SearchBarFilledStatusNotifier>(
      () => _i13.SearchBarFilledStatusNotifier());
  gh.factory<_i13.SearchTermNotifier>(() => _i13.SearchTermNotifier());
  gh.lazySingleton<_i14.ThemeLocalDataSource>(() =>
      _i14.ThemeLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i15.WpRemoteDataSource>(
      () => _i15.WpRemoteDataSourceImpl(get<_i8.GraphQLClient>()));
  gh.lazySingleton<_i16.AppDatabase>(
      () => _i16.AppDatabase(get<_i12.QueryExecutor>()));
  gh.lazySingleton<_i17.HomeRepository>(
      () => _i18.HomeRepositoryImpl(get<_i15.WpRemoteDataSource>()));
  gh.lazySingleton<_i19.SavedPostsLocalDataSource>(
      () => _i19.SavedPostsLocalDataSource(get<_i16.AppDatabase>()));
  gh.lazySingleton<_i20.SavedPostsRepository>(() =>
      _i21.SavedPostsRepositoryImpl(get<_i19.SavedPostsLocalDataSource>()));
  gh.lazySingleton<_i22.SearchRepository>(
      () => _i23.SearchRepositoryImpl(get<_i15.WpRemoteDataSource>()));
  gh.lazySingleton<_i24.SettingsRepository>(() => _i25.SettingsRepositoryImpl(
      get<_i14.ThemeLocalDataSource>(), get<_i11.LocaleLocalDataSource>()));
  gh.lazySingleton<_i26.SingleCategoryRepository>(
      () => _i27.SingleCategoryRepositoryImpl(get<_i15.WpRemoteDataSource>()));
  gh.lazySingleton<_i28.SinglePostRepository>(() =>
      _i29.SinglePostRepositoryImpl(get<_i19.SavedPostsLocalDataSource>(),
          get<_i15.WpRemoteDataSource>()));
  gh.lazySingleton<_i30.SingleTagRepository>(
      () => _i31.SingleTagRepositoryImpl(get<_i15.WpRemoteDataSource>()));
  gh.lazySingleton<_i32.SingleUserRepository>(
      () => _i33.SingleUserRepositoryImpl(get<_i15.WpRemoteDataSource>()));
  gh.lazySingleton<_i34.CheckPostSaveStatus>(
      () => _i34.CheckPostSaveStatus(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i35.CreateSavedPost>(
      () => _i35.CreateSavedPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i36.DeleteSavedPost>(
      () => _i36.DeleteSavedPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i37.GetCategory>(
      () => _i37.GetCategory(get<_i26.SingleCategoryRepository>()));
  gh.lazySingleton<_i38.GetLocale>(
      () => _i38.GetLocale(get<_i24.SettingsRepository>()));
  gh.lazySingleton<_i39.GetPost>(
      () => _i39.GetPost(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i40.GetPosts>(
      () => _i40.GetPosts(get<_i17.HomeRepository>()));
  gh.lazySingleton<_i41.GetPosts>(
      () => _i41.GetPosts(get<_i32.SingleUserRepository>()));
  gh.lazySingleton<_i42.GetPosts>(
      () => _i42.GetPosts(get<_i26.SingleCategoryRepository>()));
  gh.lazySingleton<_i43.GetPosts>(
      () => _i43.GetPosts(get<_i30.SingleTagRepository>()));
  gh.lazySingleton<_i44.GetRelatedPosts>(
      () => _i44.GetRelatedPosts(get<_i28.SinglePostRepository>()));
  gh.lazySingleton<_i45.GetSavedPosts>(
      () => _i45.GetSavedPosts(get<_i20.SavedPostsRepository>()));
  gh.lazySingleton<_i46.GetTag>(
      () => _i46.GetTag(get<_i30.SingleTagRepository>()));
  gh.lazySingleton<_i47.GetTheme>(
      () => _i47.GetTheme(get<_i24.SettingsRepository>()));
  gh.lazySingleton<_i48.GetUser>(
      () => _i48.GetUser(get<_i32.SingleUserRepository>()));
  gh.factory<_i49.RelatedPostsNotifier>(
      () => _i49.RelatedPostsNotifier(get<_i44.GetRelatedPosts>()));
  gh.factory<_i50.SavedPostNotifier>(() => _i50.SavedPostNotifier(
      get<_i35.CreateSavedPost>(),
      get<_i36.DeleteSavedPost>(),
      get<_i34.CheckPostSaveStatus>(),
      get<_i4.GlobalKey<_i6.SavedPostsPageState>>(
          instanceName: 'savedPostsPageKey')));
  gh.factory<_i51.SavedPostsNotifier>(
      () => _i51.SavedPostsNotifier(get<_i45.GetSavedPosts>()));
  gh.lazySingleton<_i52.SearchPosts>(
      () => _i52.SearchPosts(get<_i22.SearchRepository>()));
  gh.lazySingleton<_i53.SetLocale>(
      () => _i53.SetLocale(get<_i24.SettingsRepository>()));
  gh.lazySingleton<_i54.SetTheme>(
      () => _i54.SetTheme(get<_i24.SettingsRepository>()));
  gh.factory<_i55.SingleCategoryNotifier>(
      () => _i55.SingleCategoryNotifier(get<_i37.GetCategory>()));
  gh.factory<_i56.SinglePostNotifier>(
      () => _i56.SinglePostNotifier(get<_i39.GetPost>()));
  gh.factory<_i57.SingleTagNotifier>(
      () => _i57.SingleTagNotifier(get<_i46.GetTag>()));
  gh.factory<_i58.SingleUserNotifier>(
      () => _i58.SingleUserNotifier(get<_i48.GetUser>()));
  gh.factory<_i59.TagPostsNotifier>(
      () => _i59.TagPostsNotifier(get<_i43.GetPosts>()));
  gh.factory<_i60.ThemeNotifier>(
      () => _i60.ThemeNotifier(get<_i47.GetTheme>(), get<_i54.SetTheme>()));
  gh.factory<_i61.UserPostsNotifier>(
      () => _i61.UserPostsNotifier(get<_i41.GetPosts>()));
  gh.factory<_i62.CategoryPostsNotifier>(
      () => _i62.CategoryPostsNotifier(get<_i42.GetPosts>()));
  gh.factory<_i63.ContentGroupNotifier>(
      () => _i63.ContentGroupNotifier(get<_i40.GetPosts>()));
  gh.factory<_i64.FeaturedContentNotifier>(
      () => _i64.FeaturedContentNotifier(get<_i40.GetPosts>()));
  gh.factory<_i65.LocaleNotifier>(
      () => _i65.LocaleNotifier(get<_i38.GetLocale>(), get<_i53.SetLocale>()));
  gh.factoryParam<_i13.SearchNotifier, _i66.Reader, dynamic>(
      (_read, _) => _i13.SearchNotifier(get<_i52.SearchPosts>(), _read));
  return get;
}

class _$RegisterModule extends _i67.RegisterModule {}
