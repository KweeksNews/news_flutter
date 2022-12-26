// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i15;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i26;
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i10;
import 'package:graphql/client.dart' as _i11;
import 'package:hive/hive.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kweeksnews_app/core/data/database/app_database.dart' as _i20;
import 'package:kweeksnews_app/core/data/datasources/saved_posts_local_data_source.dart'
    as _i23;
import 'package:kweeksnews_app/core/data/datasources/wp_remote_data_source.dart'
    as _i17;
import 'package:kweeksnews_app/core/data/repositories/wp_repository_impl.dart'
    as _i19;
import 'package:kweeksnews_app/core/domain/repositories/wp_repository.dart'
    as _i18;
import 'package:kweeksnews_app/core/domain/usecases/get_posts.dart' as _i21;
import 'package:kweeksnews_app/features/home/presentation/notifier/content_group_notifier.dart'
    as _i5;
import 'package:kweeksnews_app/features/home/presentation/notifier/featured_content_notifier.dart'
    as _i46;
import 'package:kweeksnews_app/features/home/presentation/widgets/content_group.dart'
    as _i7;
import 'package:kweeksnews_app/features/home/presentation/widgets/featured_content.dart'
    as _i8;
import 'package:kweeksnews_app/features/saved_posts/data/repositories/saved_posts_repository_impl.dart'
    as _i25;
import 'package:kweeksnews_app/features/saved_posts/domain/repositories/saved_posts_repository.dart'
    as _i24;
import 'package:kweeksnews_app/features/saved_posts/domain/usecases/get_saved_posts.dart'
    as _i49;
import 'package:kweeksnews_app/features/saved_posts/presentation/notifier/saved_posts_notifier.dart'
    as _i54;
import 'package:kweeksnews_app/features/saved_posts/presentation/pages/saved_posts.dart'
    as _i9;
import 'package:kweeksnews_app/features/search/presentation/notifier/search_notifier.dart'
    as _i16;
import 'package:kweeksnews_app/features/settings/data/datasources/locale_local_data_source.dart'
    as _i14;
import 'package:kweeksnews_app/features/settings/data/datasources/theme_local_data_source.dart'
    as _i3;
import 'package:kweeksnews_app/features/settings/data/repositories/settings_repository_impl.dart'
    as _i28;
import 'package:kweeksnews_app/features/settings/domain/repositories/settings_repository.dart'
    as _i27;
import 'package:kweeksnews_app/features/settings/domain/usecases/get_locale.dart'
    as _i42;
import 'package:kweeksnews_app/features/settings/domain/usecases/get_theme.dart'
    as _i51;
import 'package:kweeksnews_app/features/settings/domain/usecases/set_locale.dart'
    as _i43;
import 'package:kweeksnews_app/features/settings/domain/usecases/set_theme.dart'
    as _i55;
import 'package:kweeksnews_app/features/settings/presentation/notifier/locale_notifier.dart'
    as _i41;
import 'package:kweeksnews_app/features/settings/presentation/notifier/theme_notifier.dart'
    as _i60;
import 'package:kweeksnews_app/features/single_category/data/repositories/single_category_repository_impl.dart'
    as _i30;
import 'package:kweeksnews_app/features/single_category/domain/repositories/single_category_repository.dart'
    as _i29;
import 'package:kweeksnews_app/features/single_category/domain/usecases/get_category.dart'
    as _i47;
import 'package:kweeksnews_app/features/single_category/presentation/notifier/category_posts_notifier.dart'
    as _i39;
import 'package:kweeksnews_app/features/single_category/presentation/notifier/single_category_notifier.dart'
    as _i56;
import 'package:kweeksnews_app/features/single_post/data/repositories/single_posts_repository_impl.dart'
    as _i32;
import 'package:kweeksnews_app/features/single_post/domain/repositories/single_post_repository.dart'
    as _i31;
import 'package:kweeksnews_app/features/single_post/domain/usecases/check_post_save_status.dart'
    as _i40;
