import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebViewLab extends StatefulWidget {
  const WebViewLab({super.key});

  @override
  State<WebViewLab> createState() => _WebViewState();
}

class _WebViewState extends State<WebViewLab> {
  final PlatformWebViewController _controller = PlatformWebViewController(
    const PlatformWebViewControllerCreationParams(),
  )..loadRequest(
      LoadRequestParams(
        uri: Uri.parse('https://laboratorio.iedeoccidente.com'),
      ),
    );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visor Web'),
      ),
      body: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}
