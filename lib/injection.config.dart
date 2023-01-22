// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i15;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i33;
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i10;
import 'package:graphql/client.dart' as _i11;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kweeksnews_app/application/saved_posts/get_saved_posts.dart'
    as _i49;
import 'package:kweeksnews_app/application/settings/get_locale.dart' as _i48;
import 'package:kweeksnews_app/application/settings/get_theme.dart' as _i50;
import 'package:kweeksnews_app/application/settings/set_locale.dart' as _i53;
import 'package:kweeksnews_app/application/settings/set_theme.dart' as _i54;
import 'package:kweeksnews_app/application/shared/get_posts.dart' as _i25;
import 'package:kweeksnews_app/application/single_category/get_category.dart'
    as _i23;
import 'package:kweeksnews_app/application/single_post/add_saved_post.dart'
    as _i42;
import 'package:kweeksnews_app/application/single_post/check_post_save_status.dart'
    as _i44;
import 'package:kweeksnews_app/application/single_post/delete_saved_post.dart'
    as _i46;
import 'package:kweeksnews_app/application/single_post/get_post.dart' as _i24;
import 'package:kweeksnews_app/application/single_tag/get_tag.dart' as _i26;
import 'package:kweeksnews_app/application/single_user/get_user.dart' as _i27;
import 'package:kweeksnews_app/domain/entities/content_group_ids.dart' as _i5;
import 'package:kweeksnews_app/domain/repositories/settings/settings_repository.dart'
    as _i34;
import 'package:kweeksnews_app/domain/repositories/shared/saved_posts_repository.dart'
    as _i30;
import 'package:kweeksnews_app/domain/repositories/shared/wp_repository.dart'
    as _i20;
import 'package:kweeksnews_app/infrastructure/database/app_database.dart'
    as _i22;
import 'package:kweeksnews_app/infrastructure/datasources/settings/locale_local_data_source.dart'
    as _i14;
import 'package:kweeksnews_app/infrastructure/datasources/settings/theme_local_data_source.dart'
    as _i18;
import 'package:kweeksnews_app/infrastructure/datasources/shared/saved_posts_local_data_source.dart'
    as _i29;
import 'package:kweeksnews_app/infrastructure/datasources/shared/wp_remote_data_source.dart'
    as _i19;
import 'package:kweeksnews_app/infrastructure/repositories/settings/settings_repository_impl.dart'
    as _i35;
import 'package:kweeksnews_app/infrastructure/repositories/shared/saved_posts_repository_impl.dart'
    as _i31;
import 'package:kweeksnews_app/infrastructure/repositories/shared/wp_repository_impl.dart'
    as _i21;
import 'package:kweeksnews_app/presentation/pages/home/widgets/content_group.dart'
    as _i7;
import 'package:kweeksnews_app/presentation/pages/home/widgets/featured_content.dart'
    as _i9;
import 'package:kweeksnews_app/presentation/pages/saved_posts/saved_posts_page.dart'
    as _i8;
import 'package:kweeksnews_app/presentation/viewmodels/home/content_group_dropdown_notifier.dart'
    as _i4;
import 'package:kweeksnews_app/presentation/viewmodels/home/content_group_notifier.dart'
    as _i45;
import 'package:kweeksnews_app/presentation/viewmodels/home/featured_content_notifier.dart'
    as _i47;
import 'package:kweeksnews_app/presentation/viewmodels/saved_posts/saved_posts_notifier.dart'
    as _i52;
import 'package:kweeksnews_app/presentation/viewmodels/search/search_bar_filled_status_notifier.dart'
    as _i16;
import 'package:kweeksnews_app/presentation/viewmodels/search/search_notifier.dart'
    as _i32;
import 'package:kweeksnews_app/presentation/viewmodels/search/search_term_notifier.dart'
    as _i17;
import 'package:kweeksnews_app/presentation/viewmodels/settings/locale_notifier.dart'
    as _i56;
import 'package:kweeksnews_app/presentation/viewmodels/settings/theme_notifier.dart'
    as _i55;
import 'package:kweeksnews_app/presentation/viewmodels/single_category/category_posts_notifier.dart'
    as _i43;
import 'package:kweeksnews_app/presentation/viewmodels/single_category/single_category_notifier.dart'
    as _i36;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/lightbox_notifier.dart'
    as _i12;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/related_posts_notifier.dart'
    as _i28;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/saved_post_notifier.dart'
    as _i51;
import 'package:kweeksnews_app/presentation/viewmodels/single_post/single_post_notifier.dart'
    as _i37;
