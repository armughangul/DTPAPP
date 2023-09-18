import 'package:decisive_technology_products/controllers/change_password/change_password_controller.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        dispose: (val) => Get.delete<ChangePasswordController>(),
        builder: (_) {
          return Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: S.sBoxDecoration(
                        filledColor: Colors.white,
                        shadowColor: Colors.black.withOpacity(0.5),
                        shadowRadius: 10),
                    child: ListView(
                      children: [
                        TxtInput(
                          hintText: 'old_password*'.tr,
                          hasBorder: true,
                          maxLines: 1,
                          isPassword: true,
                          controller: _.oldPassword,
                          focusNode: _.oldPasswordFocus,
                          onEditingComplete: () => S.sFocusOut(context,
                              focusNode: _.newPasswordFocus),
                        ),
                        S.sDivider(),
                        TxtInput(
                          hintText: 'new_password*'.tr,
                          hasBorder: true,
                          maxLines: 1,
                          isPassword: true,
                          controller: _.newPassword,
                          focusNode: _.newPasswordFocus,
                          onEditingComplete: () => S.sFocusOut(context,
                              focusNode: _.confirmNewPasswordFocus),
                        ),
                        S.sDivider(),
                        TxtInput(
                          hintText: 'confirm_new_password*'.tr,
                          hasBorder: true,
                          maxLines: 1,
                          isPassword: true,
                          controller: _.confirmNewPassword,
                          focusNode: _.confirmNewPasswordFocus,
                          onEditingComplete: () => S.sFocusOut(context),
                        ),
                        S.sDivider(),
                      ],
                    ),
                  ),
                ),
                S.sDivider(),
                Row(
                  children: [
                    Expanded(
                        child: Btn(
                      'cancel'.tr,
                      onPressed: _.onCancelTap,
                      width: double.infinity,
                    )),
                    S.sVerticalDivider(),
                    Expanded(
                        child: _.isUpdating.isTrue
                            ? LoadingPro()
                            : Btn(
                                'save'.tr,
                                onPressed: _.onSaveTap,
                                width: double.infinity,
                                backgroundColor: Clr.colorPrimary,
                                textColor: Colors.white,
                              )),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
