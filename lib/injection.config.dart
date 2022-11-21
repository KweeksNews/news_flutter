// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i4;
import 'package:flutter/material.dart' as _i7;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i46;
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i11;
import 'package:graphql/client.dart' as _i12;
import 'package:hive/hive.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kweeksnews_app/core/databases/databases.dart' as _i3;
import 'package:kweeksnews_app/core/datasources/saved_posts_local_data_source.dart'
    as _i21;
import 'package:kweeksnews_app/core/datasources/wp_remote_data_source.dart'
    as _i18;
import 'package:kweeksnews_app/features/home/data/repositories/home_repository_impl.dart'
    as _i20;
import 'package:kweeksnews_app/features/home/domain/repositories/home_repository.dart'
    as _i19;
import 'package:kweeksnews_app/features/home/domain/usecases/get_posts.dart'
    as _i43;
import 'package:kweeksnews_app/features/home/presentation/notifier/content_group_notifier.dart'
    as _i6;
import 'package:kweeksnews_app/features/home/presentation/notifier/featured_content_notifier.dart'
    as _i66;
import 'package:kweeksnews_app/features/home/presentation/widgets/content_group.dart'
    as _i8;
import 'package:kweeksnews_app/features/home/presentation/widgets/featured_content.dart'
    as _i10;
import 'package:kweeksnews_app/features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i23;
import 'package:kweeksnews_app/features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i22;
import 'package:kweeksnews_app/features/saved_posts/domain/usecases/get_saved_posts.dart'
    as _i48;
import 'package:kweeksnews_app/features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i55;
import 'package:kweeksnews_app/features/saved_posts/presentation/pages/saved_posts.dart'
    as _i9;
import 'package:kweeksnews_app/features/search/data/repositories/search_repository_impl.dart'
    as _i25;
import 'package:kweeksnews_app/features/search/domain/repositories/search_repository.dart'
    as _i24;
import 'package:kweeksnews_app/features/search/domain/usecases/search_posts.dart'
    as _i47;
import 'package:kweeksnews_app/features/search/presentation/notifier/search_notifier.dart'
    as _i16;
import 'package:kweeksnews_app/features/settings/data/datasources/locale_local_data_source.dart'
    as _i15;
import 'package:kweeksnews_app/features/settings/data/datasources/theme_local_data_source.dart'
    as _i17;
import 'package:kweeksnews_app/features/settings/data/repositories/settings_repository_impl.dart'
    as _i27;
import 'package:kweeksnews_app/features/settings/domain/repositories/settings_repository.dart'
    as _i26;
import 'package:kweeksnews_app/features/settings/domain/usecases/get_locale.dart'
    as _i40;
import 'package:kweeksnews_app/features/settings/domain/usecases/get_theme.dart'
    as _i50;
import 'package:kweeksnews_app/features/settings/domain/usecases/set_locale.dart'
    as _i56;
import 'package:kweeksnews_app/features/settings/domain/usecases/set_theme.dart'
    as _i57;
import 'package:kweeksnews_app/features/settings/presentation/notifier/locale_notifier.dart'
    as _i67;
import 'package:kweeksnews_app/features/settings/presentation/notifier/theme_notifier.dart'
    as _i63;
import 'package:kweeksnews_app/features/single_category/data/repositories/single_category_repository_impl.dart'
    as _i29;
import 'package:kweeksnews_app/features/single_category/domain/repositories/single_category_repository.dart'
    as _i28;
import 'package:kweeksnews_app/features/single_category/domain/usecases/get_category.dart'
    as _i39;
import 'package:kweeksnews_app/features/single_category/domain/usecases/get_posts.dart'
    as _i44;
import 'package:kweeksnews_app/features/single_category/presentation/notifier/category_posts_notifier.dart'
    as _i65;
import 'package:kweeksnews_app/features/single_category/presentation/notifier/single_category_notifier.dart'
    as _i58;
import 'package:kweeksnews_app/features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i31;
import 'package:kweeksnews_app/features/single_post/domain/repositories/single_post_repository.dart'
    as _i30;
import 'package:kweeksnews_app/features/single_post/domain/usecases/check_post_save_status.dart'
    as _i36;
import 'package:kweeksnews_app/features/single_post/domain/usecases/create_saved_post.dart'
    as _i37;
import 'package:kweeksnews_app/features/single_post/domain/usecases/delete_saved_post.dart'
    as _i38;
