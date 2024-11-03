import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScrollableWebViewPage extends StatefulWidget {
  const ScrollableWebViewPage({Key? key}) : super(key: key);

  @override
  State<ScrollableWebViewPage> createState() => _ScrollableWebViewPageState();
}

class _ScrollableWebViewPageState extends State<ScrollableWebViewPage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // 初始化WebView控制器
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://yianaux.top/'), // 替换为你的网址
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable Page with WebView'),
      ),
      body: SingleChildScrollView(
        // 使用SingleChildScrollView使整个页面可滚动
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '这是一个Container',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              // 给WebView一个固定高度
              height: 500,
              child: WebViewWidget(
                controller: _webViewController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}