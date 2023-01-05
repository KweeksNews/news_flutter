// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i14;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i30;
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i9;
import 'package:graphql/client.dart' as _i10;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kweeksnews_app/application/saved_posts/get_saved_posts.dart'
    as _i45;
import 'package:kweeksnews_app/application/settings/get_locale.dart' as _i44;
import 'package:kweeksnews_app/application/settings/get_theme.dart' as _i46;
import 'package:kweeksnews_app/application/settings/set_locale.dart' as _i49;
import 'package:kweeksnews_app/application/settings/set_theme.dart' as _i50;
import 'package:kweeksnews_app/application/shared/get_posts.dart' as _i23;
import 'package:kweeksnews_app/application/single_category/get_category.dart'
    as _i21;
import 'package:kweeksnews_app/application/single_post/add_saved_post.dart'
    as _i39;
import 'package:kweeksnews_app/application/single_post/check_post_save_status.dart'
    as _i41;
import 'package:kweeksnews_app/application/single_post/delete_saved_post.dart'
    as _i42;
import 'package:kweeksnews_app/application/single_post/get_post.dart' as _i22;
import 'package:kweeksnews_app/application/single_tag/get_tag.dart' as _i24;
import 'package:kweeksnews_app/application/single_user/get_user.dart' as _i25;
import 'package:kweeksnews_app/domain/repositories/settings/settings_repository.dart'
    as _i31;
import 'package:kweeksnews_app/domain/repositories/shared/saved_posts_repository.dart'
    as _i28;
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart'
    as _i18;
import 'package:kweeksnews_app/infrastructure/database/app_database.dart'
    as _i20;
import 'package:kweeksnews_app/infrastructure/datasources/settings/locale_local_data_source.dart'
    as _i13;
import 'package:kweeksnews_app/infrastructure/datasources/settings/theme_local_data_source.dart'
    as _i16;
import 'package:kweeksnews_app/infrastructure/datasources/shared/saved_posts_local_data_source.dart'
    as _i27;
import 'package:kweeksnews_app/infrastructure/datasources/shared/wp_remote_data_source.dart'
    as _i17;
import 'package:kweeksnews_app/infrastructure/repositories/settings/settings_repository_impl.dart'
    as _i32;
import 'package:kweeksnews_app/infrastructure/repositories/shared/saved_posts_repository_impl.dart'
    as _i29;
import 'package:kweeksnews_app/infrastructure/repositories/shared/wp_repository_impl.dart'
    as _i19;
import 'package:kweeksnews_app/presentation/pages/home/widgets/content_group.dart'
    as _i6;
import 'package:kweeksnews_app/presentation/pages/home/widgets/featured_content.dart'
    as _i8;
import 'package:kweeksnews_app/presentation/pages/saved_posts/saved_posts_page.dart'
    as _i7;
import 'package:kweeksnews_app/presentation/viewmodels/home/content_group_notifier.dart'
    as _i4;
import 'package:kweeksnews_app/presentation/viewmodels/home/featured_content_notifier.dart'
    as _i43;
import 'package:kweeksnews_app/presentation/viewmodels/saved_posts/saved_posts_notifier.dart'
    as _i48;
import 'package:kweeksnews_app/presentation/viewmodels/search/search_notifier.dart'
    as _i15;
import 'package:kweeksnews_app/presentation/viewmodels/settings/locale_notifier.dart'
    as _i52;
import 'package:kweeksnews_app/presentation/viewmodels/settings/theme_notifier.dart'
    as _i51;
import 'package:kweeksnews_app/presentation/viewmodels/single_category/category_posts_notifier.dart'
    as _i40;
import 'package:kweeksnews_app/presentation/viewmodels/single_category/single_category_notifier.dart'
    as _i33;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/lightbox_notifier.dart'
    as _i11;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/related_posts_notifier.dart'
    as _i26;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/saved_post_notifier.dart'
    as _i47;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/single_post_notifier.dart'
    as _i34;
