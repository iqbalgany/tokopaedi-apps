import 'package:grocery_store_app/models/product_model.dart';

class CartModel {
  final int? id;
  final int? productId;
  final int? userId;
  int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProductModel? product;

  CartModel({
    this.id,
    this.productId,
    this.userId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        quantity: json["quantity"],
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
        "product_id": productId,
        "user_id": userId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}
