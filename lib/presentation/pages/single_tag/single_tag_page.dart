// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/tag_id.dart';
import '../../../providers.dart';
import '../../l10n/generated/l10n.dart';
import '../../viewmodels/single_tag/notifier.dart';
import '../shared/widgets/error_indicator.dart';
import 'widgets/tag_posts.dart';

class SingleTagPage extends ConsumerStatefulWidget {
  final TagId id;
  final String? name;

  const SingleTagPage({
    super.key,
    required this.id,
    this.name,
  });

  @override
  ConsumerState<SingleTagPage> createState() => _SingleTagPageState();
}

class _SingleTagPageState extends ConsumerState<SingleTagPage> {
  late String? _name;

  @override
  void initState() {
    super.initState();

    _name = widget.name;

    Future.delayed(
      Duration.zero,
      () {
        ref.read(singleTagProvider.notifier).fetchTag(
              id: widget.id,
            );
      },
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(singleTagProvider.notifier).fetchTag(
          id: widget.id,
          forceRefresh: forceRefresh,
        );
  }

  @override
  Widget build(BuildContext context) {
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
              title: Builder(
                builder: (context) {
                  final SingleTagState state = ref.watch(singleTagProvider);

                  return state.maybeWhen(
                    loaded: (tag) {
                      return Text(
                        tag.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                    orElse: () {
                      return Text(
                        _name ??
                            AppLocalizations.of(context).pageSingleTagTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
          body: Builder(
            builder: (context) {
              final SingleTagState state = ref.watch(singleTagProvider);

              return state.when(
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (tag) {
                  return RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => refresh(forceRefresh: true),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          if (tag.description.isNotEmpty)
                            Html(
                              data: tag.description,
                              onLinkTap: (url, _, __, ___) async {
                                if (await canLaunchUrl(Uri.parse(url!))) {
                                  await launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context)
                                            .errorCannotOpenUrl(url),
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: {
                                '*': Style.fromTextStyle(
                                  Theme.of(context).textTheme.bodyText1!,
                                ).copyWith(
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                  ),
                                  fontFamily: 'Montserrat',
                                ),
                                'body': Style(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                ),
                              },
                            ),
                          TagPosts(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            id: tag.id,
                          )
                        ],
                      ),
                    ),
                  );
                },
                failedToLoadData: () {
                  return ErrorIndicator(
                    message: AppLocalizations.of(context).errorFailedToLoadData,
                    image: 'assets/img/error.png',
                    onButtonPressed: () {
                      refresh();
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
