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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../providers.dart';

class Lightbox extends ConsumerStatefulWidget {
  final List<Map<String, String>> lightboxItems;
  final int initialIndex;
  final Axis scrollDirection;
  final BoxDecoration? backgroundDecoration;
  final LoadingBuilder? loadingBuilder;

  const Lightbox({
    super.key,
    required this.lightboxItems,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
    this.backgroundDecoration,
    this.loadingBuilder,
  });

  @override
  ConsumerState<Lightbox> createState() => _LightboxState();
}

class _LightboxState extends ConsumerState<Lightbox> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: widget.initialIndex,
    );

    Future.delayed(
      Duration.zero,
      () {
        ref.read(lightboxProvider.notifier).setIndex(
              index: widget.initialIndex,
            );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return DismissiblePage(
      direction: DismissiblePageDismissDirection.vertical,
      onDismissed: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PhotoViewGallery.builder(
            itemCount: widget.lightboxItems.length,
            pageController: _pageController,
            scrollPhysics: const BouncingScrollPhysics(),
            scrollDirection: widget.scrollDirection,
            backgroundDecoration: widget.backgroundDecoration,
            onPageChanged: (index) {
              ref.read(lightboxProvider.notifier).setIndex(
                    index: index,
                  );
            },
            loadingBuilder: widget.loadingBuilder,
            builder: (context, index) {
              final Map<String, String> item = widget.lightboxItems[index];
              return PhotoViewGalleryPageOptions(
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 1.5,
                imageProvider: CachedNetworkImageProvider(
                  item['url']!,
                ),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: index,
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              final int index = ref.watch(lightboxProvider);
              final String caption = widget.lightboxItems[index]['caption']!;

              if (caption.isNotEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: widget.backgroundDecoration?.color?.withAlpha(200) ??
                        Theme.of(context).colorScheme.background.withAlpha(200),
                  ),
                  child: Text(
                    caption,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
