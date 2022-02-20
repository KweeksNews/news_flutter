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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/theme_settings.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Pengaturan',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
      ),
      body: ListView(
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
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(left: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.adjust,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Tema aplikasi',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'Cerah, gelap, atau sesuai sistem',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return const ThemeSettingsDialog();
                            },
                          );
                        },
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
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(left: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Kirim konten',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'Ubah dunia dengan karyamu!',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url =
                              'https://www.kweeksnews.com/kirim-konten/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.solidCommentDots,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Hubungi kami',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'redaksi@kweeksnews.com',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://www.kweeksnews.com/kontak/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.globe,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Situs web',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'https://www.kweeksnews.com/',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://www.kweeksnews.com/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
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
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.globe,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Situs web',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'https://muallimin.sch.id/',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://muallimin.sch.id/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.fileSignature,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Informasi PPDB',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'https://ppdb.muallimin.sch.id/',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () async {
                          const url = 'https://ppdb.muallimin.sch.id/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Tidak bisa membuka $url.';
                          }
                        },
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
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.infoCircle,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Tentang',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'Informasi mengenai KweeksNews',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () {
                          //TODO add "about" information
                        },
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.codeBranch,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Versi',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: FutureBuilder<String>(
                          future: PackageInfo.fromPlatform()
                              .then((PackageInfo packageInfo) {
                            final String version = packageInfo.version;
                            final String buildNumber = packageInfo.buildNumber;

                            return 'v$version+$buildNumber';
                          }),
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data! : 'Memuat...',
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            );
                          },
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.shareAlt,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        title: Text(
                          'Bagikan',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          'Ajak teman untuk mengunduh',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                        onTap: () {
                          Share.share(
                            'Unduh aplikasi KweeksNews sekarang!\nhttps://go.kweeksnews.com/app-full',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
