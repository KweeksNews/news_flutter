// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/category_id.dart';
import '../../../providers.dart';
import '../../l10n/generated/l10n.dart';
import '../../viewmodels/single_category/notifier.dart';
import '../../widgets/shared/error_indicator.dart';
import '../../widgets/single_category/category_posts.dart';

class SingleCategoryPage extends ConsumerStatefulWidget {
  final CategoryId id;
  final String? name;

  const SingleCategoryPage({
    super.key,
    required this.id,
    this.name,
  });

  @override
  ConsumerState<SingleCategoryPage> createState() => _SingleCategoryPageState();
}

class _SingleCategoryPageState extends ConsumerState<SingleCategoryPage> {
  late String? _name;

  @override
  void initState() {
    super.initState();

    _name = widget.name;

    Future.delayed(
      Duration.zero,
      () {
        ref.read(singleCategoryProvider.notifier).fetchCategory(
              id: widget.id,
            );
      },
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(singleCategoryProvider.notifier).fetchCategory(
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
                  final SingleCategoryState state =
                      ref.watch(singleCategoryProvider);

                  return state.maybeWhen(
                    loaded: (category) {
                      return Text(
                        category.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                    orElse: () {
                      return Text(
                        _name ??
                            AppLocalizations.of(context)
                                .pageSingleCategoryTitle,
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
              final SingleCategoryState state =
                  ref.watch(singleCategoryProvider);

              return state.when(
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (category) {
                  return RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => refresh(forceRefresh: true),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          if (category.description.isNotEmpty)
                            Html(
                              data: category.description,
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
                          if (category.children.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Wrap(
                                spacing: 15,
                                runSpacing: 0,
                                children: category.children.map(
                                  (d) {
                                    return ActionChip(
                                      label: Text(
                                        d.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      pressElevation: 2,
                                      onPressed: () {
                                        context.push(
                                          '/categories/${d.slug}',
                                          extra: d.name,
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          CategoryPosts(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            id: category.id,
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
