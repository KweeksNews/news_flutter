// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i14;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i65;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i10;
import 'package:hive/hive.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import 'core/databases/databases.dart' as _i18;
import 'core/datasources/saved_posts_local_data_source.dart' as _i21;
import 'core/datasources/wp_remote_data_source.dart' as _i17;
import 'core/router/app_router.dart' as _i3;
import 'features/home/data/repositories/home_repository_impl.dart' as _i20;
import 'features/home/domain/repositories/home_repository.dart' as _i19;
import 'features/home/domain/usecases/get_posts.dart' as _i42;
import 'features/home/presentation/notifier/content_group_notifier.dart' as _i5;
import 'features/home/presentation/notifier/featured_content_notifier.dart'
    as _i66;
import 'features/home/presentation/widgets/content_group.dart' as _i7;
import 'features/home/presentation/widgets/featured_content.dart' as _i9;
import 'features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i23;
import 'features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i22;
import 'features/saved_posts/domain/usecases/get_saved_posts.dart' as _i47;
import 'features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i53;
import 'features/saved_posts/presentation/pages/saved_posts.dart' as _i8;
import 'features/search/data/repositories/search_repository_impl.dart' as _i25;
import 'features/search/domain/repositories/search_repository.dart' as _i24;
import 'features/search/domain/usecases/search_posts.dart' as _i54;
import 'features/search/presentation/notifier/search_notifier.dart' as _i15;
import 'features/settings/data/datasources/locale_local_data_source.dart'
    as _i13;
import 'features/settings/data/datasources/theme_local_data_source.dart'
    as _i16;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i27;
import 'features/settings/domain/repositories/settings_repository.dart' as _i26;
import 'features/settings/domain/usecases/get_locale.dart' as _i40;
import 'features/settings/domain/usecases/get_theme.dart' as _i49;
import 'features/settings/domain/usecases/set_locale.dart' as _i55;
import 'features/settings/domain/usecases/set_theme.dart' as _i56;
import 'features/settings/presentation/notifier/locale_notifier.dart' as _i67;
import 'features/settings/presentation/notifier/theme_notifier.dart' as _i62;
import 'features/single_category/data/repositories/single_category_repository_impl.dart'
    as _i29;
import 'features/single_category/domain/repositories/single_category_repository.dart'
    as _i28;
import 'features/single_category/domain/usecases/get_category.dart' as _i39;
import 'features/single_category/domain/usecases/get_posts.dart' as _i43;
import 'features/single_category/presentation/notifier/category_posts_notifier.dart'
    as _i64;
import 'features/single_category/presentation/notifier/single_category_notifier.dart'
    as _i57;
import 'features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i31;
import 'features/single_post/domain/repositories/single_post_repository.dart'
    as _i30;
import 'features/single_post/domain/usecases/check_post_save_status.dart'
    as _i36;
import 'features/single_post/domain/usecases/create_saved_post.dart' as _i37;
import 'features/single_post/domain/usecases/delete_saved_post.dart' as _i38;
import 'features/single_post/domain/usecases/get_post.dart' as _i41;
import 'features/single_post/domain/usecases/get_related_posts.dart' as _i46;
import 'features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i11;
import 'features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i51;
import 'features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i52;
import 'features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i58;
import 'features/single_tag/data/repositories/single_tag_repository_impl.dart'
    as _i33;
import 'features/single_tag/domain/repositories/single_tag_repository.dart'
    as _i32;
import 'features/single_tag/domain/usecases/get_posts.dart' as _i44;
import 'features/single_tag/domain/usecases/get_tag.dart' as _i48;
import 'features/single_tag/presentation/notifier/single_tag_notifier.dart'
    as _i59;
import 'features/single_tag/presentation/notifier/tag_posts_notifier.dart'
    as _i61;
import 'features/single_user/data/repositories/single_user_repository_impl.dart'
    as _i35;
import 'features/single_user/domain/repositories/single_user_repository.dart'
    as _i34;
import 'features/single_user/domain/usecases/get_posts.dart' as _i45;
import 'features/single_user/domain/usecases/get_user.dart' as _i50;
import 'features/single_user/presentation/notifier/single_user_notifier.dart'
    as _i60;
import 'features/single_user/presentation/notifier/user_posts_notifier.dart'
    as _i63;
