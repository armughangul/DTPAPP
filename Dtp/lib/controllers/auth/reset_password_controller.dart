import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../s.dart';

class ResetPasswordController extends GetxController{
  var email = TextEditingController();

  var isLinkSend = false.obs;

  var code = TextEditingController();
  var password = TextEditingController();

  var isLoading = false.obs;

  void onSendLink() async{

    if(email.text.isEmpty){
      S.sSnackBar(message: 'email_required'.tr);
      return;
    }
     
    if(isLinkSend.value){
      if(code.text.isEmpty){
        S.sSnackBar(message: 'code_required'.tr);
        return;
      }
      if(password.text.length < 8){
        S.sSnackBar(message: 'password_should_contain_8_character'.tr);
        return;
      }
      Map params = {
        'email': email.text,
        'password_reset_code': code.text,
        'new_password': password.text,
        'new_password_confirmation': password.text,
      };
      isLoading(true);
      ViewResponse response = await HttpCalls.callPostApi(EndPoints.resetPassword, params, hasAuth: false);
      isLoading(false);
      if(response.status){
        Get.back();
        S.sSnackBar(message: response.message, isError: true);
      }else{
        S.sSnackBar(message: response.message, isError: true);
      }
      
    }else{
      Map params = {
        'email': email.text,
      };

      isLoading(true);
      ViewResponse response = await HttpCalls.callPostApi(EndPoints.forgetPassword, params,  hasAuth: false);
      isLoading(false);
      if(response.status){
        isLinkSend(true);
      }else{
        S.sSnackBar(message: response.message, isError: true);
      }
    }


    isLinkSend(true);

  }
}