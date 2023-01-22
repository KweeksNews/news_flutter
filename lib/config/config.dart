import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../domain/entities/content_group_config.dart';
import '../domain/entities/search_category.dart';

mixin CONFIG {
  /// Site hostname.
  /// Accessible via https protocol.
  static const String hostName = 'www.kweeksnews.com';

  /// Headers for any http request
  static const Map<String, String> headers = {
    'accept': 'application/json; charset=utf-8',
    'cache-control': 'no-cache',
    'content-type': 'application/json; charset=utf-8',
    'user-agent': 'KweeksNews/2.0.0 (+com.kweeksnews)',
  };

  /// Home content group 1 config.
  static List<ContentGroupConfig> homeContentGroup1 = [
    ContentGroupConfig.category(
      name: 'Artikel',
      id: '1',
    ),
    ContentGroupConfig.category(
      name: 'Kabar',
      id: '953',
    ),
    ContentGroupConfig.category(
      name: 'Cerpen',
      id: '5',
    ),
    ContentGroupConfig.category(
      name: 'Puisi',
      id: '4',
    ),
    ContentGroupConfig.category(
      name: 'Podcast',
      id: '67',
    ),
    ContentGroupConfig.category(
      name: 'Video',
      id: '19',
    ),
  ];

  /// Home content group 2 config.
  static List<ContentGroupConfig> homeContentGroup2 = [
    ContentGroupConfig.tag(
      name: 'IPM',
      id: '7',
    ),
    ContentGroupConfig.tag(
      name: 'HW',
      id: '8',
    ),
    ContentGroupConfig.tag(
      name: 'TS',
      id: '9',
    ),
    ContentGroupConfig.tag(
      name: 'LPM',
      id: '10',
    ),
    ContentGroupConfig.tag(
      name: 'MSC',
      id: '11',
    ),
    ContentGroupConfig.tag(
      name: 'SPM',
      id: '12',
    ),
    ContentGroupConfig.tag(
      name: 'SUMMIT',
      id: '13',
    ),
  ];

  /// Home content group 2 config.
  static List<ContentGroupConfig> homeContentGroup3 = [
    ContentGroupConfig.tag(
      name: 'IKMMMY',
      id: '1105',
    ),
    ContentGroupConfig.tag(
      name: 'AMMAKSDA',
      id: '1109',
    ),
    ContentGroupConfig.tag(
      name: 'IPMMMATIM',
      id: '1110',
    ),
    ContentGroupConfig.tag(
      name: 'IKMMMASSSITA',
      id: '1111',
    ),
  ];

  /// Home content group 2 config.
  static List<ContentGroupConfig> homeContentGroup4 = [
    ContentGroupConfig.tag(
      name: 'IKMAMMM',
      id: '1087',
    ),
    ContentGroupConfig.tag(
      name: 'Rasyidi Circle',
      id: '15',
    ),
  ];

  /// Search category config.
  static const List<SearchCategory> searchCategory = [
    SearchCategory(
      id: 1,
      slug: 'article',
      name: 'Artikel',
      icon: FontAwesomeIcons.alignCenter,
    ),
    SearchCategory(
      id: 953,
      slug: 'news',
      name: 'Kabar',
      icon: FontAwesomeIcons.newspaper,
    ),
    SearchCategory(
      id: 5,
      slug: 'short-story',
      name: 'Cerpen',
      icon: FontAwesomeIcons.bookOpen,
    ),
    SearchCategory(
      id: 4,
      slug: 'poetry',
      name: 'Puisi',
      icon: FontAwesomeIcons.featherPointed,
    ),
    SearchCategory(
      id: 67,
      slug: 'podcast',
      name: 'Podcast',
      icon: FontAwesomeIcons.podcast,
    ),
    SearchCategory(
      id: 19,
      slug: 'video',
      name: 'Video',
      icon: FontAwesomeIcons.video,
    ),
    SearchCategory(
      id: 1084,
      slug: 'announcement',
      name: 'Pengumuman',
      icon: FontAwesomeIcons.bullhorn,
    )
  ];
}
