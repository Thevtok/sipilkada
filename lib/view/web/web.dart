// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPage extends StatefulWidget {
  final String token;

  const WebPage({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();
        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text('Web',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.displayLarge),
          ),
          body: Stack(children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: WebUri(
                      "http://sipp2024.id/callback?token=${widget.token}")),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(),
              ),
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onWebViewCreated: (InAppWebViewController controller) {
                inAppWebViewController = controller;
              },
              onLoadStart: (InAppWebViewController controller, url) {},
              onLoadStop: (InAppWebViewController controller, url) {},
            ),
            _progress < 1
                ? LinearProgressIndicator(
                    value: _progress,
                  )
                : const SizedBox()
          ])),
    );
  }
}