import 'package:kweeksnews_app/features/single_post/domain/usecases/create_saved_post.dart'
    as _i44;
import 'package:kweeksnews_app/features/single_post/domain/usecases/delete_saved_post.dart'
    as _i45;
import 'package:kweeksnews_app/features/single_post/domain/usecases/get_post.dart'
    as _i48;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/lightbox_notifier.dart'
    as _i12;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/related_posts_notifier.dart'
    as _i22;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/saved_post_notifier.dart'
    as _i53;
import 'package:kweeksnews_app/features/single_post/presentation/notifier/single_post_notifier.dart'
    as _i57;
import 'package:kweeksnews_app/features/single_tag/data/repositories/single_tag_repository_impl.dart'
    as _i34;
import 'package:kweeksnews_app/features/single_tag/domain/repositories/single_tag_repository.dart'
    as _i33;
import 'package:kweeksnews_app/features/single_tag/domain/usecases/get_tag.dart'
    as _i50;
import 'package:kweeksnews_app/features/single_tag/presentation/notifier/single_tag_notifier.dart'
    as _i58;
import 'package:kweeksnews_app/features/single_tag/presentation/notifier/tag_posts_notifier.dart'
    as _i37;
import 'package:kweeksnews_app/features/single_user/data/repositories/single_user_repository_impl.dart'
    as _i36;
import 'package:kweeksnews_app/features/single_user/domain/repositories/single_user_repository.dart'
    as _i35;
import 'package:kweeksnews_app/features/single_user/domain/usecases/get_user.dart'
    as _i52;
import 'package:kweeksnews_app/features/single_user/presentation/notifier/single_user_notifier.dart'
    as _i59;
import 'package:kweeksnews_app/features/single_user/presentation/notifier/user_posts_notifier.dart'
    as _i38;
import 'package:kweeksnews_app/features/webview/presentation/notifier/loading_progress_notifier.dart'
    as _i13;

