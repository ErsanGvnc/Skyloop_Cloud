// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api, unnecessary_this, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Site extends StatefulWidget {
  String verilink;
  Site({
    required this.verilink,
  });
  @override
  _SiteState createState() => _SiteState();
}

class _SiteState extends State<Site> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _controller.reload();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: WebView(
        onWebViewCreated: (_controller) {
          this._controller = _controller;
        },
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: false,
        initialUrl: widget.verilink,
      ),
    );
  }
}
