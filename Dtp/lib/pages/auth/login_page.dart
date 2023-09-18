import 'package:decisive_technology_products/controllers/auth/login_controller.dart';
import 'package:decisive_technology_products/main.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../s.dart';

class LoginPage extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GestureDetector(
      onTap: ()=> S.sFocusOut(context),
      child: Material(
        color: Clr.colorPrimary,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: ListView(
              children: [
                S.sDivider(height: setHeight(0.06)),
                Container(
                  height: 150,
                  child: Image.asset('assets/images/dtp_white.png'),
                ),
                S.sDivider(height: setHeight(0.04)),
                Txt('login'.tr, textColor: Colors.white,hasBold: true,size: Siz.h1,),
                S.sDivider(height: setHeight(0.04)),
                TxtInput(
                  hintText: 'email'.tr,
                  filledColor: Colors.white,
                  controller: controller.email,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: controller.emailFocus,
                  onEditingComplete: ()=> S.sFocusOut(context, focusNode: controller.passwordFocus),
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
                  onEditingComplete: controller.onLoginTap,
                ),
                Align(alignment: Alignment.topRight,
                  child: MaterialButton(
                    child: Txt('forgot_password?'.tr, textColor: Colors.white,),
                    onPressed: controller.onForgotPasswordTap,
                  ),
                ),
                S.sDivider(height: setHeight(0.06)),
                Obx(()=> controller.isLoading.isTrue?LoadingPro(valueColor: Colors.white,):Btn('login'.tr, backgroundColor: Colors.black, textColor: Colors.white,onPressed: controller.onLoginTap,borderColor: Colors.black),),
                S.sDivider(height: setHeight(0.06)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Txt('don\'t_have_an_account? '.tr, textColor: Colors.white,),
                    GestureDetector(
                      child: Txt('register'.tr, hasUnderline: true,textColor: Colors.white,),
                      onTap: controller.onRegisterTap,
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
