// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:drift/drift.dart' as _i13;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i64;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i9;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'core/databases/databases.dart' as _i17;
import 'core/datasources/saved_posts_local_data_source.dart' as _i20;
import 'core/datasources/wp_remote_data_source.dart' as _i16;
import 'features/home/data/repositories/home_repository_impl.dart' as _i19;
import 'features/home/domain/repositories/home_repository.dart' as _i18;
import 'features/home/domain/usecases/get_posts.dart' as _i42;
import 'features/home/presentation/notifier/content_group_notifier.dart' as _i4;
import 'features/home/presentation/notifier/featured_content_notifier.dart'
    as _i65;
import 'features/home/presentation/widgets/content_group.dart' as _i6;
import 'features/home/presentation/widgets/featured_content.dart' as _i8;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i22;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i21;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i46;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i52;
import 'features/saved_posts/presentation/pages/saved_posts.dart' as _i7;
import 'features/search/data/repositories/search_repository_impl.dart' as _i24;
import 'features/search/domain/repositories/search_repository.dart' as _i23;
import 'features/search/domain/usecases/search_posts.dart' as _i53;
import 'features/search/presentation/notifier/search_notifier.dart' as _i14;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i12;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i15;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i26;
import 'features/settings/domain/repositories/settings_repository.dart' as _i25;
import 'features/settings/domain/usecases/get_locale.dart' as _i39;
import 'features/settings/domain/usecases/get_theme.dart' as _i48;
import 'features/settings/domain/usecases/set_locale.dart' as _i54;
import 'features/settings/domain/usecases/set_theme.dart' as _i55;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i66;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i61;
import 'features/single_category/data/repositories/single_category_repository_impl.dart'
    as _i28;
import 'features/single_category/domain/repositories/single_category_repository.dart'
    as _i27;
import 'features/single_category/domain/usecases/get_category.dart' as _i38;
import 'features/single_category/domain/usecases/get_posts.dart' as _i44;
import 'features/single_category/presentation/notifier/category_posts_notifier.dart'
    as _i63;
import 'features/single_category/presentation/notifier/single_category_notifier.dart'
    as _i56;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i30;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i29;
import 'features/single_post/domain/usecases/check_post_save_status.dart'
    as _i35;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i36;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i37;
import 'features/single_post/domain/usecases/get_post.dart' as _i40;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i45;
import 'features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i10;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i50;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i51;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i57;
import 'features/single_tag/data/repositories/single_tag_repository_impl.dart'
    as _i32;
import 'features/single_tag/domain/repositories/single_tag_repository.dart'
    as _i31;
import 'features/single_tag/domain/usecases/get_posts.dart' as _i43;
import 'features/single_tag/domain/usecases/get_tag.dart' as _i47;
import 'features/single_tag/presentation/notifier/single_tag_notifier.dart'
    as _i58;
import 'features/single_tag/presentation/notifier/tag_posts_notifier.dart'
    as _i60;
import 'features/single_user/data/repositories/single_user_repository_impl.dart'
    as _i34;
import 'features/single_user/domain/repositories/single_user_repository.dart'
    as _i33;
import 'features/single_user/domain/usecases/get_posts.dart' as _i41;
import 'features/single_user/domain/usecases/get_user.dart' as _i49;
import 'features/single_user/presentation/notifier/single_user_notifier.dart'
    as _i59;
import 'features/single_user/presentation/notifier/user_posts_notifier.dart'
    as _i62;
