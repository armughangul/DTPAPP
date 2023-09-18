import 'package:decisive_technology_products/controllers/dashboard/dashboard_controller.dart';
import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/auth/auth_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../s.dart';

class CreateSalesManController extends GetxController {
  final context = Get.context;
  var pageController = PageController();

  var isSaving = false.obs;

  // Page One
  var engName = TextEditingController();
  var thaiName = TextEditingController();
  var email = TextEditingController(text: S.sObjLogin!.user!.email);
  var phone = TextEditingController();
  var thaiIdNumber = TextEditingController();

  var engNameFocus = FocusNode();
  var thaiNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var phoneFocus = FocusNode();
  var thaiIdFocus = FocusNode();

  // Page Two
  var buildingName = TextEditingController();
  var streetNumber1 = TextEditingController();
  var streetNumber2 = TextEditingController();
  var subDistrict = TextEditingController();
  var district = TextEditingController();
  var province = TextEditingController();
  var postalCode = TextEditingController();
  var lineId = TextEditingController();

  var buildingNameFocus = FocusNode();
  var streetNumber1Focus = FocusNode();
  var streetNumber2Focus = FocusNode();
  var subDistrictFocus = FocusNode();
  var districtFocus = FocusNode();
  var provinceFocus = FocusNode();
  var postalCodeFocus = FocusNode();
  var lineIdFocus = FocusNode();

  // Page Three
  var bankName = TextEditingController();
  var bankBranch = TextEditingController();
  var bankAccount = TextEditingController();
  XFile? bankBook;

  var bankNameFocus = FocusNode();
  var bankBranchFocus = FocusNode();
  var bankAccountFocus = FocusNode();
  var bankBookFocus = FocusNode();

  // Page Four
  XFile? idCardFront;
  XFile? idCardBack;

  int val = kDebugMode ? 3 : 2;

  @override
  void onInit() {
    fillData();
    super.onInit();
  }

  fillData() {
    engName.text = S.sObjLogin!.user!.name;
    thaiName.text = S.sObjLogin!.user!.thaiName;
    phone.text = S.sObjLogin!.user!.phone;
    thaiIdNumber.text = S.sObjLogin!.user!.thaiIdNumber;
    buildingName.text = S.sObjLogin!.user!.buildingName;
    streetNumber1.text = S.sObjLogin!.user!.streetNumber1;
    streetNumber2.text = S.sObjLogin!.user!.streetNumber2;
    subDistrict.text = S.sObjLogin!.user!.subDistrict;
    district.text = S.sObjLogin!.user!.district;
    province.text = S.sObjLogin!.user!.province;
    postalCode.text = S.sObjLogin!.user!.postalCode;
    lineId.text = S.sObjLogin!.user!.lineId;
    bankName.text = S.sObjLogin!.user!.bankName;
    bankBranch.text = S.sObjLogin!.user!.bankBranch;
    bankAccount.text = S.sObjLogin!.user!.bankAccount;
  }

