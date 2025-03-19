import 'package:flutter/material.dart';
import 'package:grocery_store_app/constants/app_routes.dart';
import 'package:grocery_store_app/model/order_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final OrderModel? order;
  const WebViewScreen({
    super.key,
    this.order,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller =
        WebViewController() // ✅ Isi variabel instance, bukan buat variabel baru
          ..setJavaScriptMode(JavaScriptMode.unrestricted);

    controller.loadRequest(Uri.parse(widget.order!.midtransPaymentUrl!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.navbar),
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
