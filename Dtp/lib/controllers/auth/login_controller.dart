import 'package:decisive_technology_products/models/auth/auth_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/pages/auth/reset_password.dart';
import 'package:decisive_technology_products/pages/auth/signup_page.dart';
import 'package:decisive_technology_products/pages/dashboard/dashboard_page.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/pref.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class LoginController extends GetxController {
  final context = Get.context;
  var email = TextEditingController();
  var password = TextEditingController();

  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();

  var isLoading = false.obs;

  void onRegisterTap() {
    S.sSetRout(context!,
        page: () => SignUpPage(), routeType: RouteType.PUSH_REPLACE);
  }

  Future<bool> onLoginTap() async {
    if (kDebugMode) {
      if (email.text.isEmpty) email.text = 'bilal.faith@gmail.com';
      // email.text = 'rizwansaleem70@gmail.com';
      if (password.text.isEmpty) password.text = '12345678';
    }
    if (email.text.isEmpty) {
      S.sSnackBar(
          message: 'email_required!'.tr,
          backgroundColor: Colors.white,
          colorText: Clr.colorPrimary);
      S.sFocusOut(context!, focusNode: emailFocus);
      return false;
    }

    if (password.text.isEmpty) {
      S.sSnackBar(
          message: 'password_required!'.tr,
          backgroundColor: Colors.white,
          colorText: Clr.colorPrimary);
      S.sFocusOut(context!, focusNode: passwordFocus);
      return false;
    }
    Map params = {'email': email.text, 'password': password.text};
    isLoading(true);
    ViewResponse response =
        await HttpCalls.callPostApi(EndPoints.login, params, hasAuth: false);

    if (response.status) {
      S.sObjLogin = authModelFromJson(response.data);
      print(S.sObjLogin!.token);
      Pref.setPrefString(Pref.userName, email.text);
      Pref.setPrefString(Pref.password, password.text);
      if (S.sObjLogin!.user!.accountApproval == '0' &&
          S.sObjLogin!.user!.roleId == '2') S.sObjLogin!.user!.isMenuLock(true);
      S.sSetRout(context!,
          page: DashboardPage(), routeType: RouteType.PUSH_REMOVE_UNTIL);
      isLoading(false);
      return true;
    } else {
      S.sSnackBar(message: response.message, isError: true);
      isLoading(false);
      return false;
    }
  }

  void onForgotPasswordTap() {
    S.sSetRout(context!, page: ResetPasswordPage());
  }
}
