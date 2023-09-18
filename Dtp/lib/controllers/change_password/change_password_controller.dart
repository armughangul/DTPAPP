import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../s.dart';

class ChangePasswordController extends GetxController {
  final context = Get.context;

  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmNewPassword = TextEditingController();

  var oldPasswordFocus = FocusNode();
  var newPasswordFocus = FocusNode();
  var confirmNewPasswordFocus = FocusNode();

  var isUpdating = false.obs;

  void onCancelTap() {
    oldPassword.clear();
    newPassword.clear();
    confirmNewPassword.clear();
  }

  void onSaveTap() async {
    S.sFocusOut(context!);
    if (oldPassword.text.length < 8) {
      S.sSnackBar(
          message: 'password_should_be_contain_8_character'.tr,
          snackPosition: SnackPosition.BOTTOM);
      S.sFocusOut(context!, focusNode: oldPasswordFocus);
      return;
    }

    if (newPassword.text.length < 8) {
      S.sSnackBar(
          message: 'new_password_should_be_contain_8_character'.tr,
          snackPosition: SnackPosition.BOTTOM);
      S.sFocusOut(context!, focusNode: newPasswordFocus);
      return;
    }
    if (newPassword.text != confirmNewPassword.text) {
      S.sSnackBar(
          message: 'password_does\'t_match'.tr,
          snackPosition: SnackPosition.BOTTOM);
      S.sFocusOut(context!, focusNode: confirmNewPasswordFocus);
      return;
    }
    Map params = {
      'old_password': oldPassword.text,
      'new_password': newPassword.text,
      'new_password_confirmation': confirmNewPassword.text,
    };
    isUpdating(true);
    ViewResponse response =
        await HttpCalls.callPostApi(EndPoints.updatePassword, params);
    isUpdating(false);
    if (response.status) {
      S.sSnackBar(
        message: response.message,
      );
    } else {
      S.sSnackBar(
          message: response.message,
          isError: true,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
