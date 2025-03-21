import 'package:flutter/material.dart';
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
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    final String? url = widget.order?.midtransPaymentUrl ?? widget.midtransUrl;
    if (url != null) {
      controller.loadRequest(Uri.parse(url));
    } else {
      debugPrint("Error: URL pembayaran tidak tersedia");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
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
        body: WebViewWidget(controller: controller));
  }
}