import 'core/presentation/router/app_router.dart' as _i62;
import 'injection.dart' as _i61;

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
    gh.lazySingleton<_i3.ThemeLocalDataSource>(() =>
        _i3.ThemeLocalDataSourceImpl(
            gh<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
    await gh.singletonAsync<_i4.Box<dynamic>>(
      () => appInjection.settingsBox,
      instanceName: 'settingsBox',
      preResolve: true,
    );
    gh.factoryParam<_i5.ContentGroupDropdownNotifier, List<String>, dynamic>((
      intialIds,
      _,
    ) =>
        _i5.ContentGroupDropdownNotifier(intialIds));
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
      () => appInjection.contentGroupWidgetKey4,
      instanceName: 'contentGroupWidgetKey4',
    );
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
      () => appInjection.contentGroupWidgetKey2,
      instanceName: 'contentGroupWidgetKey2',
    );
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
      () => appInjection.contentGroupWidgetKey1,
      instanceName: 'contentGroupWidgetKey1',
    );
    gh.lazySingleton<_i6.GlobalKey<_i8.FeaturedContentState>>(
      () => appInjection.featuredContentWidgetKey,
      instanceName: 'featuredContentWidgetKey',
    );
    gh.singleton<_i6.GlobalKey<_i6.NavigatorState>>(
      appRouter.rootNavigatorKey,
      instanceName: 'rootNavigatorKey',
    );
    gh.lazySingleton<_i6.GlobalKey<_i7.ContentGroupState>>(
      () => appInjection.contentGroupWidgetKey3,
      instanceName: 'contentGroupWidgetKey3',
    );
    gh.singleton<_i6.GlobalKey<_i6.NavigatorState>>(
      appRouter.shellNavigatorKey,
      instanceName: 'shellNavigatorKey',
    );
    gh.lazySingleton<_i6.GlobalKey<_i9.SavedPostsPageState>>(
      () => appInjection.savedPostsPageKey,
      instanceName: 'savedPostsPageKey',
    );
    gh.singleton<_i10.GoRouter>(appRouter.rootRouter(
      gh<_i6.GlobalKey<_i6.NavigatorState>>(instanceName: 'rootNavigatorKey'),
      gh<_i6.GlobalKey<_i6.NavigatorState>>(instanceName: 'shellNavigatorKey'),
    ));
    gh.lazySingleton<_i11.GraphQLClient>(() => appInjection.gqlClient(
        gh<_i4.Box<Map<dynamic, dynamic>>>(instanceName: 'gqlCacheBox')));
    gh.factory<_i12.LightboxNotifier>(() => _i12.LightboxNotifier());
    gh.factory<_i13.LoadingProgressNotifier>(
        () => _i13.LoadingProgressNotifier());
    gh.lazySingleton<_i14.LocaleLocalDataSource>(() =>
        _i14.LocaleLocalDataSourceImpl(
            gh<_i4.Box<dynamic>>(instanceName: 'settingsBox')));
    gh.lazySingleton<_i15.QueryExecutor>(() => appInjection.queryExecutor);
    gh.factory<_i16.SearchBarFilledStatusNotifier>(
        () => _i16.SearchBarFilledStatusNotifier());
    gh.factory<_i16.SearchTermNotifier>(() => _i16.SearchTermNotifier());
    await gh.singletonAsync<_i4.Box<Map<dynamic, dynamic>>>(
      () => appInjection.gqlCacheBox,
      instanceName: 'gqlCacheBox',
      preResolve: true,
    );
    gh.lazySingleton<_i17.WpRemoteDataSource>(
        () => _i17.WpRemoteDataSourceImpl(gh<_i11.GraphQLClient>()));
    gh.lazySingleton<_i18.WpRepository>(
        () => _i19.WpRepositoryImpl(gh<_i17.WpRemoteDataSource>()));
    gh.lazySingleton<_i20.AppDatabase>(
        () => _i20.AppDatabase(gh<_i15.QueryExecutor>()));
    gh.lazySingleton<_i21.GetPosts>(
        () => _i21.GetPosts(gh<_i18.WpRepository>()));
    gh.factory<_i22.RelatedPostsNotifier>(
        () => _i22.RelatedPostsNotifier(gh<_i21.GetPosts>()));
    gh.lazySingleton<_i23.SavedPostsLocalDataSource>(
        () => _i23.SavedPostsLocalDataSourceImpl(gh<_i20.AppDatabase>()));
    gh.lazySingleton<_i24.SavedPostsRepository>(() =>
        _i25.SavedPostsRepositoryImpl(gh<_i23.SavedPostsLocalDataSource>()));
    gh.factoryParam<_i16.SearchNotifier, _i26.Ref<Object?>, dynamic>((
      _ref,
      _,
    ) =>
        _i16.SearchNotifier(
          gh<_i21.GetPosts>(),
          _ref,
        ));
    gh.lazySingleton<_i27.SettingsRepository>(() => _i28.SettingsRepositoryImpl(
          gh<_i3.ThemeLocalDataSource>(),
          gh<_i14.LocaleLocalDataSource>(),
        ));
    gh.lazySingleton<_i29.SingleCategoryRepository>(
        () => _i30.SingleCategoryRepositoryImpl(gh<_i17.WpRemoteDataSource>()));
    gh.lazySingleton<_i31.SinglePostRepository>(
        () => _i32.SinglePostRepositoryImpl(
              gh<_i23.SavedPostsLocalDataSource>(),
              gh<_i17.WpRemoteDataSource>(),
            ));
    gh.lazySingleton<_i33.SingleTagRepository>(
        () => _i34.SingleTagRepositoryImpl(gh<_i17.WpRemoteDataSource>()));
    gh.lazySingleton<_i35.SingleUserRepository>(
        () => _i36.SingleUserRepositoryImpl(gh<_i17.WpRemoteDataSource>()));
    gh.factory<_i37.TagPostsNotifier>(
        () => _i37.TagPostsNotifier(gh<_i21.GetPosts>()));
    gh.factory<_i38.UserPostsNotifier>(
        () => _i38.UserPostsNotifier(gh<_i21.GetPosts>()));
    gh.factory<_i39.CategoryPostsNotifier>(
        () => _i39.CategoryPostsNotifier(gh<_i21.GetPosts>()));
    gh.lazySingleton<_i40.CheckPostSaveStatus>(
        () => _i40.CheckPostSaveStatus(gh<_i31.SinglePostRepository>()));
    gh.factory<_i41.LocaleNotifier>(() => _i41.LocaleNotifier(
          gh<_i42.GetLocale>(),
          gh<_i43.SetLocale>(),
        ));
    gh.lazySingleton<_i44.CreateSavedPost>(
        () => _i44.CreateSavedPost(gh<_i31.SinglePostRepository>()));
    gh.lazySingleton<_i45.DeleteSavedPost>(
        () => _i45.DeleteSavedPost(gh<_i31.SinglePostRepository>()));
    gh.factory<_i46.FeaturedContentNotifier>(
        () => _i46.FeaturedContentNotifier(gh<_i21.GetPosts>()));
    gh.lazySingleton<_i47.GetCategory>(
        () => _i47.GetCategory(gh<_i29.SingleCategoryRepository>()));
    gh.lazySingleton<_i42.GetLocale>(
        () => _i42.GetLocale(gh<_i27.SettingsRepository>()));
    gh.lazySingleton<_i48.GetPost>(
        () => _i48.GetPost(gh<_i31.SinglePostRepository>()));
    gh.lazySingleton<_i49.GetSavedPosts>(
        () => _i49.GetSavedPosts(gh<_i24.SavedPostsRepository>()));
    gh.lazySingleton<_i50.GetTag>(
        () => _i50.GetTag(gh<_i33.SingleTagRepository>()));
    gh.lazySingleton<_i51.GetTheme>(
        () => _i51.GetTheme(gh<_i27.SettingsRepository>()));
    gh.lazySingleton<_i52.GetUser>(
        () => _i52.GetUser(gh<_i35.SingleUserRepository>()));
    gh.factory<_i53.SavedPostNotifier>(() => _i53.SavedPostNotifier(
          gh<_i44.CreateSavedPost>(),
          gh<_i45.DeleteSavedPost>(),
          gh<_i40.CheckPostSaveStatus>(),
          gh<_i6.GlobalKey<_i9.SavedPostsPageState>>(
              instanceName: 'savedPostsPageKey'),
        ));
    gh.factory<_i54.SavedPostsNotifier>(
        () => _i54.SavedPostsNotifier(gh<_i49.GetSavedPosts>()));
    gh.lazySingleton<_i43.SetLocale>(
        () => _i43.SetLocale(gh<_i27.SettingsRepository>()));
    gh.lazySingleton<_i55.SetTheme>(
        () => _i55.SetTheme(gh<_i27.SettingsRepository>()));
    gh.factory<_i56.SingleCategoryNotifier>(
        () => _i56.SingleCategoryNotifier(gh<_i47.GetCategory>()));
    gh.factory<_i57.SinglePostNotifier>(
        () => _i57.SinglePostNotifier(gh<_i48.GetPost>()));
    gh.factory<_i58.SingleTagNotifier>(
        () => _i58.SingleTagNotifier(gh<_i50.GetTag>()));
    gh.factory<_i59.SingleUserNotifier>(
        () => _i59.SingleUserNotifier(gh<_i52.GetUser>()));
    gh.factory<_i60.ThemeNotifier>(() => _i60.ThemeNotifier(
          gh<_i51.GetTheme>(),
          gh<_i55.SetTheme>(),
        ));
    gh.factoryParam<_i5.ContentGroupNotifier, List<String>, _i26.Ref<Object?>>((
      _initialIds,
      _ref,
    ) =>
        _i5.ContentGroupNotifier(
          gh<_i21.GetPosts>(),
          _initialIds,
          _ref,
        ));
    return this;
  }
}

class _$AppInjection extends _i61.AppInjection {}

class _$AppRouter extends _i62.AppRouter {}
