import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/pages/auth/login_page.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../s.dart';

class SignUpController extends GetxController {
  final context = Get.context;
  var fullName = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

  var fullNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var phoneFocus = FocusNode();
  var passwordFocus = FocusNode();
  var confirmPasswordFocus = FocusNode();

  var isLoading = false.obs;
  void onLoginTap() {
    S.sSetRout(context!,
        page: () => LoginPage(), routeType: RouteType.PUSH_REPLACE);
  }

  void onRegisterTap() async {
    if (fullName.text.isEmpty) {
      S.sSnackBar(message: 'full_name_required!'.tr);
      S.sFocusOut(context!, focusNode: fullNameFocus);
      return;
    }
    if (email.text.isEmpty) {
      S.sSnackBar(message: 'email_required!'.tr);
      S.sFocusOut(context!, focusNode: emailFocus);
      return;
    }
    if (phone.text.isEmpty) {
      S.sSnackBar(message: 'phone_required!'.tr);
      S.sFocusOut(context!, focusNode: emailFocus);
      return;
    }
    if (password.text.length < 8) {
      S.sSnackBar(message: 'password_should_be_contain_8_character'.tr);
      S.sFocusOut(context!, focusNode: passwordFocus);
      return;
    }
    if (password.text != confirmPassword.text) {
      S.sSnackBar(message: 'password_does\'t_match'.tr);
      S.sFocusOut(context!, focusNode: passwordFocus);
      return;
    }

    Map params = {
      'name': fullName.text,
      'email': email.text,
      'password': password.text,
      'password_confirmation': password.text,
      'phone': phone.text,
    };
    isLoading(true);
    ViewResponse response =
        await HttpCalls.callPostApi(EndPoints.register, params);

    if (response.status) {
      S.sSnackBar(message: response.message);
      Future.delayed(3.seconds, () {
        S.sSetRout(context!, page: () => LoginPage());
        isLoading(false);
      });
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }
    isLoading(false);
  }

  void onForgotPasswordTap() {}
}
