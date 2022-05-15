/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/config.dart';
import '../../../../core/types/content_group_type.dart';
import '../../../../providers.dart';
import '../widgets/content_group.dart';
import '../widgets/featured_content.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final GlobalKey<FeaturedContentState> featuredContentKey =
      GlobalKey<FeaturedContentState>();
  final GlobalKey<ContentGroupState> contentGroupKey1 =
      GlobalKey<ContentGroupState>();
  final GlobalKey<ContentGroupState> contentGroupKey2 =
      GlobalKey<ContentGroupState>();
  final GlobalKey<ContentGroupState> contentGroupKey3 =
      GlobalKey<ContentGroupState>();
  final GlobalKey<ContentGroupState> contentGroupKey4 =
      GlobalKey<ContentGroupState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Image(
          image: AssetImage(
            ThemeData.estimateBrightnessForColor(
                        Theme.of(context).appBarTheme.backgroundColor!) !=
                    Brightness.light
                ? 'assets/img/dark/icon.png'
                : 'assets/img/light/icon.png',
          ),
          width: 170,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.sync(
            () {
              featuredContentKey.currentState?.refresh(forceRefresh: true);
              contentGroupKey1.currentState?.refresh(forceRefresh: true);
              contentGroupKey2.currentState?.refresh(forceRefresh: true);
              contentGroupKey3.currentState?.refresh(forceRefresh: true);
              contentGroupKey4.currentState?.refresh(forceRefresh: true);
            },
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: FeaturedContent(
                  postsCount: 5,
                  key: featuredContentKey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: ContentGroup(
                  title: 'Kiriman',
                  type: ContentGroupType.category,
                  ids: CONFIG.homeContentGroup1,
                  postsCount: 5,
                  key: contentGroupKey1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: ContentGroup(
                  title: 'Organisasi Santri',
                  type: ContentGroupType.tag,
                  ids: CONFIG.homeContentGroup2,
                  postsCount: 5,
                  key: contentGroupKey2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: ContentGroup(
                  title: 'Organisasi Daerah',
                  type: ContentGroupType.tag,
                  ids: CONFIG.homeContentGroup3,
                  postsCount: 5,
                  key: contentGroupKey3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                child: ContentGroup(
                  title: 'Komunitas',
                  type: ContentGroupType.tag,
                  ids: CONFIG.homeContentGroup4,
                  postsCount: 5,
                  key: contentGroupKey4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
