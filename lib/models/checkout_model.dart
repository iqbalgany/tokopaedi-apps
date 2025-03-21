class CheckoutModel {
  final String? code;
  final int? userId;
  final String? status;
  final int? totalPrice;
  final String? midtransPaymentUrl;
  final String? midtransSnapToken;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  CheckoutModel({
    this.code,
    this.userId,
    this.status,
    this.totalPrice,
    this.midtransPaymentUrl,
    this.midtransSnapToken,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        code: json["code"],
        userId: json["user_id"],
        status: json["status"],
        totalPrice: json["total_price"],
        midtransPaymentUrl: json["midtrans_payment_url"],
        midtransSnapToken: json["midtrans_snap_token"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "user_id": userId,
        "status": status,
        "total_price": totalPrice,
        "midtrans_payment_url": midtransPaymentUrl,
        "midtrans_snap_token": midtransSnapToken,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