import 'package:kweeksnews_app/presentation/viewmodels/single_tag/single_tag_notifier.dart'
    as _i38;
import 'package:kweeksnews_app/presentation/viewmodels/single_tag/tag_posts_notifier.dart'
    as _i40;
import 'package:kweeksnews_app/presentation/viewmodels/single_user/single_user_notifier.dart'
    as _i39;
import 'package:kweeksnews_app/presentation/viewmodels/single_user/user_posts_notifier.dart'
    as _i41;
import 'package:kweeksnews_app/presentation/viewmodels/webview/loading_progress_notifier.dart'
    as _i13;

import 'injection.dart' as _i57;
import 'presentation/router/app_router.dart' as _i58;

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
    gh.factoryParam<_i4.ContentGroupDropdownNotifier, _i5.ContentGroupIds,
        dynamic>((
      intialIds,
      _,
    ) =>
        _i4.ContentGroupDropdownNotifier(intialIds));
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey2,
      instanceName: 'contentGroupWidgetKey2',
    );
    gh.singleton<_i6.GlobalKey<_i6.NavigatorState>>(
      appRouter.shellNavigatorKey,
      instanceName: 'shellNavigatorKey',
    );
    gh.singleton<_i6.GlobalKey<_i6.NavigatorState>>(
      appRouter.rootNavigatorKey,
      instanceName: 'rootNavigatorKey',
    );
    gh.lazySingleton<_i6.GlobalKey<_i8.SavedPostsPageState>>(
      () => appInjection.savedPostsPageKey,
      instanceName: 'savedPostsPageKey',
    );
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey4,
      instanceName: 'contentGroupWidgetKey4',
    );
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey3,
      instanceName: 'contentGroupWidgetKey3',
    );
    gh.lazySingleton<_i6.GlobalKey<_i9.FeaturedContentWidgetState>>(
      () => appInjection.featuredContentWidgetKey,
      instanceName: 'featuredContentWidgetKey',
    );
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupWidgetState>>(
      () => appInjection.contentGroupWidgetKey1,
      instanceName: 'contentGroupWidgetKey1',
    );
    gh.singleton<_i10.GoRouter>(appRouter.rootRouter(
      gh<_i6.GlobalKey<_i6.NavigatorState>>(instanceName: 'rootNavigatorKey'),
      gh<_i6.GlobalKey<_i6.NavigatorState>>(instanceName: 'shellNavigatorKey'),
    ));
    gh.lazySingleton<_i11.GraphQLClient>(() => appInjection.gqlClient(
        gh<_i3.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
    gh.factory<_i12.LightboxNotifier>(() => _i12.LightboxNotifier());
    gh.factory<_i13.LoadingProgressNotifier>(
        () => _i13.LoadingProgressNotifier());
    gh.lazySingleton<_i14.LocaleLocalDataSource>(() =>
        _i14.LocaleLocalDataSourceImpl(
            gh<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i15.QueryExecutor>(() => appInjection.queryExecutor);
    gh.factory<_i16.SearchBarFilledStatusNotifier>(
        () => _i16.SearchBarFilledStatusNotifier());
    gh.factory<_i17.SearchTermNotifier>(() => _i17.SearchTermNotifier());
    gh.lazySingleton<_i18.ThemeLocalDataSource>(() =>
        _i18.ThemeLocalDataSourceImpl(
            gh<_i3.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i19.WpRemoteDataSource>(
        () => _i19.WpRemoteDataSourceImpl(gh<_i11.GraphQLClient>()));
    gh.lazySingleton<_i20.WpRepository>(
        () => _i21.WpRepositoryImpl(gh<_i19.WpRemoteDataSource>()));
    gh.lazySingleton<_i22.AppDatabase>(
        () => _i22.AppDatabase(gh<_i15.QueryExecutor>()));
    gh.lazySingleton<_i23.GetCategory>(
        () => _i23.GetCategory(gh<_i20.WpRepository>()));
    gh.lazySingleton<_i24.GetPost>(() => _i24.GetPost(gh<_i20.WpRepository>()));
    gh.lazySingleton<_i25.GetPosts>(
        () => _i25.GetPosts(gh<_i20.WpRepository>()));
    gh.lazySingleton<_i26.GetTag>(() => _i26.GetTag(gh<_i20.WpRepository>()));
    gh.lazySingleton<_i27.GetUser>(() => _i27.GetUser(gh<_i20.WpRepository>()));
    gh.factory<_i28.RelatedPostsNotifier>(
        () => _i28.RelatedPostsNotifier(gh<_i25.GetPosts>()));
    gh.lazySingleton<_i29.SavedPostsLocalDataSource>(
        () => _i29.SavedPostsLocalDataSourceImpl(gh<_i22.AppDatabase>()));
    gh.lazySingleton<_i30.SavedPostsRepository>(() =>
        _i31.SavedPostsRepositoryImpl(gh<_i29.SavedPostsLocalDataSource>()));
    gh.factoryParam<_i32.SearchNotifier, _i33.Ref<Object?>, dynamic>((
      _ref,
      _,
    ) =>
        _i32.SearchNotifier(
          gh<_i25.GetPosts>(),
          _ref,
        ));
    gh.lazySingleton<_i34.SettingsRepository>(() => _i35.SettingsRepositoryImpl(
          gh<_i18.ThemeLocalDataSource>(),
          gh<_i14.LocaleLocalDataSource>(),
        ));
    gh.factory<_i36.SingleCategoryNotifier>(
        () => _i36.SingleCategoryNotifier(gh<_i23.GetCategory>()));
    gh.factory<_i37.SinglePostNotifier>(
        () => _i37.SinglePostNotifier(gh<_i24.GetPost>()));
    gh.factory<_i38.SingleTagNotifier>(
        () => _i38.SingleTagNotifier(gh<_i26.GetTag>()));
    gh.factory<_i39.SingleUserNotifier>(
        () => _i39.SingleUserNotifier(gh<_i27.GetUser>()));
    gh.factory<_i40.TagPostsNotifier>(
        () => _i40.TagPostsNotifier(gh<_i25.GetPosts>()));
    gh.factory<_i41.UserPostsNotifier>(
        () => _i41.UserPostsNotifier(gh<_i25.GetPosts>()));
    gh.lazySingleton<_i42.AddSavedPost>(
        () => _i42.AddSavedPost(gh<_i30.SavedPostsRepository>()));
    gh.factory<_i43.CategoryPostsNotifier>(
        () => _i43.CategoryPostsNotifier(gh<_i25.GetPosts>()));
    gh.lazySingleton<_i44.CheckPostSaveStatus>(
        () => _i44.CheckPostSaveStatus(gh<_i30.SavedPostsRepository>()));
    gh.factoryParam<_i45.ContentGroupNotifier, _i5.ContentGroupIds,
        _i33.Ref<Object?>>((
      _initialIds,
      _ref,
    ) =>
        _i45.ContentGroupNotifier(
          gh<_i25.GetPosts>(),
          _initialIds,
          _ref,
        ));
    gh.lazySingleton<_i46.DeleteSavedPost>(
        () => _i46.DeleteSavedPost(gh<_i30.SavedPostsRepository>()));
    gh.factory<_i47.FeaturedContentNotifier>(
        () => _i47.FeaturedContentNotifier(gh<_i25.GetPosts>()));
    gh.lazySingleton<_i48.GetLocale>(
        () => _i48.GetLocale(gh<_i34.SettingsRepository>()));
    gh.lazySingleton<_i49.GetSavedPosts>(
        () => _i49.GetSavedPosts(gh<_i30.SavedPostsRepository>()));
    gh.lazySingleton<_i50.GetTheme>(
        () => _i50.GetTheme(gh<_i34.SettingsRepository>()));
    gh.factory<_i51.SavedPostNotifier>(() => _i51.SavedPostNotifier(
          gh<_i42.AddSavedPost>(),
          gh<_i46.DeleteSavedPost>(),
          gh<_i44.CheckPostSaveStatus>(),
          gh<_i6.GlobalKey<_i8.SavedPostsPageState>>(
              instanceName: 'savedPostsPageKey'),
        ));
    gh.factory<_i52.SavedPostsNotifier>(
        () => _i52.SavedPostsNotifier(gh<_i49.GetSavedPosts>()));
    gh.lazySingleton<_i53.SetLocale>(
        () => _i53.SetLocale(gh<_i34.SettingsRepository>()));
    gh.lazySingleton<_i54.SetTheme>(
        () => _i54.SetTheme(gh<_i34.SettingsRepository>()));
    gh.factory<_i55.ThemeNotifier>(() => _i55.ThemeNotifier(
          gh<_i50.GetTheme>(),
          gh<_i54.SetTheme>(),
        ));
    gh.factory<_i56.LocaleNotifier>(() => _i56.LocaleNotifier(
          gh<_i48.GetLocale>(),
          gh<_i53.SetLocale>(),
        ));
    return this;
  }
}

class _$AppInjection extends _i57.AppInjection {}

class _$AppRouter extends _i58.AppRouter {}