import 'package:kweeksnews_app/presentation/viewmodels/single_tag/single_tag_notifier.dart'
    as _i35;
import 'package:kweeksnews_app/presentation/viewmodels/single_tag/tag_posts_notifier.dart'
    as _i37;
import 'package:kweeksnews_app/presentation/viewmodels/single_user/single_user_notifier.dart'
    as _i36;
import 'package:kweeksnews_app/presentation/viewmodels/single_user/user_posts_notifier.dart'
    as _i38;
import 'package:kweeksnews_app/presentation/viewmodels/webview/loading_progress_notifier.dart'
    as _i12;

import 'injection.dart' as _i53;
import 'presentation/router/app_router.dart' as _i54;

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
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupState>>(
      () => appInjection.contentGroupWidgetKey3,
      instanceName: 'contentGroupWidgetKey3',
    );
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupState>>(
      () => appInjection.contentGroupWidgetKey4,
      instanceName: 'contentGroupWidgetKey4',
    );
    gh.lazySingleton<_i5.GlobalKey<_i7.SavedPostsPageState>>(
      () => appInjection.savedPostsPageKey,
      instanceName: 'savedPostsPageKey',
    );
    gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      appRouter.rootNavigatorKey,
      instanceName: 'rootNavigatorKey',
    );
    gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(
      appRouter.shellNavigatorKey,
      instanceName: 'shellNavigatorKey',
    );
    gh.lazySingleton<_i5.GlobalKey<_i8.FeaturedContentState>>(
      () => appInjection.featuredContentWidgetKey,
      instanceName: 'featuredContentWidgetKey',
    );
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupState>>(
      () => appInjection.contentGroupWidgetKey1,
      instanceName: 'contentGroupWidgetKey1',
    );
    gh.lazySingleton<_i5.GlobalKey<_i6.ContentGroupState>>(
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
    gh.factory<_i15.SearchTermNotifier>(() => _i15.SearchTermNotifier());
    gh.lazySingleton<_i16.ThemeLocalDataSource>(() =>
        _i16.ThemeLocalDataSourceImpl(
            gh<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i17.WpRemoteDataSource>(
        () => _i17.WpRemoteDataSourceImpl(gh<_i10.GraphQLClient>()));
    gh.lazySingleton<_i18.WpRepository>(
        () => _i19.WpRepositoryImpl(gh<_i17.WpRemoteDataSource>()));
    gh.lazySingleton<_i20.AppDatabase>(
        () => _i20.AppDatabase(gh<_i14.QueryExecutor>()));
    gh.lazySingleton<_i21.GetCategory>(
        () => _i21.GetCategory(gh<_i18.WpRepository>()));
    gh.lazySingleton<_i22.GetPost>(() => _i22.GetPost(gh<_i18.WpRepository>()));
    gh.lazySingleton<_i23.GetPosts>(
        () => _i23.GetPosts(gh<_i18.WpRepository>()));
    gh.lazySingleton<_i24.GetTag>(() => _i24.GetTag(gh<_i18.WpRepository>()));
    gh.lazySingleton<_i25.GetUser>(() => _i25.GetUser(gh<_i18.WpRepository>()));
    gh.factory<_i26.RelatedPostsNotifier>(
        () => _i26.RelatedPostsNotifier(gh<_i23.GetPosts>()));
    gh.lazySingleton<_i27.SavedPostsLocalDataSource>(
        () => _i27.SavedPostsLocalDataSourceImpl(gh<_i20.AppDatabase>()));
    gh.lazySingleton<_i28.SavedPostsRepository>(() =>
        _i29.SavedPostsRepositoryImpl(gh<_i27.SavedPostsLocalDataSource>()));
    gh.factoryParam<_i15.SearchNotifier, _i30.Ref<Object?>, dynamic>((
      _ref,
      _,
    ) =>
        _i15.SearchNotifier(
          gh<_i23.GetPosts>(),
          _ref,
        ));
    gh.lazySingleton<_i31.SettingsRepository>(() => _i32.SettingsRepositoryImpl(
          gh<_i16.ThemeLocalDataSource>(),
          gh<_i13.LocaleLocalDataSource>(),
        ));
    gh.factory<_i33.SingleCategoryNotifier>(
        () => _i33.SingleCategoryNotifier(gh<_i21.GetCategory>()));
    gh.factory<_i34.SinglePostNotifier>(
        () => _i34.SinglePostNotifier(gh<_i22.GetPost>()));
    gh.factory<_i35.SingleTagNotifier>(
        () => _i35.SingleTagNotifier(gh<_i24.GetTag>()));
    gh.factory<_i36.SingleUserNotifier>(
        () => _i36.SingleUserNotifier(gh<_i25.GetUser>()));
    gh.factory<_i37.TagPostsNotifier>(
        () => _i37.TagPostsNotifier(gh<_i23.GetPosts>()));
    gh.factory<_i38.UserPostsNotifier>(
        () => _i38.UserPostsNotifier(gh<_i23.GetPosts>()));
    gh.lazySingleton<_i39.AddSavedPost>(
        () => _i39.AddSavedPost(gh<_i28.SavedPostsRepository>()));
    gh.factory<_i40.CategoryPostsNotifier>(
        () => _i40.CategoryPostsNotifier(gh<_i23.GetPosts>()));
    gh.lazySingleton<_i41.CheckPostSaveStatus>(
        () => _i41.CheckPostSaveStatus(gh<_i28.SavedPostsRepository>()));
    gh.factoryParam<_i4.ContentGroupNotifier, List<String>, _i30.Ref<Object?>>((
      _initialIds,
      _ref,
    ) =>
        _i4.ContentGroupNotifier(
          gh<_i23.GetPosts>(),
          _initialIds,
          _ref,
        ));
    gh.lazySingleton<_i42.DeleteSavedPost>(
        () => _i42.DeleteSavedPost(gh<_i28.SavedPostsRepository>()));
    gh.factory<_i43.FeaturedContentNotifier>(
        () => _i43.FeaturedContentNotifier(gh<_i23.GetPosts>()));
    gh.lazySingleton<_i44.GetLocale>(
        () => _i44.GetLocale(gh<_i31.SettingsRepository>()));
    gh.lazySingleton<_i45.GetSavedPosts>(
        () => _i45.GetSavedPosts(gh<_i28.SavedPostsRepository>()));
    gh.lazySingleton<_i46.GetTheme>(
        () => _i46.GetTheme(gh<_i31.SettingsRepository>()));
    gh.factory<_i47.SavedPostNotifier>(() => _i47.SavedPostNotifier(
          gh<_i39.AddSavedPost>(),
          gh<_i42.DeleteSavedPost>(),
          gh<_i41.CheckPostSaveStatus>(),
          gh<_i5.GlobalKey<_i7.SavedPostsPageState>>(
              instanceName: 'savedPostsPageKey'),
        ));
    gh.factory<_i48.SavedPostsNotifier>(
        () => _i48.SavedPostsNotifier(gh<_i45.GetSavedPosts>()));
    gh.lazySingleton<_i49.SetLocale>(
        () => _i49.SetLocale(gh<_i31.SettingsRepository>()));
    gh.lazySingleton<_i50.SetTheme>(
        () => _i50.SetTheme(gh<_i31.SettingsRepository>()));
    gh.factory<_i51.ThemeNotifier>(() => _i51.ThemeNotifier(
          gh<_i46.GetTheme>(),
          gh<_i50.SetTheme>(),
        ));
    gh.factory<_i52.LocaleNotifier>(() => _i52.LocaleNotifier(
          gh<_i44.GetLocale>(),
          gh<_i49.SetLocale>(),
        ));
    return this;
  }
}

class _$AppInjection extends _i53.AppInjection {}

class _$AppRouter extends _i54.AppRouter {}
