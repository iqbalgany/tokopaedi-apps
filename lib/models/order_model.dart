import 'package:grocery_store_app/models/order_item_model.dart';

class OrderModel {
  final int? id;
  final String? code;
  final int? userId;
  final int? totalPrice;
  final String? status;
  final dynamic midtransPaymentType;
  final String? midtransPaymentUrl;
  final String? midtransSnapToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OrderItemModel>? orderItems;

  OrderModel({
    this.id,
    this.code,
    this.userId,
    this.totalPrice,
    this.status,
    this.midtransPaymentType,
    this.midtransPaymentUrl,
    this.midtransSnapToken,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        code: json["code"],
        userId: json["user_id"],
        totalPrice: json["total_price"],
        status: json["status"],
        midtransPaymentType: json["midtrans_payment_type"],
        midtransPaymentUrl: json["midtrans_payment_url"],
        midtransSnapToken: json["midtrans_snap_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItemModel>.from(
                json["order_items"]!.map(
                  (x) => OrderItemModel.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "user_id": userId,
        "total_price": totalPrice,
        "status": status,
        "midtrans_payment_type": midtransPaymentType,
        "midtrans_payment_url": midtransPaymentUrl,
        "midtrans_snap_token": midtransSnapToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}
