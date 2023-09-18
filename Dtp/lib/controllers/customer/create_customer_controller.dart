import 'package:decisive_technology_products/controllers/dashboard/dashboard_controller.dart';
import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/customer/customer_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../s.dart';

class CreateCustomerController extends GetxController {
  final CustomerModel? customer;

  XFile? file;

  var isSaving = false.obs;
  CreateCustomerController({
    required this.customer,
  });
  final context = Get.context;
  var pageController = PageController();
  int val = kDebugMode ? 3 : 2;

  // Page One
  var engName = TextEditingController();
  var thaiName = TextEditingController();
  var registrationNumber = TextEditingController();

  var engNameFocus = FocusNode();
  var thaiNameFocus = FocusNode();
  var registrationFocus = FocusNode();

  // Page Two
  var buildingName = TextEditingController();
  var streetNumber1 = TextEditingController();
  var streetNumber2 = TextEditingController();
  var subDistrict = TextEditingController();
  var district = TextEditingController();
  var province = TextEditingController();
  var postalCode = TextEditingController();
  var country = TextEditingController();

  var buildingNameFocus = FocusNode();
  var streetNumber1Focus = FocusNode();
  var streetNumber2Focus = FocusNode();
  var subDistrictFocus = FocusNode();
  var districtFocus = FocusNode();
  var provinceFocus = FocusNode();
  var postalCodeFocus = FocusNode();
  var countryFocus = FocusNode();

  // Page Three
  var contactPerson = TextEditingController();
  var faxNumber = TextEditingController();
  var mobileNumber = TextEditingController();
  var lineId = TextEditingController();
  var remarks = TextEditingController();
  var document = TextEditingController();
  var attachment = TextEditingController();

  var phoneFocus = FocusNode();
  var contactPersonFocus = FocusNode();
  var faxNumberFocus = FocusNode();
  var mobileNumberFocus = FocusNode();
  var lineIdFocus = FocusNode();
  var remarksFocus = FocusNode();

  @override
  void onInit() {
    if (customer != null) callFillData();
    super.onInit();
  }

  void callFillData() {
    engName.text = customer?.nameEnglish ?? "";
    thaiName.text = customer?.nameThai ?? "";
    registrationNumber.text = customer?.registrationNo ?? "";
    buildingName.text = customer?.buildingName ?? "";
    streetNumber1.text = customer?.streetNumber1 ?? "";
    streetNumber2.text = customer?.streetNumber2 ?? "";
    subDistrict.text = customer?.subDistrict ?? "";
    district.text = customer?.district ?? "";
    province.text = customer?.province ?? "";
    postalCode.text = customer?.postalCode ?? "";
    country.text = customer?.country ?? "";
    contactPerson.text = customer?.contactPerson ?? "";
    mobileNumber.text = customer?.mobileNumber ?? "";
    faxNumber.text = customer?.faxNumber ?? "";
    lineId.text = customer?.lineId ?? "";
    remarks.text = customer?.remarks ?? "";
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

      // if(registrationNumber.text.isEmpty){
      //   S.sSnackBar(message: 'Registration required!', snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: registrationFocus);
      //   return;
      // }
    }

