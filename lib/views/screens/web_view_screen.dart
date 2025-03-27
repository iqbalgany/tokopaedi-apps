import 'package:flutter/material.dart';
import 'package:grocery_store_app/constants/app_routes.dart';
import 'package:grocery_store_app/models/order_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final OrderModel? order;
  final String? midtransUrl;
  const WebViewScreen({
    super.key,
    this.order,
    this.midtransUrl,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _checkMidtransCallback(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (!_isMidtransSuccessUrl(request.url)) {
              Navigator.pushNamed(context, AppRoutes.navbar,
                  arguments: {'index': 1});
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    final String? url = widget.order?.midtransPaymentUrl ?? widget.midtransUrl;
    if (url != null) {
      controller.loadRequest(Uri.parse(url));
    } else {
      debugPrint("Error: URL pembayaran tidak tersedia");
    }
  }

  bool _isMidtransSuccessUrl(String url) {
    return url.contains('success');
  }

  bool hasNavigated = false;

  void _checkMidtransCallback(String url) {
    if (!hasNavigated) {
      hasNavigated = true;
      if (url.contains('finish') || url.contains('return')) {
        Navigator.pushNamed(context, AppRoutes.navbar, arguments: {'index': 1});
      } else if (_isMidtransSuccessUrl(url) &&
          !url.contains('finish') &&
          !url.contains('return')) {
        Future.delayed(
          const Duration(seconds: 5),
          () {
            if (!hasNavigated) {
              hasNavigated = true;
              Navigator.pushNamed(context, AppRoutes.navbar,
                  arguments: {'index': 1});
            }
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.navbar,
                arguments: {'index': 1});
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
