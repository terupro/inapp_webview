import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_view/provider.dart';

class WebPage extends StatefulWidget {
  WebPage({Key? key}) : super(key: key);
  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  //　LinearProgressIndicator用
  double _progress = 0;
  // 表示するか否か
  InAppWebViewController? webview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('InApp Browser'),
      ),
      body: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final _provider = ref.watch(provider.notifier);
              return InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(_provider.state),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webview = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100; // 読み込み値を合わせる
                  });
                },
              );
            },
          ),
          _progress < 1 // LinearProgressIndicatorを表示する
              ? SizedBox(
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
