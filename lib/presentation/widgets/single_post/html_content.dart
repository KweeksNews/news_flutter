// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/l10n.dart';
import 'lightbox.dart';

class HtmlContent extends ConsumerWidget {
  final String data;

  const HtmlContent({
    super.key,
    required this.data,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Html(
      data: data,
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
                AppLocalizations.of(context).errorCannotOpenUrl(url),
              ),
            ),
          );
        }
      },
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        'body *': Style(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.only(left: 15, right: 15),
        ),
        'h2': Style.fromTextStyle(
          Theme.of(context).textTheme.headline5!,
        ),
        'h3': Style.fromTextStyle(
          Theme.of(context).textTheme.headline6!,
        ),
        'h4': Style.fromTextStyle(
          Theme.of(context).textTheme.headline6!,
        ),
        'h5': Style.fromTextStyle(
          Theme.of(context).textTheme.headline6!,
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
          padding: const EdgeInsets.only(left: 30, right: 30),
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
          padding: const EdgeInsets.only(left: 15, right: 15),
        ),
        '.has-text-align-right': Style(
          direction: TextDirection.rtl,
          fontFamily: 'Amiri',
          textAlign: TextAlign.right,
          fontSize: FontSize.percent(150),
          lineHeight: LineHeight.number(2),
        ),
        '*': Style(
          fontFamily: 'Montserrat',
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
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  itemBuilder: (context, index, tag) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.pushTransparentRoute<dynamic>(
                            Lightbox(
                              lightboxItems: images,
                              initialIndex: tag,
                            ),
                          );
                        },
                        child: Hero(
                          tag: tag,
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
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.buildContext.pushTransparentRoute<dynamic>(
                          Lightbox(
                            lightboxItems: [
                              {
                                'url': url,
                                'caption': caption,
                              }
                            ],
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
