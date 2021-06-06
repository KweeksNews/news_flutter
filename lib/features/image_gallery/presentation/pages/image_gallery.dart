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
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../providers.dart';

class ImageGallery extends StatefulWidget {
  final List<Map> galleryItems;
  final int initialIndex;
  final Axis scrollDirection;
  final BoxDecoration? backgroundDecoration;
  final LoadingBuilder? loadingBuilder;
  final PageController pageController;

  ImageGallery({
    required this.galleryItems,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
    this.backgroundDecoration,
    this.loadingBuilder,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        context
            .read(imageGalleryProvider.notifier)
            .setIndex(widget.initialIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PhotoViewGallery.builder(
              itemCount: widget.galleryItems.length,
              pageController: widget.pageController,
              scrollPhysics: const BouncingScrollPhysics(),
              scrollDirection: widget.scrollDirection,
              backgroundDecoration: widget.backgroundDecoration,
              onPageChanged:
                  context.read(imageGalleryProvider.notifier).setIndex,
              loadingBuilder: widget.loadingBuilder,
              builder: (context, index) {
                final Map item = widget.galleryItems[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(item['url'] as String),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 1.5,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: item['url'] as String),
                );
              },
            ),
            Consumer(
              builder: (context, watch, child) {
                final int index = watch(imageGalleryProvider);
                final String caption =
                    widget.galleryItems[index]['caption'] as String;

                if (caption.isNotEmpty) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
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
    );
  }
}
