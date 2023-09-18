import 'package:decisive_technology_products/controllers/auth/reset_password_controller.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return Material(
      color: Clr.colorPrimary,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Txt(
              'forgot_your_password?'.tr,
              textColor: Colors.white,
              hasBold: true,
              size: Siz.h2,
            ),
            S.sDivider(height: 32),
            Txt(
              'keep_calm,_enter_the_email_address\nassociated_with_your_account.'
                  .tr,
              textColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            S.sDivider(height: 32),
            TxtInput(
              hintText: 'email'.tr,
              filledColor: Colors.white,
              controller: controller.email,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: () => S.sFocusOut(context),
              marginHorizontal: 32,
              enabled: !controller.isLinkSend.value,
            ),
            S.sDivider(),
            controller.isLinkSend.isTrue
                ? Column(
                    children: [
                      TxtInput(
                        hintText: 'code'.tr,
                        filledColor: Colors.white,
                        controller: controller.code,
                        maxLines: 1,
                        isPassword: true,
                        onEditingComplete: () => S.sFocusOut(context),
                        marginHorizontal: 32,
                      ),
                      S.sDivider(),
                      TxtInput(
                        hintText: 'new_password'.tr,
                        filledColor: Colors.white,
                        controller: controller.password,
                        maxLines: 1,
                        isPassword: true,
                        onEditingComplete: () => S.sFocusOut(context),
                        marginHorizontal: 32,
                      ),
                      S.sDivider(),
                    ],
                  )
                : Container(),
            Obx(
              () => controller.isLoading.isTrue
                  ? LoadingPro(valueColor: Colors.white)
                  : Btn(
                      controller.isLinkSend.isTrue
                          ? 'set_password'.tr
                          : 'send_reset_link'.tr,
                      textColor: Colors.white,
                      backgroundColor: Colors.black,
                      onPressed: controller.onSendLink,
                      width: double.infinity,
                      marginHorizontal: 32,
                      borderColor: Colors.black),
            ),
            S.sDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Txt(
                  'recalled_your_login_info? '.tr,
                  textColor: Colors.white,
                ),
                GestureDetector(
                  child: Txt(
                    'sign_in'.tr,
                    hasUnderline: true,
                    textColor: Colors.white,
                  ),
                  onTap: Get.back,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
