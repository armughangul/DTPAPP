import 'package:get/get.dart';

AuthModel authModelFromJson(str) => AuthModel.fromJson((str));

class AuthModel {
  AuthModel({
    this.token,
    this.user,
  });

  String? token;
  User? user;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"] == null ? null : json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class User extends GetxController {
  User({
    this.id = -1,
    this.name = "",
    this.thaiName,
    this.username,
    this.email = "",
    this.phone,
    this.emailVerifiedAt,
    this.roleId = "",
    this.createdAt,
    this.updatedAt,
    this.thaiIdNumber,
    this.salesId,
    this.buildingName,
    this.streetNumber1,
    this.streetNumber2,
    this.subDistrict,
    this.district,
    this.province,
    this.postalCode,
    this.lineId,
    this.bankName,
    this.bankBranch,
    this.bankAccount,
    this.bankBook,
    this.idCardFront,
    this.idCardBack,
    this.isActive = "",
    this.accountApproval = "",
    this.isProfileSubmitted = false,
  });

  int id;
  String name;
  dynamic thaiName;
  dynamic username;
  String email;
  dynamic phone;
  DateTime? emailVerifiedAt;
  String roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic thaiIdNumber;
  dynamic salesId;
  dynamic buildingName;
  dynamic streetNumber1;
  dynamic streetNumber2;
  dynamic subDistrict;
  dynamic district;
  dynamic province;
  dynamic postalCode;
  dynamic lineId;
  dynamic bankName;
  dynamic bankBranch;
  dynamic bankAccount;
  dynamic bankBook;
  dynamic idCardFront;
  dynamic idCardBack;
  String isActive;
  String accountApproval;
  bool isProfileSubmitted;
  var isMenuLock = false.obs;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        thaiName: json["thai_name"],
        username: json["username"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        roleId: json["role_id"] == null ? null : json["role_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        thaiIdNumber: json["thai_id_number"],
        salesId: json["sales_id"],
        buildingName: json["building_name"],
        streetNumber1: json["street_number_1"],
        streetNumber2: json["street_number_2"],
        subDistrict: json["sub_district"],
        district: json["district"],
        province: json["province"],
        postalCode: json["postal_code"],
        lineId: json["line_id"],
        bankName: json["bank_name"],
        bankBranch: json["bank_branch"],
        bankAccount: json["bank_account"],
        bankBook: json["bank_book"],
        idCardFront: json["id_card_front"],
        idCardBack: json["id_card_back"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        accountApproval:
            json["account_approval"] == null ? null : json["account_approval"],
        isProfileSubmitted: json["is_profile_submitted"] == null
            ? null
            : json["is_profile_submitted"],
      );
}
