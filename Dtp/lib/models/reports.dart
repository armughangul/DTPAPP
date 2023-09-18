// To parse this JSON data, do
//
//     final reportsModel = reportsModelFromJson(jsonString);

import 'dart:convert';

List<ReportsModel> reportsModelFromJson(str) =>
    List<ReportsModel>.from(str.map((x) => ReportsModel.fromJson(x)));

String reportsModelToJson(List<ReportsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportsModel {
  ReportsModel({
    this.id,
    this.orderId,
    this.salesmenId,
    this.invoiceNo,
    this.transactionDate,
    this.amount,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  int? id;
  String? orderId;
  String? salesmenId;
  String? invoiceNo;
  DateTime? transactionDate;
  String? amount;
  String? picture;
  DateTime? createdAt;
  DateTime? updatedAt;
  Order? order;

  factory ReportsModel.fromJson(Map<String, dynamic> json) => ReportsModel(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        salesmenId: json["salesmen_id"] == null ? null : json["salesmen_id"],
        invoiceNo: json["invoice_no"] == null ? null : json["invoice_no"],
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
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_id": orderId == null ? null : orderId,
        "salesmen_id": salesmenId == null ? null : salesmenId,
        "invoice_no": invoiceNo == null ? null : invoiceNo,
        "transaction_date":
            transactionDate == null ? null : transactionDate!.toIso8601String(),
        "amount": amount == null ? null : amount,
        "picture": picture == null ? null : picture,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "order": order == null ? null : order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.orderNo,
    this.netAmount,
    this.orderDate,
    this.customerId,
    this.customer,
  });

  int? id;
  String? orderNo;
  String? netAmount;
  DateTime? orderDate;
  int? customerId;
  Customer? customer;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        orderNo: json["order_no"] == null ? null : json["order_no"],
        netAmount: json["net_amount"] == null ? null : json["net_amount"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_no": orderNo == null ? null : orderNo,
        "net_amount": netAmount == null ? null : netAmount,
        "order_date": orderDate == null ? null : orderDate!.toIso8601String(),
        "customer_id": customerId == null ? null : customerId,
        "customer": customer == null ? null : customer!.toJson(),
      };
}

class Customer {
  Customer({
    this.id = -1,
    this.customerCode = "",
    this.nameEnglish = "",
    this.nameThai = "",
  });

  int id;
  String customerCode;
  String nameEnglish;
  String nameThai;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        customerCode:
            json["customer_code"] == null ? null : json["customer_code"],
        nameEnglish: json["name_english"] == null ? null : json["name_english"],
        nameThai: json["name_thai"] == null ? null : json["name_thai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customer_code": customerCode == null ? null : customerCode,
        "name_english": nameEnglish == null ? null : nameEnglish,
        "name_thai": nameThai == null ? null : nameThai,
      };
}
