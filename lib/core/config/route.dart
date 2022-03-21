import '../router/route_config.dart';

enum RouteName {
  home,
  search,
  savedPosts,
  settings,
  singlePost,
  contact,
  submitContent,
}

mixin ROUTE {
  static const Map<String, String> pattern = {
    'home': '/',
    'search': '/search',
    'savedPosts': '/saved-posts',
    'settings': '/settings',
    'singlePost': '/posts/:slug',
    'contact': '/contact',
    'submitContent': '/submit-content',
  };

  static final Map<String, RouteConfig> config = {
    'home': RouteConfig(
      name: RouteName.home,
      key: 'HomePage',
      template: pattern['home']!,
    ),
    'search': RouteConfig(
      name: RouteName.search,
      key: 'SearchPage',
      template: pattern['search']!,
    ),
    'savedPosts': RouteConfig(
      name: RouteName.savedPosts,
      key: 'SavedPostsPage',
      template: pattern['savedPosts']!,
    ),
    'settings': RouteConfig(
      name: RouteName.settings,
      key: 'SettingsPage',
      template: pattern['settings']!,
    ),
    'singlePost': RouteConfig(
      name: RouteName.singlePost,
      key: 'SinglePostPage',
      template: pattern['singlePost']!,
    ),
    'contact': RouteConfig(
      name: RouteName.contact,
      key: 'ContactPage',
      template: pattern['contact']!,
    ),
    'submitContent': RouteConfig(
      name: RouteName.submitContent,
      key: 'SubmitContentPage',
      template: pattern['submitContent']!,
    ),
  };
}
