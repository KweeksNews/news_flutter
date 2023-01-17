// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../domain/enums/content_group_type.dart';
import '../../../injection.dart';
import 'widgets/content_group.dart';
import 'widgets/featured_content.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late GlobalKey<FeaturedContentWidgetState> _featuredContentWidgetKey;
  late GlobalKey<ContentGroupWidgetState> _contentGroupWidgetKey1;
  late GlobalKey<ContentGroupWidgetState> _contentGroupWidgetKey2;
  late GlobalKey<ContentGroupWidgetState> _contentGroupWidgetKey3;
  late GlobalKey<ContentGroupWidgetState> _contentGroupWidgetKey4;

  @override
  void initState() {
    super.initState();

    _featuredContentWidgetKey = getIt<GlobalKey<FeaturedContentWidgetState>>(
      instanceName: 'featuredContentWidgetKey',
    );
    _contentGroupWidgetKey1 = getIt<GlobalKey<ContentGroupWidgetState>>(
      instanceName: 'contentGroupWidgetKey1',
    );
    _contentGroupWidgetKey2 = getIt<GlobalKey<ContentGroupWidgetState>>(
      instanceName: 'contentGroupWidgetKey2',
    );
    _contentGroupWidgetKey3 = getIt<GlobalKey<ContentGroupWidgetState>>(
      instanceName: 'contentGroupWidgetKey3',
    );
    _contentGroupWidgetKey4 = getIt<GlobalKey<ContentGroupWidgetState>>(
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
