import 'package:grocery_store_app/models/product_model.dart';

class OrderItemModel {
  final int? id;
  final int? orderId;
  final int? productId;
  final int? quantity;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProductModel? product;

  OrderItemModel({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product: json["product"] == null
            ? null
            : ProductModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}