import 'features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i12;
import 'injection.dart' as _i68; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AppRouter>(_i3.AppRouter());
  await gh.singletonAsync<_i4.Box<dynamic>>(
    () => registerModule.settingsBox,
    instanceName: 'settingsBox',
    preResolve: true,
  );
  await gh.singletonAsync<_i4.Box<Map<dynamic, dynamic>>>(
    () => registerModule.gqlCacheBox,
    instanceName: 'gqlCacheBox',
    preResolve: true,
  );
  gh.factoryParam<_i5.ContentGroupDropdownNotifier, List<String>, dynamic>((
    intialIds,
    _,
  ) =>
      _i5.ContentGroupDropdownNotifier(intialIds));
  gh.lazySingleton<_i6.GlobalKey<_i6.NavigatorState>>(
    () => registerModule.shellNavigatorKey,
    instanceName: 'shellNavigatorKey',
  );
  gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
    () => registerModule.contentGroupWidgetKey4,
    instanceName: 'contentGroupWidgetKey4',
  );
  gh.lazySingleton<_i6.GlobalKey<_i8.SavedPostsPageState>>(
    () => registerModule.savedPostsPageKey,
    instanceName: 'savedPostsPageKey',
  );
  gh.lazySingleton<_i6.GlobalKey<_i9.FeaturedContentState>>(
    () => registerModule.featuredContentWidgetKey,
    instanceName: 'featuredContentWidgetKey',
  );
  gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
    () => registerModule.contentGroupWidgetKey1,
    instanceName: 'contentGroupWidgetKey1',
  );
  gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
    () => registerModule.contentGroupWidgetKey2,
    instanceName: 'contentGroupWidgetKey2',
  );
  gh.lazySingleton<_i6.GlobalKey<_i6.NavigatorState>>(
    () => registerModule.rootNavigatorKey,
    instanceName: 'rootNavigatorKey',
  );
  gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
    () => registerModule.contentGroupWidgetKey3,
    instanceName: 'contentGroupWidgetKey3',
  );
  gh.lazySingleton<_i10.GraphQLClient>(() => registerModule.gqlClient(
      get<_i4.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
  gh.factory<_i11.LightboxNotifier>(() => _i11.LightboxNotifier());
  gh.factory<_i12.LoadingProgressNotifier>(
      () => _i12.LoadingProgressNotifier());
  gh.lazySingleton<_i13.LocaleLocalDataSource>(() =>
      _i13.LocaleLocalDataSourceImpl(
          get<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i14.QueryExecutor>(() => registerModule.queryExecutor);
  gh.factory<_i15.SearchBarFilledStatusNotifier>(
      () => _i15.SearchBarFilledStatusNotifier());
  gh.factory<_i15.SearchTermNotifier>(() => _i15.SearchTermNotifier());
  gh.lazySingleton<_i16.ThemeLocalDataSource>(() =>
      _i16.ThemeLocalDataSourceImpl(
          get<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
  gh.lazySingleton<_i17.WpRemoteDataSource>(
      () => _i17.WpRemoteDataSourceImpl(get<_i10.GraphQLClient>()));
  gh.lazySingleton<_i18.AppDatabase>(
      () => _i18.AppDatabase(get<_i14.QueryExecutor>()));
  gh.lazySingleton<_i19.HomeRepository>(
      () => _i20.HomeRepositoryImpl(get<_i17.WpRemoteDataSource>()));
  gh.lazySingleton<_i21.SavedPostsLocalDataSource>(
      () => _i21.SavedPostsLocalDataSource(get<_i18.AppDatabase>()));
  gh.lazySingleton<_i22.SavedPostsRepository>(() =>
      _i23.SavedPostsRepositoryImpl(get<_i21.SavedPostsLocalDataSource>()));
  gh.lazySingleton<_i24.SearchRepository>(
      () => _i25.SearchRepositoryImpl(get<_i17.WpRemoteDataSource>()));
  gh.lazySingleton<_i26.SettingsRepository>(() => _i27.SettingsRepositoryImpl(
        get<_i16.ThemeLocalDataSource>(),
        get<_i13.LocaleLocalDataSource>(),
      ));
  gh.lazySingleton<_i28.SingleCategoryRepository>(
      () => _i29.SingleCategoryRepositoryImpl(get<_i17.WpRemoteDataSource>()));
  gh.lazySingleton<_i30.SinglePostRepository>(
      () => _i31.SinglePostRepositoryImpl(
            get<_i21.SavedPostsLocalDataSource>(),
            get<_i17.WpRemoteDataSource>(),
          ));
  gh.lazySingleton<_i32.SingleTagRepository>(
      () => _i33.SingleTagRepositoryImpl(get<_i17.WpRemoteDataSource>()));
  gh.lazySingleton<_i34.SingleUserRepository>(
      () => _i35.SingleUserRepositoryImpl(get<_i17.WpRemoteDataSource>()));
  gh.lazySingleton<_i36.CheckPostSaveStatus>(
      () => _i36.CheckPostSaveStatus(get<_i30.SinglePostRepository>()));
  gh.lazySingleton<_i37.CreateSavedPost>(
      () => _i37.CreateSavedPost(get<_i30.SinglePostRepository>()));
  gh.lazySingleton<_i38.DeleteSavedPost>(
      () => _i38.DeleteSavedPost(get<_i30.SinglePostRepository>()));
  gh.lazySingleton<_i39.GetCategory>(
      () => _i39.GetCategory(get<_i28.SingleCategoryRepository>()));
  gh.lazySingleton<_i40.GetLocale>(
      () => _i40.GetLocale(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i41.GetPost>(
      () => _i41.GetPost(get<_i30.SinglePostRepository>()));
  gh.lazySingleton<_i42.GetPosts>(
      () => _i42.GetPosts(get<_i19.HomeRepository>()));
  gh.lazySingleton<_i43.GetPosts>(
      () => _i43.GetPosts(get<_i28.SingleCategoryRepository>()));
  gh.lazySingleton<_i44.GetPosts>(
      () => _i44.GetPosts(get<_i32.SingleTagRepository>()));
  gh.lazySingleton<_i45.GetPosts>(
      () => _i45.GetPosts(get<_i34.SingleUserRepository>()));
  gh.lazySingleton<_i46.GetRelatedPosts>(
      () => _i46.GetRelatedPosts(get<_i30.SinglePostRepository>()));
  gh.lazySingleton<_i47.GetSavedPosts>(
      () => _i47.GetSavedPosts(get<_i22.SavedPostsRepository>()));
  gh.lazySingleton<_i48.GetTag>(
      () => _i48.GetTag(get<_i32.SingleTagRepository>()));
  gh.lazySingleton<_i49.GetTheme>(
      () => _i49.GetTheme(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i50.GetUser>(
      () => _i50.GetUser(get<_i34.SingleUserRepository>()));
  gh.factory<_i51.RelatedPostsNotifier>(
      () => _i51.RelatedPostsNotifier(get<_i46.GetRelatedPosts>()));
  gh.factory<_i52.SavedPostNotifier>(() => _i52.SavedPostNotifier(
        get<_i37.CreateSavedPost>(),
        get<_i38.DeleteSavedPost>(),
        get<_i36.CheckPostSaveStatus>(),
        get<_i6.GlobalKey<_i8.SavedPostsPageState>>(
            instanceName: 'savedPostsPageKey'),
      ));
  gh.factory<_i53.SavedPostsNotifier>(
      () => _i53.SavedPostsNotifier(get<_i47.GetSavedPosts>()));
  gh.lazySingleton<_i54.SearchPosts>(
      () => _i54.SearchPosts(get<_i24.SearchRepository>()));
  gh.lazySingleton<_i55.SetLocale>(
      () => _i55.SetLocale(get<_i26.SettingsRepository>()));
  gh.lazySingleton<_i56.SetTheme>(
      () => _i56.SetTheme(get<_i26.SettingsRepository>()));
  gh.factory<_i57.SingleCategoryNotifier>(
      () => _i57.SingleCategoryNotifier(get<_i39.GetCategory>()));
  gh.factory<_i58.SinglePostNotifier>(
      () => _i58.SinglePostNotifier(get<_i41.GetPost>()));
  gh.factory<_i59.SingleTagNotifier>(
      () => _i59.SingleTagNotifier(get<_i48.GetTag>()));
  gh.factory<_i60.SingleUserNotifier>(
      () => _i60.SingleUserNotifier(get<_i50.GetUser>()));
  gh.factory<_i61.TagPostsNotifier>(
      () => _i61.TagPostsNotifier(get<_i44.GetPosts>()));
  gh.factory<_i62.ThemeNotifier>(() => _i62.ThemeNotifier(
        get<_i49.GetTheme>(),
        get<_i56.SetTheme>(),
      ));
  gh.factory<_i63.UserPostsNotifier>(
      () => _i63.UserPostsNotifier(get<_i45.GetPosts>()));
  gh.factory<_i64.CategoryPostsNotifier>(
      () => _i64.CategoryPostsNotifier(get<_i43.GetPosts>()));
  gh.factoryParam<_i5.ContentGroupNotifier, List<String>, _i65.Ref<Object?>>((
    _initialIds,
    _ref,
  ) =>
      _i5.ContentGroupNotifier(
        get<_i42.GetPosts>(),
        _initialIds,
        _ref,
      ));
  gh.factory<_i66.FeaturedContentNotifier>(
      () => _i66.FeaturedContentNotifier(get<_i42.GetPosts>()));
  gh.factory<_i67.LocaleNotifier>(() => _i67.LocaleNotifier(
        get<_i40.GetLocale>(),
        get<_i55.SetLocale>(),
      ));
  gh.factoryParam<_i15.SearchNotifier, _i65.Ref<Object?>, dynamic>((
    _ref,
    _,
  ) =>
      _i15.SearchNotifier(
        get<_i54.SearchPosts>(),
        _ref,
      ));
  return get;
}

class _$RegisterModule extends _i68.RegisterModule {}