    pageController.nextPage(duration: 1.seconds, curve: Curves.ease);
  }

  void pageTwoNext() {
    if (2 == val) {
      // if (buildingName.text.isEmpty) {
      //   S.sSnackBar(message: 'building_name_required!'.tr,
      //       snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: buildingNameFocus);
      //   return;
      // }
      //
      // if (streetNumber1.text.isEmpty) {
      //   S.sSnackBar(
      //       message: 'street_1_required!'.tr, snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: streetNumber1Focus);
      //   return;
      // }
      //
      // if (streetNumber2.text.isEmpty) {
      //   S.sSnackBar(
      //       message: 'street_2_required!'.tr, snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: streetNumber2Focus);
      //   return;
      // }
      //
      // if (subDistrict.text.isEmpty) {
      //   S.sSnackBar(message: 'sub_district_required!'.tr,
      //       snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: subDistrictFocus);
      //   return;
      // }
      //
      // if (district.text.isEmpty) {
      //   S.sSnackBar(
      //       message: 'district_required!'.tr, snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: districtFocus);
      //   return;
      // }
      //
      // if (province.text.isEmpty) {
      //   S.sSnackBar(
      //       message: 'street_1_required!'.tr, snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: provinceFocus);
      //   return;
      // }
      //
      // if (postalCode.text.isEmpty) {
      //   S.sSnackBar(message: 'postal_code_required!'.tr,
      //       snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: postalCodeFocus);
      //   return;
      // }
      //
      // if (streetNumber1.text.isEmpty) {
      //   S.sSnackBar(message: 'country_name_required!'.tr,
      //       snackPosition: SnackPosition.BOTTOM);
      //   S.sFocusOut(context, focusNode: countryFocus);
      //   return;
      // }
    }

    S.sFocusOut(context!);
    pageController.nextPage(duration: 1.seconds, curve: Curves.ease);
  }

  void pageBack() {
    S.sFocusOut(context!);
    pageController.previousPage(duration: 1.seconds, curve: Curves.ease);
  }

  void pageThreeSave() async {
    // if(2 == val) {
    //
    //   if (contactPerson.text.isEmpty) {
    //     S.sSnackBar(
    //         message: 'contact_person_required!'.tr, snackPosition: SnackPosition.BOTTOM);
    //     S.sFocusOut(context, focusNode: contactPersonFocus);
    //     return;
    //   }
    //
    //   if (faxNumber.text.isEmpty) {
    //     S.sSnackBar(
    //         message: 'fax_number_required!'.tr, snackPosition: SnackPosition.BOTTOM);
    //     S.sFocusOut(context, focusNode: faxNumberFocus);
    //     return;
    //   }
    //
    //   if (mobileNumber.text.isEmpty) {
    //     S.sSnackBar(message: 'mobile_number_required!'.tr,
    //         snackPosition: SnackPosition.BOTTOM);
    //     S.sFocusOut(context, focusNode: mobileNumberFocus);
    //     return;
    //   }
    //
    //   if (lineId.text.isEmpty) {
    //     S.sSnackBar(
    //         message: 'line_id_required!'.tr, snackPosition: SnackPosition.BOTTOM);
    //     S.sFocusOut(context, focusNode: lineIdFocus);
    //     return;
    //   }
    //
    //   if (remarks.text.isEmpty) {
    //     S.sSnackBar(
    //         message: 'remarks_required!'.tr, snackPosition: SnackPosition.BOTTOM);
    //     S.sFocusOut(context, focusNode: remarksFocus);
    //     return;
    //   }
    //
    // }

    Map<String, String> params = {
      'name_english': engName.text,
      'name_thai': thaiName.text,
      'registration_no': registrationNumber.text,
      'building_name': buildingName.text,
      'street_number_1': streetNumber1.text,
      'street_number_2': streetNumber2.text,
      'sub_district': subDistrict.text,
      'district': district.text,
      'province': province.text,
      'postal_code': postalCode.text,
      'country': country.text,
      'contact_person': contactPerson.text,
      'fax_number': faxNumber.text,
      'mobile_number': mobileNumber.text,
      'line_id': lineId.text,
      'remarks': remarks.text
    };
    Map<String, String> files = {};
    if (file != null) {
      files = {
        'document': file!.path, //TODO
      };
    }

    isSaving(true);
    ViewResponse response = await HttpCalls.uploadFile(
        customer == null
            ? EndPoints.customers
            : EndPoints.customersUpdate + '/${customer?.id}',
        files,
        params: params);
    isSaving(false);
    if (response.status) {
      Get.put(DashboardController()).onPageChange(1);
      // Get.find<DashboardController>().onPageChange(1);
      Get.back();
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }
  }

  void onAttachmentTap() async {
    bool? result = await Dialogs.showCameraDialog(context!);
    if (result == null) return;
    if (result) {
      file = await ImagePicker().pickImage(source: ImageSource.camera);
      attachment.text = file!.name;
    } else {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      attachment.text = file!.name;
    }
  }
}
