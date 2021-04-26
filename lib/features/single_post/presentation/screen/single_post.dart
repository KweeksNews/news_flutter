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
import 'package:flutter_html/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/models/post_model.dart';
import '../../../../providers.dart';
import '../../../comments/presentation/screen/comments.dart';
import '../widgets/related_posts.dart';
import '../widgets/top_menu_button.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  final String heroId;

  const SinglePost({
    required this.post,
    required this.heroId,
    Key? key,
  }) : super(key: key);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  late YoutubePlayerController? _playerController;

  String get _postTitle {
    return HtmlUnescape().convert(widget.post.title);
  }

  @override
  void initState() {
    super.initState();
    if (widget.post.video.isNotEmpty) {
      _playerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.post.video)!,
        flags: const YoutubePlayerFlags(
          loop: true,
        ),
      );
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    if (widget.post.video.isNotEmpty) {
      _playerController!.pause();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.post.video.isNotEmpty) {
      _playerController!.dispose();
    }
  }

  Widget buildPostScreen({
    required BuildContext context,
    Widget? player,
  }) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardTheme.shadowColor!,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: TopMenuButton(
                    splashColor: Theme.of(context).cardTheme.shadowColor,
                    onTap: () => Navigator.of(context).pop(),
                    icon: Icons.arrow_back_ios_rounded,
                    iconColor: Theme.of(context).iconTheme.color,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardTheme.shadowColor!,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Consumer(
                        builder: (context, watch, child) {
                          final state = watch(savedPostProvider);

                          if (state) {
                            return TopMenuButton(
                              icon: Icons.bookmark_rounded,
                              iconColor: Theme.of(context).iconTheme.color,
                              splashColor:
                                  Theme.of(context).cardTheme.shadowColor,
                              onTap: () => context
                                  .read(savedPostProvider.notifier)
                                  .deletePost(
                                    widget.post.id,
                                  ),
                            );
                          } else {
                            return TopMenuButton(
                              icon: Icons.bookmark_border_rounded,
                              iconColor: Theme.of(context).iconTheme.color,
                              splashColor:
                                  Theme.of(context).cardTheme.shadowColor,
                              onTap: () => context
                                  .read(savedPostProvider.notifier)
                                  .createPost(PostModel(
                                    id: widget.post.id,
                                    title: widget.post.title,
                                    content: widget.post.content,
                                    image: widget.post.image,
                                    video: widget.post.video,
                                    author: widget.post.author,
                                    avatar: widget.post.avatar,
                                    category: widget.post.category,
                                    date: widget.post.date,
                                    link: widget.post.link,
                                    catId: widget.post.catId,
                                  )),
                            );
                          }
                        },
                      ),
                      TopMenuButton(
                        icon: Icons.share_rounded,
                        iconColor: Theme.of(context).iconTheme.color,
                        splashColor: Theme.of(context).cardTheme.shadowColor,
                        onTap: () => Share.share(
                          '$_postTitle\n${widget.post.link}',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          backgroundColor: Theme.of(context).buttonColor,
          splashColor: Theme.of(context).cardTheme.shadowColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Comments(postId: widget.post.id),
                fullscreenDialog: true,
              ),
            );
          },
          child: Icon(
            Icons.chat_bubble_rounded,
            size: 25,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardTheme.shadowColor!,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: widget.heroId,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: widget.post.video != ''
                          ? player
                          : FadeInImage(
                              placeholder:
                                  const AssetImage('assets/placeholder.png'),
                              image: NetworkImage(widget.post.image),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          _postTitle,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          widget.post.category,
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(widget.post.avatar),
                        ),
                        title: Text(
                          widget.post.author,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                        subtitle: Text(
                          widget.post.date,
                          style: Theme.of(context).primaryTextTheme.bodyText2,
                        ),
                      ),
                      Html(
                        data: widget.post.content,
                        onLinkTap: (url, _, __, ___) async {
                          if (await canLaunch(url!)) {
                            await launch(url);
                          } else {
                            throw "Couldn't launch $url";
                          }
                        },
                        style: {
                          '*': Style(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .fontFamily,
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
                          '.blocks-gallery-item': Style(
                            display: Display.BLOCK,
                          ),
                          '.has-text-align-right': Style(
                            direction: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            fontSize: FontSize.percent(150),
                            fontFamily: 'Amiri',
                            lineHeight: LineHeight.number(2),
                          ),
                        },
                      ),
                    ],
                  ),
                ),
                RelatedPosts(
                  postId: widget.post.id,
                  catId: widget.post.catId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post.video.isNotEmpty) {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _playerController!,
        ),
        builder: (context, player) => buildPostScreen(
          context: context,
          player: player,
        ),
      );
    } else {
      return buildPostScreen(
        context: context,
      );
    }
  }
}
