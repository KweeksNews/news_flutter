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
  static const List<ContentGroupConfig> homeContentGroup1 = [
    ContentGroupConfig(
      name: 'Artikel',
      id: '1',
    ),
    ContentGroupConfig(
      name: 'Kabar',
      id: '953',
    ),
    ContentGroupConfig(
      name: 'Cerpen',
      id: '5',
    ),
    ContentGroupConfig(
      name: 'Puisi',
      id: '4',
    ),
    ContentGroupConfig(
      name: 'Podcast',
      id: '67',
    ),
    ContentGroupConfig(
      name: 'Video',
      id: '19',
    ),
  ];

  /// Home content group 2 config.
  static const List<ContentGroupConfig> homeContentGroup2 = [
    ContentGroupConfig(
      name: 'IPM',
      id: '7',
    ),
    ContentGroupConfig(
      name: 'HW',
      id: '8',
    ),
    ContentGroupConfig(
      name: 'TS',
      id: '9',
    ),
    ContentGroupConfig(
      name: 'LPM',
      id: '10',
    ),
    ContentGroupConfig(
      name: 'MSC',
      id: '11',
    ),
    ContentGroupConfig(
      name: 'SPM',
      id: '12',
    ),
    ContentGroupConfig(
      name: 'SUMMIT',
      id: '13',
    ),
  ];

  /// Home content group 2 config.
  static const List<ContentGroupConfig> homeContentGroup3 = [
    ContentGroupConfig(
      name: 'IKMMMY',
      id: '1105',
    ),
    ContentGroupConfig(
      name: 'AMMAKSDA',
      id: '1109',
    ),
    ContentGroupConfig(
      name: 'IPMMMATIM',
      id: '1110',
    ),
    ContentGroupConfig(
      name: 'IKMMMASSSITA',
      id: '1111',
    ),
  ];

  /// Home content group 2 config.
  static const List<ContentGroupConfig> homeContentGroup4 = [
    ContentGroupConfig(
      name: 'IKMAMMM',
      id: '1087',
    ),
    ContentGroupConfig(
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