import 'package:kweeksnews_app/features/single_post/domain/usecases/get_post.dart'
    as _i41;
import 'package:kweeksnews_app/features/single_post/domain/usecases/get_related_posts.dart'
    as _i53;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i13;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i52;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i54;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i59;
import 'package:kweeksnews_app/features/single_tag/data/repositories/single_tag_repository_impl.dart'
    as _i33;
import 'package:kweeksnews_app/features/single_tag/domain/repositories/single_tag_repository.dart'
    as _i32;
import 'package:kweeksnews_app/features/single_tag/domain/usecases/get_posts.dart'
    as _i45;
import 'package:kweeksnews_app/features/single_tag/domain/usecases/get_tag.dart'
    as _i49;
import 'package:kweeksnews_app/features/single_tag/presentation/notifier/single_tag_notifier.dart'
    as _i60;
import 'package:kweeksnews_app/features/single_tag/presentation/notifier/tag_posts_notifier.dart'
    as _i62;
import 'package:kweeksnews_app/features/single_user/data/repositories/single_user_repository_impl.dart'
    as _i35;
import 'package:kweeksnews_app/features/single_user/domain/repositories/single_user_repository.dart'
    as _i34;
import 'package:kweeksnews_app/features/single_user/domain/usecases/get_posts.dart'
    as _i42;
import 'package:kweeksnews_app/features/single_user/domain/usecases/get_user.dart'
    as _i51;
import 'package:kweeksnews_app/features/single_user/presentation/notifier/single_user_notifier.dart'
    as _i61;
import 'package:kweeksnews_app/features/single_user/presentation/notifier/user_posts_notifier.dart'
    as _i64;
import 'package:kweeksnews_app/features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i14;

