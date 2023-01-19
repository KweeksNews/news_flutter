// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i14;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i32;
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i9;
import 'package:graphql/client.dart' as _i10;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kweeksnews_app/application/saved_posts/get_saved_posts.dart'
    as _i48;
import 'package:kweeksnews_app/application/settings/get_locale.dart' as _i47;
import 'package:kweeksnews_app/application/settings/get_theme.dart' as _i49;
import 'package:kweeksnews_app/application/settings/set_locale.dart' as _i52;
import 'package:kweeksnews_app/application/settings/set_theme.dart' as _i53;
import 'package:kweeksnews_app/application/shared/get_posts.dart' as _i24;
import 'package:kweeksnews_app/application/single_category/get_category.dart'
    as _i22;
import 'package:kweeksnews_app/application/single_post/add_saved_post.dart'
    as _i41;
import 'package:kweeksnews_app/application/single_post/check_post_save_status.dart'
    as _i43;
import 'package:kweeksnews_app/application/single_post/delete_saved_post.dart'
    as _i45;
import 'package:kweeksnews_app/application/single_post/get_post.dart' as _i23;
import 'package:kweeksnews_app/application/single_tag/get_tag.dart' as _i25;
import 'package:kweeksnews_app/application/single_user/get_user.dart' as _i26;
import 'package:kweeksnews_app/domain/repositories/settings/settings_repository.dart'
    as _i33;
import 'package:kweeksnews_app/domain/repositories/shared/saved_posts_repository.dart'
    as _i29;
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart'
    as _i19;
import 'package:kweeksnews_app/infrastructure/database/app_database.dart'
    as _i21;
import 'package:kweeksnews_app/infrastructure/datasources/settings/locale_local_data_source.dart'
    as _i13;
import 'package:kweeksnews_app/infrastructure/datasources/settings/theme_local_data_source.dart'
    as _i17;
import 'package:kweeksnews_app/infrastructure/datasources/shared/saved_posts_local_data_source.dart'
    as _i28;
import 'package:kweeksnews_app/infrastructure/datasources/shared/wp_remote_data_source.dart'
    as _i18;
import 'package:kweeksnews_app/infrastructure/repositories/settings/settings_repository_impl.dart'
    as _i34;
import 'package:kweeksnews_app/infrastructure/repositories/shared/saved_posts_repository_impl.dart'
    as _i30;
import 'package:kweeksnews_app/infrastructure/repositories/shared/wp_repository_impl.dart'
    as _i20;
import 'package:kweeksnews_app/presentation/pages/home/widgets/content_group.dart'
    as _i6;
import 'package:kweeksnews_app/presentation/pages/home/widgets/featured_content.dart'
    as _i8;
import 'package:kweeksnews_app/presentation/pages/saved_posts/saved_posts_page.dart'
    as _i7;
import 'package:kweeksnews_app/presentation/viewmodels/home/content_group_dropdown_notifier.dart'
    as _i4;
import 'package:kweeksnews_app/presentation/viewmodels/home/content_group_notifier.dart'
    as _i44;
import 'package:kweeksnews_app/presentation/viewmodels/home/featured_content_notifier.dart'
    as _i46;
import 'package:kweeksnews_app/presentation/viewmodels/saved_posts/saved_posts_notifier.dart'
    as _i51;
import 'package:kweeksnews_app/presentation/viewmodels/search/search_bar_filled_status_notifier.dart'
    as _i15;
import 'package:kweeksnews_app/presentation/viewmodels/search/search_notifier.dart'
    as _i31;
import 'package:kweeksnews_app/presentation/viewmodels/search/search_term_notifier.dart'
    as _i16;
import 'package:kweeksnews_app/presentation/viewmodels/settings/locale_notifier.dart'
    as _i55;
import 'package:kweeksnews_app/presentation/viewmodels/settings/theme_notifier.dart'
    as _i54;
import 'package:kweeksnews_app/presentation/viewmodels/single_category/category_posts_notifier.dart'
    as _i42;
import 'package:kweeksnews_app/presentation/viewmodels/single_category/single_category_notifier.dart'
    as _i35;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/lightbox_notifier.dart'
    as _i11;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/related_posts_notifier.dart'
    as _i27;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/saved_post_notifier.dart'
    as _i50;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/single_post_notifier.dart'
    as _i36;
import 'package:kweeksnews_app/presentation/viewmodels/single_tag/single_tag_notifier.dart'
    as _i37;
import 'package:kweeksnews_app/presentation/viewmodels/single_tag/tag_posts_notifier.dart'
    as _i39;
