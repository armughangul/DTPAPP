OrderMetaDataModel orderMetaDataModelFromJson(str) =>
    OrderMetaDataModel.fromJson(str);

class OrderMetaDataModel {
  OrderMetaDataModel({
    this.customers,
    this.products,
  });

  List<Customer>? customers;
  List<Product>? products;

  factory OrderMetaDataModel.fromJson(Map<String, dynamic> json) =>
      OrderMetaDataModel(
        customers: json["customers"] == null
            ? null
            : List<Customer>.from(
                json["customers"].map((x) => Customer.fromJson(x))),
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );
}

class Customer {
  Customer({
    this.id = -1,
    this.customerCode = "",
    this.nameEnglish = "",
  });

  int id;
  String customerCode;
  String nameEnglish;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        customerCode:
            json["customer_code"] == null ? "" : json["customer_code"],
        nameEnglish: json["name_english"] == null ? null : json["name_english"],
      );
}

class Product {
  Product({
    this.id = -1,
    this.productCode = "",
    this.productName = "",
    this.availableQty = 0,
    this.createdAt,
    this.updatedAt,
    this.image = "",
    this.brandId = -1,
  });

  int id;
  String productCode;
  String productName;
  int availableQty;
  DateTime? createdAt;
  DateTime? updatedAt;
  String image;
  int brandId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        productCode: json["product_code"] == null ? null : json["product_code"],
        productName: json["product_name"] == null ? null : json["product_name"],
        availableQty:
            json["available_qty"] == null ? null : json["available_qty"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        image: json["image"] == null ? null : json["image"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
      );
}
