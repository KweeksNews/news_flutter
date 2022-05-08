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
  final PageController pageController;

  Lightbox({
    required this.lightboxItems,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
    this.backgroundDecoration,
    this.loadingBuilder,
    Key? key,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  @override
  _LightboxState createState() => _LightboxState();
}

class _LightboxState extends ConsumerState<Lightbox> {
  @override
  void initState() {
    super.initState();
  
    Future.delayed(
      Duration.zero,
      () {
        ref.read(lightboxProvider.notifier).setIndex(widget.initialIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('LightboxDismissible'),
      direction: DismissDirection.down,
      resizeDuration: Duration.zero,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              PhotoViewGallery.builder(
                itemCount: widget.lightboxItems.length,
                pageController: widget.pageController,
                scrollPhysics: const BouncingScrollPhysics(),
                scrollDirection: widget.scrollDirection,
                backgroundDecoration: widget.backgroundDecoration,
                onPageChanged: ref.read(lightboxProvider.notifier).setIndex,
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
                      tag: item['url']!,
                    ),
                  );
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final int index = ref.watch(lightboxProvider);
                  final String caption =
                      widget.lightboxItems[index]['caption']!;

                  if (caption.isNotEmpty) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: widget.backgroundDecoration?.color
                                ?.withAlpha(200) ??
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withAlpha(200),
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
        ),
      ),
    );
  }
}
