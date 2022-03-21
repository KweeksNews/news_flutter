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
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../../providers.dart';

class Webview extends ConsumerStatefulWidget {
  final String title;
  final String url;
  final String? javascript;

  const Webview({
    required this.title,
    required this.url,
    this.javascript,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Webview> createState() => _WebviewState();
}

class _WebviewState extends ConsumerState<Webview> {
  late PullToRefreshController pullToRefreshController;
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        await webViewController?.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(
            double.infinity,
            1.0,
          ),
          child: Consumer(builder: (context, ref, child) {
            final double loadingProgressState =
                ref.watch(loadingProgressProvider);

            if (loadingProgressState < 1.0) {
              return LinearProgressIndicator(
                value: loadingProgressState,
              );
            } else {
              return const Nil();
            }
          }),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              key: GlobalKey(),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.url),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  mediaPlaybackRequiresUserGesture: false,
                ),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                ),
              ),
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              androidOnPermissionRequest: (_, __, resources) async {
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT,
                );
              },
              onLoadStop: (controller, _) async {
                pullToRefreshController.endRefreshing();

                if (widget.javascript != null) {
                  await controller.evaluateJavascript(
                      source: widget.javascript!);
                }
              },
              onLoadError: (_, __, ___, ____) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (_, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }

                ref.read(loadingProgressProvider.notifier).set(progress / 100);
              },
            ),
          ),
        ],
      ),
    );
  }
}
