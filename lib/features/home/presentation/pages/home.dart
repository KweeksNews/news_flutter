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

import '../../../../config/config.dart';
import '../../../../core/domain/enums/content_group_type.dart';
import '../../../../injection.dart';
import '../widgets/content_group.dart';
import '../widgets/featured_content.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    super.key,
  });

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late GlobalKey<FeaturedContentState> _featuredContentWidgetKey;
  late GlobalKey<ContentGroupState> _contentGroupWidgetKey1;
  late GlobalKey<ContentGroupState> _contentGroupWidgetKey2;
  late GlobalKey<ContentGroupState> _contentGroupWidgetKey3;
  late GlobalKey<ContentGroupState> _contentGroupWidgetKey4;

  @override
  void initState() {
    super.initState();

    _featuredContentWidgetKey = getIt<GlobalKey<FeaturedContentState>>(
      instanceName: 'featuredContentWidgetKey',
    );
    _contentGroupWidgetKey1 = getIt<GlobalKey<ContentGroupState>>(
      instanceName: 'contentGroupWidgetKey1',
    );
    _contentGroupWidgetKey2 = getIt<GlobalKey<ContentGroupState>>(
      instanceName: 'contentGroupWidgetKey2',
    );
    _contentGroupWidgetKey3 = getIt<GlobalKey<ContentGroupState>>(
      instanceName: 'contentGroupWidgetKey3',
    );
    _contentGroupWidgetKey4 = getIt<GlobalKey<ContentGroupState>>(
      instanceName: 'contentGroupWidgetKey4',
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              centerTitle: true,
              elevation: 0,
              title: Image(
                image: AssetImage(
                  ThemeData.estimateBrightnessForColor(
                              Theme.of(context).appBarTheme.backgroundColor!) !=
                          Brightness.light
                      ? 'assets/img/dark/logo.png'
                      : 'assets/img/light/logo.png',
                ),
                width: 170,
              ),
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () {
              return Future.sync(
                () {
                  _featuredContentWidgetKey.currentState?.refresh(
                    forceRefresh: true,
                  );
                  _contentGroupWidgetKey1.currentState?.refresh(
                    forceRefresh: true,
                  );
                  _contentGroupWidgetKey2.currentState?.refresh(
                    forceRefresh: true,
                  );
                  _contentGroupWidgetKey3.currentState?.refresh(
                    forceRefresh: true,
                  );
                  _contentGroupWidgetKey4.currentState?.refresh(
                    forceRefresh: true,
                  );
                },
              );
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FeaturedContent(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    postsCount: 5,
                    key: _featuredContentWidgetKey,
                  ),
                  ContentGroup(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    title: 'Kiriman',
                    type: ContentGroupType.category,
                    ids: CONFIG.homeContentGroup1,
                    postsCount: 5,
                    key: _contentGroupWidgetKey1,
                  ),
                  ContentGroup(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    title: 'Organisasi Santri',
                    type: ContentGroupType.tag,
                    ids: CONFIG.homeContentGroup2,
                    postsCount: 5,
                    key: _contentGroupWidgetKey2,
                  ),
                  ContentGroup(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    title: 'Organisasi Daerah',
                    type: ContentGroupType.tag,
                    ids: CONFIG.homeContentGroup3,
                    postsCount: 5,
                    key: _contentGroupWidgetKey3,
                  ),
                  ContentGroup(
                    margin: const EdgeInsets.only(top: 20, bottom: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    title: 'Komunitas',
                    type: ContentGroupType.tag,
                    ids: CONFIG.homeContentGroup4,
                    postsCount: 5,
                    key: _contentGroupWidgetKey4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
