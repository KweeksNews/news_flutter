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
import 'package:kweeksnews_app/core/entities/post_content.dart';
import 'package:kweeksnews_app/core/widgets/error_indicator.dart';
import 'package:kweeksnews_app/features/single_post/presentation/notifier/single_post_state.dart';
import 'package:nil/nil.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/models/post_model.dart';
import '../../../../providers.dart';
import '../../../comments/presentation/screen/comments.dart';
import '../widgets/app_bar_button.dart';
import '../widgets/related_posts.dart';

class SinglePost extends StatefulWidget {
  final Post post;

  const SinglePost({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  late YoutubePlayerController? _playerController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        context.read(singlePostProvider.notifier).fetchPost(widget.post.id);
        context.read(savedPostProvider.notifier).checkPost(widget.post.id);
      },
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    if (widget.post.video) {
      _playerController!.pause();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.post.video) {
      _playerController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final SinglePostState state = watch(singlePostProvider);

        if (state is SinglePostLoading) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Row(
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
                        child: AppBarButton(
                          splashColor: Theme.of(context).cardTheme.shadowColor,
                          onTap: () => Navigator.of(context).pop(),
                          icon: Icons.arrow_back_ios_rounded,
                          iconColor: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          );
        } else if (state is SinglePostLoaded) {
          if (widget.post.video) {
            _playerController = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(state.post.video)!,
              flags: const YoutubePlayerFlags(
                loop: true,
              ),
            );
            return YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _playerController!,
              ),
              builder: (context, player) => buildContent(
                post: state.post,
                context: context,
                player: player,
              ),
            );
          } else {
            return buildContent(
              post: state.post,
              context: context,
            );
          }
        } else if (state is SinglePostError) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Row(
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
                        child: AppBarButton(
                          splashColor: Theme.of(context).cardTheme.shadowColor,
                          onTap: () => Navigator.of(context).pop(),
                          icon: Icons.arrow_back_ios_rounded,
                          iconColor: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: ErrorIndicator(
                message: state.message,
                image: 'assets/error.png',
                onTryAgain: () {
                  context
                      .read(singlePostProvider.notifier)
                      .fetchPost(widget.post.id);
                },
              ),
            ),
          );
        } else {
          return const Nil();
        }
      },
    );
  }

  Widget buildContent({
    required BuildContext context,
    required PostContent post,
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
                  child: AppBarButton(
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
                            return AppBarButton(
                              icon: Icons.bookmark_rounded,
                              iconColor: Theme.of(context).iconTheme.color,
                              splashColor:
                                  Theme.of(context).cardTheme.shadowColor,
                              onTap: () => context
                                  .read(savedPostProvider.notifier)
                                  .deletePost(
                                    post.id,
                                  ),
                            );
                          } else {
                            return AppBarButton(
                              icon: Icons.bookmark_border_rounded,
                              iconColor: Theme.of(context).iconTheme.color,
                              splashColor:
                                  Theme.of(context).cardTheme.shadowColor,
                              onTap: () => context
                                  .read(savedPostProvider.notifier)
                                  .createPost(PostModel(
                                    id: post.id,
                                    title: post.title,
                                    category: post.category,
                                    catId: post.catId,
                                    author: post.author,
                                    date: post.date,
                                    image: post.image,
                                    video: post.video != '',
                                  )),
                            );
                          }
                        },
                      ),
                      AppBarButton(
                        icon: Icons.share_rounded,
                        iconColor: Theme.of(context).iconTheme.color,
                        splashColor: Theme.of(context).cardTheme.shadowColor,
                        onTap: () => Share.share(
                          '${post.link}\n${post.link}',
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
                builder: (context) => Comments(postId: post.id),
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
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardTheme.shadowColor!,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: post.video != ''
                        ? player
                        : FadeInImage(
                            placeholder:
                                const AssetImage('assets/placeholder.png'),
                            image: NetworkImage(post.image),
                            fit: BoxFit.cover,
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
                          post.title,
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
                          post.category,
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(post.avatar),
                        ),
                        title: Text(
                          post.author,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                        subtitle: Text(
                          post.date,
                          style: Theme.of(context).primaryTextTheme.bodyText2,
                        ),
                      ),
                      Html(
                        data: post.content,
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
                  postId: post.id,
                  catId: post.catId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
