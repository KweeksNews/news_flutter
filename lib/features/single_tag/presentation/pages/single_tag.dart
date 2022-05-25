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
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/entities/state_exception.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/types/state_exception_type.dart';
import '../../../../core/types/tag_id_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../providers.dart';
import '../notifier/notifier.dart';
import '../widgets/tag_posts.dart';

class SingleTag extends ConsumerStatefulWidget {
  final String id;
  final TagIdType idType;
  final String? name;

  const SingleTag({
    required this.id,
    required this.idType,
    this.name,
    Key? key,
  }) : super(key: key);

  @override
  _SingleTagState createState() => _SingleTagState();
}

class _SingleTagState extends ConsumerState<SingleTag> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        ref.read(singleTagProvider.notifier).fetchTag(
              id: widget.id,
              idType: widget.idType,
            );
      },
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(singleTagProvider.notifier).fetchTag(
          id: widget.id,
          idType: widget.idType,
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

                  if (state is SingleTagLoaded) {
                    return Text(
                      state.tag.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  } else {
                    return Text(
                      widget.name ??
                          AppLocalizations.of(context).pageSingleTagTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
          body: Builder(
            builder: (context) {
              final SingleTagState state = ref.watch(singleTagProvider);

              if (state is SingleTagLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SingleTagLoaded) {
                return RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => refresh(forceRefresh: true),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        if (state.tag.description.isNotEmpty)
                          Html(
                            data: state.tag.description,
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
                          id: state.tag.id,
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is SingleTagException) {
                late StateException exception;

                if (state.type == StateExceptionType.failedToLoadData) {
                  exception = StateException(
                    message: AppLocalizations.of(context).errorFailedToLoadData,
                    image: 'assets/img/error.png',
                  );
                } else {
                  exception = StateException(
                    message: AppLocalizations.of(context).errorGeneric,
                    image: 'assets/img/error.png',
                  );
                }

                return ErrorIndicator(
                  message: exception.message,
                  image: exception.image,
                  onTryAgain: () {
                    refresh();
                  },
                );
              } else {
                return const Nil();
              }
            },
          ),
        ),
      ),
    );
  }
}
