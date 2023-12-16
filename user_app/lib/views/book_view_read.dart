import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfViewerScreen extends StatefulWidget {
  final String fileUrl;
  const PdfViewerScreen(this.fileUrl, {super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // late final PlatformWebViewControllerCreationParams params;
    // params = const PlatformWebViewControllerCreationParams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('PDF Viewer'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
