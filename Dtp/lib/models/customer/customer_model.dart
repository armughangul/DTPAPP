List<CustomerModel> customerModelFromJson(str) =>
    List<CustomerModel>.from(str.map((x) => CustomerModel.fromJson(x)));

class CustomerModel {
  CustomerModel({
    this.id,
    this.customerCode,
    this.salePersonId,
    this.nameEnglish,
    this.nameThai,
    this.registrationNo,
    this.buildingName,
    this.streetNumber1,
    this.streetNumber2,
    this.subDistrict,
    this.district,
    this.province,
    this.postalCode,
    this.country,
    this.contactPerson,
    this.faxNumber,
    this.mobileNumber,
    this.lineId,
    this.remarks,
    this.document,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  });

  int? id;
  String? customerCode;
  String? salePersonId;
  String? nameEnglish;
  String? nameThai;
  String? registrationNo;
  String? buildingName;
  String? streetNumber1;
  String? streetNumber2;
  String? subDistrict;
  String? district;
  String? province;
  String? postalCode;
  String? country;
  String? contactPerson;
  String? faxNumber;
  String? mobileNumber;
  String? lineId;
  String? remarks;
  String? document;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isActive;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"] == null ? null : json["id"],
        customerCode: json["customer_code"],
        salePersonId:
            json["sale_person_id"] == null ? null : json["sale_person_id"],
        nameEnglish: json["name_english"] == null ? null : json["name_english"],
        nameThai: json["name_thai"] == null ? null : json["name_thai"],
        registrationNo:
            json["registration_no"] == null ? null : json["registration_no"],
        buildingName:
            json["building_name"] == null ? null : json["building_name"],
        streetNumber1:
            json["street_number_1"] == null ? null : json["street_number_1"],
        streetNumber2:
            json["street_number_2"] == null ? null : json["street_number_2"],
        subDistrict: json["sub_district"] == null ? null : json["sub_district"],
        district: json["district"] == null ? null : json["district"],
        province: json["province"] == null ? null : json["province"],
        postalCode: json["postal_code"] == null ? null : json["postal_code"],
        country: json["country"] == null ? null : json["country"],
        contactPerson:
            json["contact_person"] == null ? null : json["contact_person"],
        faxNumber: json["fax_number"] == null ? null : json["fax_number"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        lineId: json["line_id"] == null ? null : json["line_id"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        document: json["document"] == null ? null : json["document"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isActive: json["is_active"] == null ? null : json["is_active"],
      );
}
