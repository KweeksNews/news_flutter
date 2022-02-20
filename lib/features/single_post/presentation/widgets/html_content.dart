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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/router/route_action.dart';
import '../../../../providers.dart';
import '../../../lightbox/presentation/pages/lightbox.dart';

class HtmlContent extends ConsumerWidget {
  final String data;

  const HtmlContent({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Html(
      data: data,
      onLinkTap: (url, _, __, ___) async {
        if (await canLaunch(url!)) {
          await launch(url);
        } else {
          throw "Couldn't launch $url";
        }
      },
      style: {
        '*': Style(
          fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
        ),
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        'body *': Style(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        ),
        'h2': Style.fromTextStyle(
          Theme.of(context).textTheme.headline2!,
        ),
        'h3': Style.fromTextStyle(
          Theme.of(context).textTheme.headline3!,
        ),
        'h4': Style.fromTextStyle(
          Theme.of(context).textTheme.headline4!,
        ),
        'h5': Style.fromTextStyle(
          Theme.of(context).textTheme.headline5!,
        ),
        'h6': Style.fromTextStyle(
          Theme.of(context).textTheme.headline6!,
        ),
        'p': Style.fromTextStyle(
          Theme.of(context).textTheme.bodyText1!,
        ),
        'pre': Style.fromTextStyle(
          Theme.of(context).textTheme.bodyText2!,
        ),
        'blockquote': Style(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
        'blockquote p': Style(
          padding: EdgeInsets.zero,
        ),
        'blockquote cite': Style(
          fontWeight: FontWeight.w600,
        ),
        'figure': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        '.wp-block-image': Style(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        ),
        '.has-text-align-right': Style(
          direction: TextDirection.rtl,
          textAlign: TextAlign.right,
          fontSize: FontSize.percent(150),
          fontFamily: 'Amiri',
          lineHeight: LineHeight.number(2),
        ),
      },
      customRender: {
        'figure': (context, child) {
          if (context.tree.element!.className.contains('wp-block-gallery')) {
            final List<Map<String, String>> images =
                context.tree.element!.getElementsByTagName('li').map(
              (element) {
                return {
                  'url':
                      element.getElementsByTagName('img')[0].attributes['src']!,
                  'caption': element
                          .getElementsByTagName('figcaption')
                          .isNotEmpty
                      ? element.getElementsByTagName('figcaption')[0].innerHtml
                      : '',
                };
              },
            ).toList();
            final String carouselCaption = context.tree.element!
                    .getElementsByClassName('blocks-gallery-caption')
                    .isNotEmpty
                ? context.tree.element!
                    .getElementsByClassName('blocks-gallery-caption')[0]
                    .innerHtml
                : '';

            return Column(
              children: [
                CarouselSlider.builder(
                  itemCount: images.length,
                  options: CarouselOptions(
                    aspectRatio: 16 / 10,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  ),
                  itemBuilder: (context, index, tag) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {
                          ref.read(routeStateProvider).setCurrentRootAction(
                                RouteAction(
                                  state: RouteActionState.pushWidget,
                                  widget: Lightbox(
                                    lightboxItems: images,
                                    backgroundDecoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    initialIndex: index,
                                  ),
                                ),
                              );
                        },
                        child: Hero(
                          tag: images[index]['url'] as String,
                          child: CachedNetworkImage(
                            imageUrl: images[index]['url'] as String,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/placeholder.png',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (carouselCaption.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: Text(carouselCaption),
                  ),
              ],
            );
          } else if (context.tree.element!
              .getElementsByTagName('img')
              .isNotEmpty) {
            final String url = context.tree.element!
                .getElementsByTagName('img')[0]
                .attributes['src']!;
            final String caption = context.tree.element!
                    .getElementsByTagName('figcaption')
                    .isNotEmpty
                ? context.tree.element!
                    .getElementsByTagName('figcaption')[0]
                    .innerHtml
                : '';

            return Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      ref.read(routeStateProvider).setCurrentRootAction(
                            RouteAction(
                              state: RouteActionState.pushWidget,
                              widget: Lightbox(
                                lightboxItems: [
                                  {'url': url, 'caption': caption}
                                ],
                                backgroundDecoration: BoxDecoration(
                                  color: Theme.of(context.buildContext)
                                      .canvasColor,
                                ),
                              ),
                            ),
                          );
                    },
                    child: Hero(
                      tag: url,
                      child: CachedNetworkImage(
                        imageUrl: url,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/placeholder.png',
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (caption.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: Text(caption),
                  ),
              ],
            );
          } else {
            return child;
          }
        },
      },
    );
  }
}