import 'package:kweeksnews_app/presentation/viewmodels/single_user/single_user_notifier.dart'
    as _i38;
import 'package:kweeksnews_app/presentation/viewmodels/single_user/user_posts_notifier.dart'
    as _i40;
import 'package:kweeksnews_app/presentation/viewmodels/webview/loading_progress_notifier.dart'
    as _i12;

import 'injection.dart' as _i56;
import 'presentation/router/app_router.dart' as _i57;

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
    final appInjection = _$AppInjection();
    final appRouter = _$AppRouter();
    await gh.singletonAsync<_i3.Box<Map<dynamic, dynamic>>>(
      () => appInjection.gqlCacheBox,
      instanceName: 'gqlCacheBox',
      preResolve: true,
    );
    await gh.singletonAsync<_i3.Box<dynamic>>(
      () => appInjection.settingsBox,
      instanceName: 'settingsBox',
      preResolve: true,
    );
    gh.factoryParam<_i4.ContentGroupDropdownNotifier, List<String>, dynamic>((
      intialIds,
      _,
    ) =>
        _i4.ContentGroupDropdownNotifier(intialIds));
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey3,
      instanceName: 'contentGroupWidgetKey3',
    );
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey4,
      instanceName: 'contentGroupWidgetKey4',
    );
    gh.lazySingleton<_i5.GlobalKey<_i7.SavedPostsPageState>>(
      () => appInjection.savedPostsPageKey,
      instanceName: 'savedPostsPageKey',
    );
    gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      appRouter.shellNavigatorKey,
      instanceName: 'shellNavigatorKey',
    );
    gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      appRouter.rootNavigatorKey,
      instanceName: 'rootNavigatorKey',
    );
    gh.lazySingleton<_i5.GlobalKey<_i8.FeaturedContentWidgetState>>(
      () => appInjection.featuredContentWidgetKey,
      instanceName: 'featuredContentWidgetKey',
    );
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey1,
      instanceName: 'contentGroupWidgetKey1',
    );
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey2,
      instanceName: 'contentGroupWidgetKey2',
    );
    gh.singleton<_i9.GoRouter>(appRouter.rootRouter(
      gh<_i5.GlobalKey<_i5.NavigatorState>>(instanceName: 'rootNavigatorKey'),
      gh<_i5.GlobalKey<_i5.NavigatorState>>(instanceName: 'shellNavigatorKey'),
    ));
    gh.lazySingleton<_i10.GraphQLClient>(() => appInjection.gqlClient(
        gh<_i3.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
    gh.factory<_i11.LightboxNotifier>(() => _i11.LightboxNotifier());
    gh.factory<_i12.LoadingProgressNotifier>(
        () => _i12.LoadingProgressNotifier());
    gh.lazySingleton<_i13.LocaleLocalDataSource>(() =>
        _i13.LocaleLocalDataSourceImpl(
            gh<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i14.QueryExecutor>(() => appInjection.queryExecutor);
    gh.factory<_i15.SearchBarFilledStatusNotifier>(
        () => _i15.SearchBarFilledStatusNotifier());
    gh.factory<_i16.SearchTermNotifier>(() => _i16.SearchTermNotifier());
    gh.lazySingleton<_i17.ThemeLocalDataSource>(() =>
        _i17.ThemeLocalDataSourceImpl(
            gh<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i18.WpRemoteDataSource>(
        () => _i18.WpRemoteDataSourceImpl(gh<_i10.GraphQLClient>()));
    gh.lazySingleton<_i19.WpRepository>(
        () => _i20.WpRepositoryImpl(gh<_i18.WpRemoteDataSource>()));
    gh.lazySingleton<_i21.AppDatabase>(
        () => _i21.AppDatabase(gh<_i14.QueryExecutor>()));
    gh.lazySingleton<_i22.GetCategory>(
        () => _i22.GetCategory(gh<_i19.WpRepository>()));
    gh.lazySingleton<_i23.GetPost>(() => _i23.GetPost(gh<_i19.WpRepository>()));
    gh.lazySingleton<_i24.GetPosts>(
        () => _i24.GetPosts(gh<_i19.WpRepository>()));
    gh.lazySingleton<_i25.GetTag>(() => _i25.GetTag(gh<_i19.WpRepository>()));
    gh.lazySingleton<_i26.GetUser>(() => _i26.GetUser(gh<_i19.WpRepository>()));
    gh.factory<_i27.RelatedPostsNotifier>(
        () => _i27.RelatedPostsNotifier(gh<_i24.GetPosts>()));
    gh.lazySingleton<_i28.SavedPostsLocalDataSource>(
        () => _i28.SavedPostsLocalDataSourceImpl(gh<_i21.AppDatabase>()));
    gh.lazySingleton<_i29.SavedPostsRepository>(() =>
        _i30.SavedPostsRepositoryImpl(gh<_i28.SavedPostsLocalDataSource>()));
    gh.factoryParam<_i31.SearchNotifier, _i32.Ref<Object?>, dynamic>((
      _ref,
      _,
    ) =>
        _i31.SearchNotifier(
          gh<_i24.GetPosts>(),
          _ref,
        ));
    gh.lazySingleton<_i33.SettingsRepository>(() => _i34.SettingsRepositoryImpl(
          gh<_i17.ThemeLocalDataSource>(),
          gh<_i13.LocaleLocalDataSource>(),
        ));
    gh.factory<_i35.SingleCategoryNotifier>(
        () => _i35.SingleCategoryNotifier(gh<_i22.GetCategory>()));
    gh.factory<_i36.SinglePostNotifier>(
        () => _i36.SinglePostNotifier(gh<_i23.GetPost>()));
    gh.factory<_i37.SingleTagNotifier>(
        () => _i37.SingleTagNotifier(gh<_i25.GetTag>()));
    gh.factory<_i38.SingleUserNotifier>(
        () => _i38.SingleUserNotifier(gh<_i26.GetUser>()));
    gh.factory<_i39.TagPostsNotifier>(
        () => _i39.TagPostsNotifier(gh<_i24.GetPosts>()));
    gh.factory<_i40.UserPostsNotifier>(
        () => _i40.UserPostsNotifier(gh<_i24.GetPosts>()));
    gh.lazySingleton<_i41.AddSavedPost>(
        () => _i41.AddSavedPost(gh<_i29.SavedPostsRepository>()));
    gh.factory<_i42.CategoryPostsNotifier>(
        () => _i42.CategoryPostsNotifier(gh<_i24.GetPosts>()));
    gh.lazySingleton<_i43.CheckPostSaveStatus>(
        () => _i43.CheckPostSaveStatus(gh<_i29.SavedPostsRepository>()));
    gh.factoryParam<_i44.ContentGroupNotifier, List<String>, _i32.Ref<Object?>>(
        (
      _initialIds,
      _ref,
    ) =>
            _i44.ContentGroupNotifier(
              gh<_i24.GetPosts>(),
              _initialIds,
              _ref,
            ));
    gh.lazySingleton<_i45.DeleteSavedPost>(
        () => _i45.DeleteSavedPost(gh<_i29.SavedPostsRepository>()));
    gh.factory<_i46.FeaturedContentNotifier>(
        () => _i46.FeaturedContentNotifier(gh<_i24.GetPosts>()));
    gh.lazySingleton<_i47.GetLocale>(
        () => _i47.GetLocale(gh<_i33.SettingsRepository>()));
    gh.lazySingleton<_i48.GetSavedPosts>(
        () => _i48.GetSavedPosts(gh<_i29.SavedPostsRepository>()));
    gh.lazySingleton<_i49.GetTheme>(
        () => _i49.GetTheme(gh<_i33.SettingsRepository>()));
    gh.factory<_i50.SavedPostNotifier>(() => _i50.SavedPostNotifier(
          gh<_i41.AddSavedPost>(),
          gh<_i45.DeleteSavedPost>(),
          gh<_i43.CheckPostSaveStatus>(),
          gh<_i5.GlobalKey<_i7.SavedPostsPageState>>(
              instanceName: 'savedPostsPageKey'),
        ));
    gh.factory<_i51.SavedPostsNotifier>(
        () => _i51.SavedPostsNotifier(gh<_i48.GetSavedPosts>()));
    gh.lazySingleton<_i52.SetLocale>(
        () => _i52.SetLocale(gh<_i33.SettingsRepository>()));
    gh.lazySingleton<_i53.SetTheme>(
        () => _i53.SetTheme(gh<_i33.SettingsRepository>()));
    gh.factory<_i54.ThemeNotifier>(() => _i54.ThemeNotifier(
          gh<_i49.GetTheme>(),
          gh<_i53.SetTheme>(),
        ));
    gh.factory<_i55.LocaleNotifier>(() => _i55.LocaleNotifier(
          gh<_i47.GetLocale>(),
          gh<_i52.SetLocale>(),
        ));
    return this;
  }
}

class _$AppInjection extends _i56.AppInjection {}

class _$AppRouter extends _i57.AppRouter {}
