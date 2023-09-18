OrderModel orderModelFromJson(str) => OrderModel.fromJson(str);

class OrderModel {
  OrderModel({
    this.orders,
    this.statuses,
  });

  List<Order>? orders;
  List<Status>? statuses;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orders: json["orders"] == null
            ? null
            : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        statuses: json["statuses"] == null
            ? null
            : List<Status>.from(
                json["statuses"].map((x) => Status.fromJson(x))),
      );
}

class Order {
  Order({
    this.id = -1,
    this.orderNo = "",
    this.uuid = "",
    this.salePersonId = -1,
    this.customerId = -1,
    this.orderDate,
    this.receipt = false,
    this.isVatInvoice = false,
    this.isCash = false,
    this.creditDays = -1,
    this.createdAt,
    this.updatedAt,
    this.netAmount = "",
    this.orderStatusId = -1,
    this.invoiceNo = "",
    this.invoiceDueDate,
    this.shippingDate,
    this.shipmentTrackingCode = "",
    this.comments = "",
    this.moneyReceived = "",
    this.invoicePicture = "",
    this.customer,
    this.seller,
    this.status,
    this.details,
  });

  int id;
  String orderNo;
  String uuid;
  int salePersonId;
  int customerId;
  DateTime? orderDate;
  bool receipt;
  bool isVatInvoice;
  bool isCash;
  int creditDays;
  DateTime? createdAt;
  DateTime? updatedAt;
  String netAmount;
  int orderStatusId;
  String invoiceNo;
  DateTime? invoiceDueDate;
  DateTime? shippingDate;
  String shipmentTrackingCode;
  String comments;
  String moneyReceived;
  String invoicePicture;
  Customer? customer;
  Seller? seller;
  Seller? status;
  List<Detail>? details;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? -1 : json["id"],
        orderNo: json["order_no"] == null ? "" : json["order_no"],
        uuid: json["uuid"] == null ? "" : json["uuid"],
        salePersonId:
            json["sale_person_id"] == null ? -1 : json["sale_person_id"],
        customerId: json["customer_id"] == null ? -1 : json["customer_id"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        receipt: json["receipt"] == null ? false : json["receipt"],
        isVatInvoice:
            json["is_vat_invoice"] == null ? false : json["is_vat_invoice"],
        isCash: json["is_cash"] == null ? false : json["is_cash"],
        creditDays: json["credit_days"] == null ? -1 : json["credit_days"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        netAmount: json["net_amount"] == null ? "" : json["net_amount"],
        orderStatusId:
            json["order_status_id"] == null ? -1 : json["order_status_id"],
        invoiceNo: json["invoice_no"] ?? "",
        invoiceDueDate: json["invoice_due_date"] == null
            ? null
            : DateTime.parse(json["invoice_due_date"]),
        shippingDate: json["shipping_date"] == null
            ? null
            : DateTime.parse(json["shipping_date"]),
        shipmentTrackingCode: json["shipment_tracking_code"] ?? "",
        comments: json["comments"] ?? "",
        moneyReceived:
            json["money_received"] == null ? "" : json["money_received"],
        invoicePicture: json["invoice_picture"] ?? "",
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        status: json["status"] == null ? null : Seller.fromJson(json["status"]),
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );
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
            json["customer_code"] == null ? "" : json["customer_code"],
        nameEnglish: json["name_english"] == "" ? null : json["name_english"],
        nameThai: json["name_thai"] == null ? "" : json["name_thai"],
      );
}

class Detail {
  Detail({
    this.id = -1,
    this.orderId = "",
    this.productId = "",
    this.qty = "",
    this.price = "",
    this.createdAt,
    this.updatedAt,
    this.subTotal = "",
    this.product,
  });

  int id;
  String orderId;
  String productId;
  String qty;
  String price;
  DateTime? createdAt;
  DateTime? updatedAt;
  String subTotal;
  Product? product;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] == null ? -1 : json["id"],
        orderId: json["order_id"] == null ? "" : json["order_id"],
        productId: json["product_id"] == null ? "" : json["product_id"],
        qty: json["qty"] == null ? "" : json["qty"],
        price: json["price"] == null ? "" : json["price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        subTotal: json["sub_total"] == null ? "" : json["sub_total"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );
}

class Product {
  Product({
    this.productName = "",
    this.image = "",
    this.id = -1,
  });

  String productName;
  String image;
  int id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productName: json["product_name"] == null ? "" : json["product_name"],
        image: json["image"] == null ? "" : json["image"],
        id: json["id"] == null ? -1 : json["id"],
      );
}

class Seller {
  Seller({
    this.id = -1,
    this.name = "",
    this.color = "",
  });

  int id;
  String name;
  String color;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"] == null ? -1 : json["id"],
        name: json["name"] == null ? "" : json["name"],
        color: json["color"] == null ? "" : json["color"],
      );
}

class Status {
  Status({
    this.id = -1,
    this.name = "",
    this.thaiName = "",
  });

  int id;
  String name;
  String thaiName;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        thaiName: json["thai_name"] == null ? null : json["thai_name"],
      );
}
