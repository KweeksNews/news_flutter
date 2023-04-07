// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers.dart';
import '../../../l10n/generated/l10n.dart';
import '../../../viewmodels/home/notifier.dart';
import '../../shared/error_indicator.dart';
import '../../shared/post_box.dart';
import '../../shared/post_box_loading.dart';

class FeaturedContent extends ConsumerStatefulWidget {
  final int postsCount;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const FeaturedContent({
    super.key,
    required this.postsCount,
    this.margin,
    this.padding,
  });

  @override
  ConsumerState<FeaturedContent> createState() => FeaturedContentWidgetState();
}

class FeaturedContentWidgetState extends ConsumerState<FeaturedContent> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        ref.read(featuredContentProvider.notifier).fetchPage(
              postsCount: widget.postsCount,
            );
      },
    );
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    ref.read(featuredContentProvider.notifier).fetchPage(
          postsCount: widget.postsCount,
          forceRefresh: forceRefresh,
        );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: Builder(
        builder: (context) {
          final FeaturedContentState state = ref.watch(featuredContentProvider);

          return state.when(
            loading: () {
              return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 10,
                  viewportFraction: 1,
                ),
                items: const <Widget>[
                  PostBoxLoading(),
                ],
              );
            },
            loaded: (posts) {
              if (posts.isEmpty) {
                return ErrorIndicator(
                  message: AppLocalizations.of(context).errorNoPosts,
                  image: 'assets/img/no_data.png',
                  onButtonPressed: () {
                    refresh(forceRefresh: true);
                  },
                );
              } else {
                return CarouselSlider.builder(
                  itemCount: posts.length,
                  options: CarouselOptions(
                    aspectRatio: 16 / 10,
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    autoPlay: true,
                  ),
                  itemBuilder: (context, index, tag) {
                    return PostBox(
                      post: posts[index],
                      onTap: () {
                        context.push('/posts/${posts[index].slug}');
                      },
                    );
                  },
                );
              }
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
    );
  }
}
