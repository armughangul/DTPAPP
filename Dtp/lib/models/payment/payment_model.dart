// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

List<PaymentModel> paymentModelFromJson(str) =>
    List<PaymentModel>.from(str.map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  PaymentModel({
    this.id,
    this.orderId,
    this.salesmenId,
    this.invoiceNo,
    this.transactionDate,
    this.amount,
    this.picture,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? orderId;
  String? salesmenId;
  dynamic invoiceNo;
  DateTime? transactionDate;
  String? amount;
  String? picture;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        salesmenId: json["salesmen_id"] == null ? null : json["salesmen_id"],
        invoiceNo: json["invoice_no"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        amount: json["amount"] == null ? null : json["amount"],
        picture: json["picture"] == null ? null : json["picture"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_id": orderId == null ? null : orderId,
        "salesmen_id": salesmenId == null ? null : salesmenId,
        "invoice_no": invoiceNo,
        "transaction_date":
            transactionDate == null ? null : transactionDate!.toIso8601String(),
        "amount": amount == null ? null : amount,
        "picture": picture == null ? null : picture,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
