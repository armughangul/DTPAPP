import 'package:decisive_technology_products/controllers/auth/signup_controller.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../s.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return GestureDetector(
      onTap: () => S.sFocusOut(context),
      child: Material(
        color: Clr.colorPrimary,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                S.sDivider(height: 50),
                Container(
                  height: 150,
                  child: Image.asset('assets/images/dtp_white.png'),
                ),
                S.sDivider(height: deviceHeight * 0.06),
                Txt(
                  'register'.tr,
                  textColor: Colors.white,
                  hasBold: true,
                  size: Siz.h1,
                ),
                S.sDivider(height: deviceHeight * 0.06),
                TxtInput(
                  hintText: 'full_name'.tr,
                  filledColor: Colors.white,
                  controller: controller.fullName,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  onEditingComplete: () =>
                      S.sFocusOut(context, focusNode: controller.emailFocus),
                ),
                S.sDivider(),
                TxtInput(
                  hintText: 'email'.tr,
                  filledColor: Colors.white,
                  controller: controller.email,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: controller.emailFocus,
                  onEditingComplete: () =>
                      S.sFocusOut(context, focusNode: controller.phoneFocus),
                ),
                S.sDivider(),
                TxtInput(
                  hintText: 'phone_number'.tr,
                  filledColor: Colors.white,
                  controller: controller.phone,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  focusNode: controller.phoneFocus,
                  onEditingComplete: () =>
                      S.sFocusOut(context, focusNode: controller.passwordFocus),
                ),
                S.sDivider(),
                TxtInput(
                  hintText: 'password'.tr,
                  filledColor: Colors.white,
                  isPassword: true,
                  controller: controller.password,
                  focusNode: controller.passwordFocus,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () => S.sFocusOut(context,
                      focusNode: controller.confirmPasswordFocus),
                ),
                S.sDivider(),
                TxtInput(
                  hintText: 'confirm_password'.tr,
                  filledColor: Colors.white,
                  isPassword: true,
                  controller: controller.confirmPassword,
                  focusNode: controller.confirmPasswordFocus,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: controller.onRegisterTap,
                ),
                S.sDivider(),
                Obx(
                  () => controller.isLoading.isTrue
                      ? LoadingPro(valueColor: Colors.white)
                      : Btn('register'.tr,
                          onPressed: controller.onRegisterTap,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          borderColor: Colors.black),
                ),
                S.sDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Txt(
                      'already_have_an_account_? '.tr,
                      textColor: Colors.white,
                    ),
                    GestureDetector(
                      child: Txt(
                        'sign_in'.tr,
                        hasUnderline: true,
                        textColor: Colors.white,
                      ),
                      onTap: controller.onLoginTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