import 'features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i11;
import 'injection.dart' as _i67; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.ContentGroupDropdownNotifier>(
      () => _i4.ContentGroupDropdownNotifier());
  gh.singleton<_i5.GlobalKey<_i6.ContentGroupState>>(
      registerModule.contentGroupWidgetKey1,
      instanceName: 'contentGroupWidgetKey1');
  gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      registerModule.navBarNavigatorKey,
      instanceName: 'navBarNavigatorKey');
  gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      registerModule.rootNavigatorKey,
      instanceName: 'rootNavigatorKey');
  gh.singleton<_i5.GlobalKey<_i6.ContentGroupState>>(
      registerModule.contentGroupWidgetKey2,
      instanceName: 'contentGroupWidgetKey2');
  gh.singleton<_i5.GlobalKey<_i6.ContentGroupState>>(
      registerModule.contentGroupWidgetKey3,
      instanceName: 'contentGroupWidgetKey3');
  gh.singleton<_i5.GlobalKey<_i6.ContentGroupState>>(
      registerModule.contentGroupWidgetKey4,
      instanceName: 'contentGroupWidgetKey4');
  gh.singleton<_i5.GlobalKey<_i7.SavedPostsPageState>>(
      registerModule.savedPostsPageKey,
      instanceName: 'savedPostsPageKey');
  gh.singleton<_i5.GlobalKey<_i8.FeaturedContentState>>(
      registerModule.featuredContentWidgetKey,
      instanceName: 'featuredContentWidgetKey');
  gh.lazySingleton<_i9.GraphQLClient>(() => registerModule.gqlClient(
      get<_i3.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
  gh.factory<_i10.LightboxNotifier>(() => _i10.LightboxNotifier());
  gh.factory<_i11.LoadingProgressNotifier>(
      () => _i11.LoadingProgressNotifier());
  gh.lazySingleton<_i12.LocaleLocalDataSource>(() =>
      _i12.LocaleLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.singleton<_i13.QueryExecutor>(registerModule.queryExecutor);
  gh.singleton<_i5.RootBackButtonDispatcher>(
      registerModule.rootBackButtonDispatcher);
  gh.singleton<_i5.RouteInformationParser<Uri>>(
      registerModule.routeInformationParser);
  gh.singleton<_i5.RouterDelegate<Uri>>(registerModule.rootRouterDelegate,
      instanceName: 'rootRouterDelegate');
  gh.factory<_i14.SearchBarFilledStatusNotifier>(
      () => _i14.SearchBarFilledStatusNotifier());
  gh.factory<_i14.SearchTermNotifier>(() => _i14.SearchTermNotifier());
  gh.lazySingleton<_i15.ThemeLocalDataSource>(() =>
      _i15.ThemeLocalDataSourceImpl(
          get<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i16.WpRemoteDataSource>(
      () => _i16.WpRemoteDataSourceImpl(get<_i9.GraphQLClient>()));
  gh.lazySingleton<_i17.AppDatabase>(
      () => _i17.AppDatabase(get<_i13.QueryExecutor>()));
  gh.lazySingleton<_i18.HomeRepository>(
      () => _i19.HomeRepositoryImpl(get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i20.SavedPostsLocalDataSource>(
      () => _i20.SavedPostsLocalDataSource(get<_i17.AppDatabase>()));
  gh.lazySingleton<_i21.SavedPostsRepository>(() =>
      _i22.SavedPostsRepositoryImpl(get<_i20.SavedPostsLocalDataSource>()));
  gh.lazySingleton<_i23.SearchRepository>(
      () => _i24.SearchRepositoryImpl(get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i25.SettingsRepository>(() => _i26.SettingsRepositoryImpl(
      get<_i15.ThemeLocalDataSource>(), get<_i12.LocaleLocalDataSource>()));
  gh.lazySingleton<_i27.SingleCategoryRepository>(
      () => _i28.SingleCategoryRepositoryImpl(get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i29.SinglePostRepository>(() =>
      _i30.SinglePostRepositoryImpl(get<_i20.SavedPostsLocalDataSource>(),
          get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i31.SingleTagRepository>(
      () => _i32.SingleTagRepositoryImpl(get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i33.SingleUserRepository>(
      () => _i34.SingleUserRepositoryImpl(get<_i16.WpRemoteDataSource>()));
  gh.lazySingleton<_i35.CheckPostSaveStatus>(
      () => _i35.CheckPostSaveStatus(get<_i29.SinglePostRepository>()));
  gh.lazySingleton<_i36.CreateSavedPost>(
      () => _i36.CreateSavedPost(get<_i29.SinglePostRepository>()));
  gh.lazySingleton<_i37.DeleteSavedPost>(
      () => _i37.DeleteSavedPost(get<_i29.SinglePostRepository>()));
  gh.lazySingleton<_i38.GetCategory>(
      () => _i38.GetCategory(get<_i27.SingleCategoryRepository>()));
  gh.lazySingleton<_i39.GetLocale>(
      () => _i39.GetLocale(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i40.GetPost>(
      () => _i40.GetPost(get<_i29.SinglePostRepository>()));
  gh.lazySingleton<_i41.GetPosts>(
      () => _i41.GetPosts(get<_i33.SingleUserRepository>()));
  gh.lazySingleton<_i42.GetPosts>(
      () => _i42.GetPosts(get<_i18.HomeRepository>()));
  gh.lazySingleton<_i43.GetPosts>(
      () => _i43.GetPosts(get<_i31.SingleTagRepository>()));
  gh.lazySingleton<_i44.GetPosts>(
      () => _i44.GetPosts(get<_i27.SingleCategoryRepository>()));
  gh.lazySingleton<_i45.GetRelatedPosts>(
      () => _i45.GetRelatedPosts(get<_i29.SinglePostRepository>()));
  gh.lazySingleton<_i46.GetSavedPosts>(
      () => _i46.GetSavedPosts(get<_i21.SavedPostsRepository>()));
  gh.lazySingleton<_i47.GetTag>(
      () => _i47.GetTag(get<_i31.SingleTagRepository>()));
  gh.lazySingleton<_i48.GetTheme>(
      () => _i48.GetTheme(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i49.GetUser>(
      () => _i49.GetUser(get<_i33.SingleUserRepository>()));
  gh.factory<_i50.RelatedPostsNotifier>(
      () => _i50.RelatedPostsNotifier(get<_i45.GetRelatedPosts>()));
  gh.factory<_i51.SavedPostNotifier>(() => _i51.SavedPostNotifier(
      get<_i36.CreateSavedPost>(),
      get<_i37.DeleteSavedPost>(),
      get<_i35.CheckPostSaveStatus>(),
      get<_i5.GlobalKey<_i7.SavedPostsPageState>>(
          instanceName: 'savedPostsPageKey')));
  gh.factory<_i52.SavedPostsNotifier>(
      () => _i52.SavedPostsNotifier(get<_i46.GetSavedPosts>()));
  gh.lazySingleton<_i53.SearchPosts>(
      () => _i53.SearchPosts(get<_i23.SearchRepository>()));
  gh.lazySingleton<_i54.SetLocale>(
      () => _i54.SetLocale(get<_i25.SettingsRepository>()));
  gh.lazySingleton<_i55.SetTheme>(
      () => _i55.SetTheme(get<_i25.SettingsRepository>()));
  gh.factory<_i56.SingleCategoryNotifier>(
      () => _i56.SingleCategoryNotifier(get<_i38.GetCategory>()));
  gh.factory<_i57.SinglePostNotifier>(
      () => _i57.SinglePostNotifier(get<_i40.GetPost>()));
  gh.factory<_i58.SingleTagNotifier>(
      () => _i58.SingleTagNotifier(get<_i47.GetTag>()));
  gh.factory<_i59.SingleUserNotifier>(
      () => _i59.SingleUserNotifier(get<_i49.GetUser>()));
  gh.factory<_i60.TagPostsNotifier>(
      () => _i60.TagPostsNotifier(get<_i43.GetPosts>()));
  gh.factory<_i61.ThemeNotifier>(
      () => _i61.ThemeNotifier(get<_i48.GetTheme>(), get<_i55.SetTheme>()));
  gh.factory<_i62.UserPostsNotifier>(
      () => _i62.UserPostsNotifier(get<_i41.GetPosts>()));
  gh.factory<_i63.CategoryPostsNotifier>(
      () => _i63.CategoryPostsNotifier(get<_i44.GetPosts>()));
  gh.factoryParam<_i4.ContentGroupNotifier, String, _i64.Reader>(
      (_title, _read) =>
          _i4.ContentGroupNotifier(get<_i42.GetPosts>(), _title, _read));
  gh.factory<_i65.FeaturedContentNotifier>(
      () => _i65.FeaturedContentNotifier(get<_i42.GetPosts>()));
  gh.factory<_i66.LocaleNotifier>(
      () => _i66.LocaleNotifier(get<_i39.GetLocale>(), get<_i54.SetLocale>()));
  gh.factoryParam<_i14.SearchNotifier, _i64.Reader, dynamic>(
      (_read, _) => _i14.SearchNotifier(get<_i53.SearchPosts>(), _read));
  return get;
}

class _$RegisterModule extends _i67.RegisterModule {}
