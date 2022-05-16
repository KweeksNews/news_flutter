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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nil/nil.dart';

import '../../../../core/entities/state_exception.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/types/state_exception_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/post_box.dart';
import '../../../../core/widgets/post_box_loading.dart';
import '../../../../providers.dart';
import '../notifier/notifier.dart';

class FeaturedContent extends ConsumerStatefulWidget {
  final int postsCount;

  const FeaturedContent({
    required this.postsCount,
    Key? key,
  }) : super(key: key);

  @override
  FeaturedContentState createState() => FeaturedContentState();
}

class FeaturedContentState extends ConsumerState<FeaturedContent> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () => ref.read(featuredContentProvider.notifier).fetchPage(
            postsCount: widget.postsCount,
          ),
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
    final HomeState state = ref.watch(featuredContentProvider);

    if (state is HomeLoading) {
      return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 10,
          viewportFraction: 1,
        ),
        items: const <Widget>[
          PostBoxLoading(),
        ],
      );
    } else if (state is HomeLoaded) {
      if (state.posts.isEmpty) {
        return ErrorIndicator(
          message: AppLocalizations.of(context).errorNoPosts,
          image: 'assets/img/no_data.png',
          onTryAgain: () {
            refresh(forceRefresh: true);
          },
        );
      } else {
        return CarouselSlider.builder(
          itemCount: state.posts.length,
          options: CarouselOptions(
            aspectRatio: 16 / 10,
            enableInfiniteScroll: true,
            viewportFraction: 1,
            autoPlay: true,
          ),
          itemBuilder: (context, index, tag) {
            return PostBox(
              post: state.posts[index],
              onTap: () {
                context.push('/posts/${state.posts[index].slug}');
              },
            );
          },
        );
      }
    } else if (state is HomeException) {
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
  }
}