import 'core/router/app_router.dart' as _i69;
import 'injection.dart' as _i68;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    final appRouter = _$AppRouter();
    gh.lazySingleton<_i3.AppDatabase>(
        () => _i3.AppDatabase(gh<_i4.QueryExecutor>()));
    await gh.singletonAsync<_i5.Box<Map<dynamic, dynamic>>>(
      () => appModule.gqlCacheBox,
      instanceName: 'gqlCacheBox',
      preResolve: true,
    );
    gh.factoryParam<_i6.ContentGroupDropdownNotifier, List<String>, dynamic>((
      intialIds,
      _,
    ) =>
        _i6.ContentGroupDropdownNotifier(intialIds));
    gh.singleton<_i7.GlobalKey<_i7.NavigatorState>>(
      appRouter.rootNavigatorKey,
      instanceName: 'rootNavigatorKey',
    );
    gh.lazySingleton<_i7.GlobalKey<_i8.ContentGroupState>>(
      () => appModule.contentGroupWidgetKey3,
      instanceName: 'contentGroupWidgetKey3',
    );
    gh.singleton<_i7.GlobalKey<_i7.NavigatorState>>(
      appRouter.shellNavigatorKey,
      instanceName: 'shellNavigatorKey',
    );
    gh.lazySingleton<_i7.GlobalKey<_i8.ContentGroupState>>(
      () => appModule.contentGroupWidgetKey4,
      instanceName: 'contentGroupWidgetKey4',
    );
    gh.lazySingleton<_i7.GlobalKey<_i9.SavedPostsPageState>>(
      () => appModule.savedPostsPageKey,
      instanceName: 'savedPostsPageKey',
    );
    gh.lazySingleton<_i7.GlobalKey<_i8.ContentGroupState>>(
      () => appModule.contentGroupWidgetKey2,
      instanceName: 'contentGroupWidgetKey2',
    );
    gh.lazySingleton<_i7.GlobalKey<_i8.ContentGroupState>>(
      () => appModule.contentGroupWidgetKey1,
      instanceName: 'contentGroupWidgetKey1',
    );
    gh.lazySingleton<_i7.GlobalKey<_i10.FeaturedContentState>>(
      () => appModule.featuredContentWidgetKey,
      instanceName: 'featuredContentWidgetKey',
    );
    gh.singleton<_i11.GoRouter>(appRouter.rootRouter(
      gh<_i7.GlobalKey<_i7.NavigatorState>>(instanceName: 'rootNavigatorKey'),
      gh<_i7.GlobalKey<_i7.NavigatorState>>(instanceName: 'shellNavigatorKey'),
    ));
    gh.lazySingleton<_i12.GraphQLClient>(() => appModule.gqlClient(
        gh<_i5.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
    gh.factory<_i13.LightboxNotifier>(() => _i13.LightboxNotifier());
    gh.factory<_i14.LoadingProgressNotifier>(
        () => _i14.LoadingProgressNotifier());
    gh.lazySingleton<_i15.LocaleLocalDataSource>(() =>
        _i15.LocaleLocalDataSourceImpl(
            gh<_i5.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i4.QueryExecutor>(() => appModule.queryExecutor);
    gh.factory<_i16.SearchBarFilledStatusNotifier>(
        () => _i16.SearchBarFilledStatusNotifier());
    gh.factory<_i16.SearchTermNotifier>(() => _i16.SearchTermNotifier());
    gh.lazySingleton<_i17.ThemeLocalDataSource>(() =>
        _i17.ThemeLocalDataSourceImpl(
            gh<_i5.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i18.WpRemoteDataSource>(
        () => _i18.WpRemoteDataSourceImpl(gh<_i12.GraphQLClient>()));
    await gh.singletonAsync<_i5.Box<dynamic>>(
      () => appModule.settingsBox,
      instanceName: 'settingsBox',
      preResolve: true,
    );
    gh.lazySingleton<_i19.HomeRepository>(
        () => _i20.HomeRepositoryImpl(gh<_i18.WpRemoteDataSource>()));
    gh.lazySingleton<_i21.SavedPostsLocalDataSource>(
        () => _i21.SavedPostsLocalDataSource(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i22.SavedPostsRepository>(() =>
        _i23.SavedPostsRepositoryImpl(gh<_i21.SavedPostsLocalDataSource>()));
    gh.lazySingleton<_i24.SearchRepository>(
        () => _i25.SearchRepositoryImpl(gh<_i18.WpRemoteDataSource>()));
    gh.lazySingleton<_i26.SettingsRepository>(() => _i27.SettingsRepositoryImpl(
          gh<_i17.ThemeLocalDataSource>(),
          gh<_i15.LocaleLocalDataSource>(),
        ));
    gh.lazySingleton<_i28.SingleCategoryRepository>(
        () => _i29.SingleCategoryRepositoryImpl(gh<_i18.WpRemoteDataSource>()));
    gh.lazySingleton<_i30.SinglePostRepository>(
        () => _i31.SinglePostRepositoryImpl(
              gh<_i21.SavedPostsLocalDataSource>(),
              gh<_i18.WpRemoteDataSource>(),
            ));
    gh.lazySingleton<_i32.SingleTagRepository>(
        () => _i33.SingleTagRepositoryImpl(gh<_i18.WpRemoteDataSource>()));
    gh.lazySingleton<_i34.SingleUserRepository>(
        () => _i35.SingleUserRepositoryImpl(gh<_i18.WpRemoteDataSource>()));
    gh.lazySingleton<_i36.CheckPostSaveStatus>(
        () => _i36.CheckPostSaveStatus(gh<_i30.SinglePostRepository>()));
    gh.lazySingleton<_i37.CreateSavedPost>(
        () => _i37.CreateSavedPost(gh<_i30.SinglePostRepository>()));
    gh.lazySingleton<_i38.DeleteSavedPost>(
        () => _i38.DeleteSavedPost(gh<_i30.SinglePostRepository>()));
    gh.lazySingleton<_i39.GetCategory>(
        () => _i39.GetCategory(gh<_i28.SingleCategoryRepository>()));
    gh.lazySingleton<_i40.GetLocale>(
        () => _i40.GetLocale(gh<_i26.SettingsRepository>()));
    gh.lazySingleton<_i41.GetPost>(
        () => _i41.GetPost(gh<_i30.SinglePostRepository>()));
    gh.lazySingleton<_i42.GetPosts>(
        () => _i42.GetPosts(gh<_i34.SingleUserRepository>()));
    gh.lazySingleton<_i43.GetPosts>(
        () => _i43.GetPosts(gh<_i19.HomeRepository>()));
    gh.lazySingleton<_i44.GetPosts>(
        () => _i44.GetPosts(gh<_i28.SingleCategoryRepository>()));
    gh.lazySingleton<_i45.GetPosts>(
        () => _i45.GetPosts(gh<_i32.SingleTagRepository>()));
    gh.factoryParam<_i16.SearchNotifier, _i46.Ref<Object?>, dynamic>((
      _ref,
      _,
    ) =>
        _i16.SearchNotifier(
          gh<_i47.SearchPosts>(),
          _ref,
        ));
    gh.lazySingleton<_i48.GetSavedPosts>(
        () => _i48.GetSavedPosts(gh<_i22.SavedPostsRepository>()));
    gh.lazySingleton<_i49.GetTag>(
        () => _i49.GetTag(gh<_i32.SingleTagRepository>()));
    gh.lazySingleton<_i50.GetTheme>(
        () => _i50.GetTheme(gh<_i26.SettingsRepository>()));
    gh.lazySingleton<_i51.GetUser>(
        () => _i51.GetUser(gh<_i34.SingleUserRepository>()));
    gh.factory<_i52.RelatedPostsNotifier>(
        () => _i52.RelatedPostsNotifier(gh<_i53.GetRelatedPosts>()));
    gh.factory<_i54.SavedPostNotifier>(() => _i54.SavedPostNotifier(
          gh<_i37.CreateSavedPost>(),
          gh<_i38.DeleteSavedPost>(),
          gh<_i36.CheckPostSaveStatus>(),
          gh<_i7.GlobalKey<_i9.SavedPostsPageState>>(
              instanceName: 'savedPostsPageKey'),
        ));
    gh.factory<_i55.SavedPostsNotifier>(
        () => _i55.SavedPostsNotifier(gh<_i48.GetSavedPosts>()));
    gh.lazySingleton<_i47.SearchPosts>(
        () => _i47.SearchPosts(gh<_i24.SearchRepository>()));
    gh.lazySingleton<_i56.SetLocale>(
        () => _i56.SetLocale(gh<_i26.SettingsRepository>()));
    gh.lazySingleton<_i57.SetTheme>(
        () => _i57.SetTheme(gh<_i26.SettingsRepository>()));
    gh.factory<_i58.SingleCategoryNotifier>(
        () => _i58.SingleCategoryNotifier(gh<_i39.GetCategory>()));
    gh.factory<_i59.SinglePostNotifier>(
        () => _i59.SinglePostNotifier(gh<_i41.GetPost>()));
    gh.factory<_i60.SingleTagNotifier>(
        () => _i60.SingleTagNotifier(gh<_i49.GetTag>()));
    gh.factory<_i61.SingleUserNotifier>(
        () => _i61.SingleUserNotifier(gh<_i51.GetUser>()));
    gh.factory<_i62.TagPostsNotifier>(
        () => _i62.TagPostsNotifier(gh<_i45.GetPosts>()));
    gh.factoryParam<_i63.ThemeNotifier, _i7.GlobalKey<_i7.NavigatorState>,
        dynamic>((
      _rootNavigatorKey,
      _,
    ) =>
        _i63.ThemeNotifier(
          _rootNavigatorKey,
          gh<_i50.GetTheme>(),
          gh<_i57.SetTheme>(),
        ));
    gh.factory<_i64.UserPostsNotifier>(
        () => _i64.UserPostsNotifier(gh<_i42.GetPosts>()));
    gh.factory<_i65.CategoryPostsNotifier>(
        () => _i65.CategoryPostsNotifier(gh<_i44.GetPosts>()));
    gh.factoryParam<_i6.ContentGroupNotifier, List<String>, _i46.Ref<Object?>>((
      _initialIds,
      _ref,
    ) =>
        _i6.ContentGroupNotifier(
          gh<_i43.GetPosts>(),
          _initialIds,
          _ref,
        ));
    gh.factory<_i66.FeaturedContentNotifier>(
        () => _i66.FeaturedContentNotifier(gh<_i43.GetPosts>()));
    gh.factoryParam<_i67.LocaleNotifier, _i7.GlobalKey<_i7.NavigatorState>,
        dynamic>((
      _rootNavigatorKey,
      _,
    ) =>
        _i67.LocaleNotifier(
          _rootNavigatorKey,
          gh<_i40.GetLocale>(),
          gh<_i56.SetLocale>(),
        ));
    gh.lazySingleton<_i53.GetRelatedPosts>(
        () => _i53.GetRelatedPosts(gh<_i30.SinglePostRepository>()));
    return this;
  }
}

class _$AppModule extends _i68.AppModule {}

class _$AppRouter extends _i69.AppRouter {}