  void pageOneNext() {
    S.sFocusOut(context!);

    if (2 == val) {
      if (engName.text.isEmpty) {
        S.sSnackBar(
            message: 'english_name_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: engNameFocus);
        return;
      }

      if (thaiName.text.isEmpty) {
        S.sSnackBar(
            message: 'thai_name_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: thaiNameFocus);
        return;
      }

      if (email.text.isEmpty) {
        S.sSnackBar(
            message: 'email_required!'.tr, snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: emailFocus);
        return;
      }
      if (phone.text.isEmpty) {
        S.sSnackBar(
            message: 'phone_required!'.tr, snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: phoneFocus);
        return;
      }
      if (thaiIdNumber.text.isEmpty) {
        S.sSnackBar(
            message: 'thai_id_number_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: thaiIdFocus);
        return;
      }
    }

    pageController.nextPage(duration: 1.seconds, curve: Curves.ease);
  }

  void pageTwoNext() {
    if (2 == 3) {
      if (buildingName.text.isEmpty) {
        S.sSnackBar(
            message: 'building_name_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: buildingNameFocus);
        return;
      }

      if (streetNumber1.text.isEmpty) {
        S.sSnackBar(
            message: 'street_1_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: streetNumber1Focus);
        return;
      }

      if (streetNumber2.text.isEmpty) {
        S.sSnackBar(
            message: 'street_2_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: streetNumber2Focus);
        return;
      }

      if (subDistrict.text.isEmpty) {
        S.sSnackBar(
            message: 'sub_district_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: subDistrictFocus);
        return;
      }

      if (district.text.isEmpty) {
        S.sSnackBar(
            message: 'district_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: districtFocus);
        return;
      }

      if (province.text.isEmpty) {
        S.sSnackBar(
            message: 'street_1_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: provinceFocus);
        return;
      }

      if (postalCode.text.isEmpty) {
        S.sSnackBar(
            message: 'postal_code_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: postalCodeFocus);
        return;
      }

      if (streetNumber1.text.isEmpty) {
        S.sSnackBar(
            message: 'country_name_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: streetNumber1Focus);
        return;
      }
    }

    S.sFocusOut(context!);
    pageController.nextPage(duration: 1.seconds, curve: Curves.ease);
  }

  void pageBack() {
    S.sFocusOut(context!);
    pageController.previousPage(duration: 1.seconds, curve: Curves.ease);
  }

  void pageThreeSave() async {
    if (2 == val) {
      if (bankName.text.isEmpty) {
        S.sSnackBar(
            message: 'bank_name_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: bankNameFocus);
        return;
      }

      if (bankBranch.text.isEmpty) {
        S.sSnackBar(
            message: 'bank_branch_required!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!, focusNode: bankBranchFocus);
        return;
      }

      if (bankBook == null) {
        S.sSnackBar(
            message: 'Bank book photo required!',
            snackPosition: SnackPosition.BOTTOM);
        S.sFocusOut(context!);
        return;
      }
    }

    pageController.nextPage(duration: 1.seconds, curve: Curves.ease);
    return;
  }

  void onBankBookTap() async {
    bool? camera = await Dialogs.showCameraDialog(context!);
    if (camera == null) return;
    if (camera) {
      bankBook = await ImagePicker().pickImage(
          source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    } else {
      bankBook = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    }
    update();
  }

  void onIdCardFront() async {
    bool? camera = await Dialogs.showCameraDialog(context!);
    if (camera == null) return;
    if (camera) {
      idCardFront = await ImagePicker().pickImage(
          source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    } else {
      idCardFront = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    }
    update();
  }

  void onIdCardBack() async {
    bool? camera = await Dialogs.showCameraDialog(context!);
    if (camera == null) return;
    if (camera) {
      idCardBack = await ImagePicker().pickImage(
          source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    } else {
      idCardBack = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    }
    update();
  }

  void pageFourSave() async {
    Map<String, String> params = {
      'name': engName.text,
      'thai_name': thaiName.text,
      'phone': phone.text,
      'thai_id_number': thaiIdNumber.text,
      'building_name': buildingName.text,
      'street_number_1': streetNumber1.text,
      'street_number_2': streetNumber2.text,
      'sub_district': subDistrict.text,
      'district': district.text,
      'province': province.text,
      'postal_code': postalCode.text,
      'line_id': lineId.text,
      'bank_name': bankName.text,
      'bank_branch': bankBranch.text,
      'bank_account': bankAccount.text,
    };

    if (2 == val) {
      if (idCardFront == null) {
        S.sSnackBar(message: 'id_card_front_side_required'.tr);
        return;
      }
      if (idCardBack == null) {
        S.sSnackBar(message: 'id_card_back_side_required'.tr);
        return;
      }
    }

    Map<String, String> files = {
      'bank_book': bankBook!.path,
      'id_card_front': idCardFront!.path,
      'id_card_back': idCardBack!.path,
    };
    isSaving(true);
    ViewResponse response =
        await HttpCalls.uploadFile(EndPoints.profile, files, params: params);
    isSaving(false);
    if (response.status) {
      S.sObjLogin!.user!.isProfileSubmitted = true;
      S.sSnackBar(message: response.message);
      update();
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }
  }

  var isRefreshing = false.obs;
  void onRefreshCall() async {
    isRefreshing(true);
    ViewResponse response = await HttpCalls.callGetApi(EndPoints.me);
    if (response.status) {
      S.sObjLogin!.user = User.fromJson(response.data);
      if (S.sObjLogin!.user!.accountApproval == '0' &&
          S.sObjLogin!.user!.roleId == '2') {
        S.sObjLogin!.user!.isMenuLock(true);
      } else {
        S.sObjLogin!.user!.isMenuLock(false);
        Get.find<DashboardController>().onPageChange(1);
      }
      isRefreshing(false);
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }
  }
}
