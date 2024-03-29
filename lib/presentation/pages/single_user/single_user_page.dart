// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/user_id.dart';
import '../../../providers.dart';
import '../../l10n/generated/l10n.dart';
import '../../viewmodels/single_user/notifier.dart';
import '../../widgets/shared/error_indicator.dart';
import '../../widgets/single_user/user_posts.dart';

class SingleUser extends ConsumerStatefulWidget {
  final UserId id;
  final String? slug;

  const SingleUser({
    super.key,
    required this.id,
    this.slug,
  });

  @override
  ConsumerState<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends ConsumerState<SingleUser> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        ref.read(singleUserProvider.notifier).fetchUser(
              id: widget.id,
            );
      },
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(singleUserProvider.notifier).fetchUser(
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
                  final SingleUserState state = ref.watch(singleUserProvider);

                  return state.maybeWhen(
                    loaded: (user) {
                      return Text(
                        user.slug,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                    orElse: () {
                      return Text(
                        widget.slug ??
                            AppLocalizations.of(context).pageSingleUserTitle,
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
              final SingleUserState state = ref.watch(singleUserProvider);

              return state.when(
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (user) {
                  return RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => refresh(forceRefresh: true),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                user.avatar,
                              ),
                              radius: 40,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat',
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (user.description.isNotEmpty)
                            Html(
                              data: user.description,
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
                          UserPosts(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            id: user.id,
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
