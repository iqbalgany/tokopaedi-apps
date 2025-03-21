import 'package:flutter/material.dart';
import 'package:grocery_store_app/models/order_model.dart';
import 'package:grocery_store_app/services/order_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/checkout_model.dart';

class OrderController extends ChangeNotifier {
  final OrderService _orderService = OrderService();

  CheckoutModel? _checkout;
  bool _isLoading = false;
  List<OrderModel> _orders = [];
  String? _errorMessage;
  OrderModel? _order;

  CheckoutModel? get checkout => _checkout;
  bool get isLoading => _isLoading;
  List<OrderModel> get orders => _orders;
  String? get errorMessage => _errorMessage;
  OrderModel? get order => _order;

  Color getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return Colors.green[100]!;
      case 'pending':
        return Colors.blue[100]!;
      case 'cancelled':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> getOrder() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await _orderService.fetchOrder();
      debugPrint('Orders Fetched: $_orders');
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String?> checkoutOrder(BuildContext context, double totalPrice) async {
    _isLoading = true;
    notifyListeners();

    try {
      _checkout = await _orderService.checkoutOrder(totalPrice);
      await _orderService.fetchOrder();

      _isLoading = false;
      notifyListeners();

      return _checkout!.midtransPaymentUrl;
    } catch (e) {
      debugPrint('checkout Error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  Future<void> fetchOrders() async {
    try {
      _orders = await _orderService.fetchOrder();
      notifyListeners();
    } catch (e) {
      debugPrint('fetch Error: $e');
    }
  }

  Future<void> openMidtransPayment(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> fetchOrderDetail(int orderId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _orderService.getOrderDetail(orderId);
      _order = result;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch order detail : $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
