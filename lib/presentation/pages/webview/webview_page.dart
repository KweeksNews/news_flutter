// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../../providers.dart';

class WebviewPage extends ConsumerStatefulWidget {
  final String title;
  final String url;
  final String? javascript;

  const WebviewPage({
    super.key,
    required this.title,
    required this.url,
    this.javascript,
  });

  @override
  ConsumerState<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends ConsumerState<WebviewPage> {
  late PullToRefreshController _pullToRefreshController;
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();

    _pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        await _webViewController?.reload();
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
          child: Builder(
            builder: (context) {
              final double loadingProgressState =
                  ref.watch(loadingProgressProvider);

              if (loadingProgressState < 1.0) {
                return LinearProgressIndicator(
                  value: loadingProgressState,
                );
              } else {
                return const Nil();
              }
            },
          ),
        ),
      ),
      body: InAppWebView(
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
        pullToRefreshController: _pullToRefreshController,
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        androidOnPermissionRequest: (_, __, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
        onLoadStop: (controller, _) async {
          _pullToRefreshController.endRefreshing();

          if (widget.javascript != null) {
            await controller.evaluateJavascript(source: widget.javascript!);
          }
        },
        onLoadError: (_, __, ___, ____) {
          _pullToRefreshController.endRefreshing();
        },
        onProgressChanged: (_, progress) {
          if (progress == 100) {
            _pullToRefreshController.endRefreshing();
          }

          ref.read(loadingProgressProvider.notifier).set(
                progress: progress / 100,
              );
        },
      ),
    );
  }
}
