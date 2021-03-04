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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers.dart';
import '../widgets/identity_settings.dart';
import '../widgets/theme_settings.dart';

class Settings extends StatefulWidget {
  const Settings();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          flexibleSpace: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                  0,
                  MediaQuery.of(context).padding.top * 2,
                  0,
                  40,
                ),
                child: Image(
                  image: AssetImage(
                    Theme.of(context).canvasColor == const Color(0xFF000000)
                        ? 'assets/dark/icon.png'
                        : 'assets/light/icon.png',
                  ),
                  width: 270,
                ),
              ),
              Text(
                'Ikuti KweeksNews',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      splashColor: Theme.of(context).cardTheme.shadowColor,
                      iconSize: 25,
                      icon: const FaIcon(FontAwesomeIcons.instagram),
                      color: const Color(0xFFFFFFFF),
                      tooltip: 'Instagram',
                      onPressed: () async {
                        const url = 'https://www.instagram.com/kweeksnews/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw "Couldn't launch $url";
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      splashColor: Theme.of(context).cardTheme.shadowColor,
                      iconSize: 25,
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      color: const Color(0xFFFFFFFF),
                      tooltip: 'Facebook',
                      onPressed: () async {
                        const url = 'https://facebook.com/kweeksnews/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw "Couldn't launch $url";
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      splashColor: Theme.of(context).cardTheme.shadowColor,
                      iconSize: 25,
                      icon: const FaIcon(FontAwesomeIcons.twitter),
                      color: const Color(0xFFFFFFFF),
                      tooltip: 'Twitter',
                      onPressed: () async {
                        const url = 'https://twitter.com/kweeksnews/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw "Couldn't launch $url";
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      splashColor: Theme.of(context).cardTheme.shadowColor,
                      iconSize: 25,
                      icon: const FaIcon(FontAwesomeIcons.telegram),
                      color: const Color(0xFFFFFFFF),
                      tooltip: 'Telegram',
                      onPressed: () async {
                        const url = 'https://t.me/kweeksnews/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw "Couldn't launch $url";
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardTheme.shadowColor,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext dialogContext) {
                                return const IdentitySettingsDialog();
                              },
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 15),
                            leading: Padding(
                              padding: const EdgeInsets.all(8),
                              child: FaIcon(
                                FontAwesomeIcons.solidUserCircle,
                                size: 25,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            title: Text(
                              'Identitas',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            subtitle: Consumer(
                              builder: (context, watch, child) {
                                final Map<String, String> identity =
                                    watch(identityProvider.state);
                                final String name = identity['name'];
                                final String email = identity['email'];

                                return Text(
                                  name.isNotEmpty && email.isNotEmpty
                                      ? '$name ($email)'
                                      : 'Anda belum mengatur identitas',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6,
                                );
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext dialogContext) {
                                return const ThemeSettingsDialog();
                              },
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 15),
                            leading: Padding(
                              padding: const EdgeInsets.all(8),
                              child: FaIcon(
                                FontAwesomeIcons.adjust,
                                size: 25,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            title: Text(
                              'Tema aplikasi',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            subtitle: Text(
                              'Cerah, gelap, atau sesuai sistem',
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardTheme.shadowColor,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            const url = 'https://kweeksnews.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Tidak bisa membuka $url.';
                            }
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 15),
                            leading: Padding(
                              padding: const EdgeInsets.all(8),
                              child: FaIcon(
                                FontAwesomeIcons.globe,
                                size: 25,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            title: Text(
                              'Situs web',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            subtitle: Text(
                              'https://kweeksnews.com/',
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            const url = 'mailto:redaksi@kweeksnews.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Tidak bisa membuka $url.';
                            }
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 15),
                            leading: Padding(
                              padding: const EdgeInsets.all(8),
                              child: FaIcon(
                                FontAwesomeIcons.solidPaperPlane,
                                size: 25,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            title: Text(
                              'Hubungi kami',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            subtitle: Text(
                              'redaksi@kweeksnews.com',
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Share.share(
                              'Unduh aplikasi KweeksNews sekarang!\nhttps://go.kweeksnews.com/app-full',
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 15),
                            leading: Padding(
                              padding: const EdgeInsets.all(8),
                              child: FaIcon(
                                FontAwesomeIcons.shareAlt,
                                size: 25,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            title: Text(
                              'Bagikan',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            subtitle: Text(
                              'Ajak teman untuk mengunduh',
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
