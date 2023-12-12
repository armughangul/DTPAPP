import 'dart:ui' show Color;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Clr {
  Clr._();

  static const Color colorTransparent = const Color(0x00000000);

  static const Color colorBlue = Color(0xFF272264);
  static const Color colorGreyBackground = Color(0xFFF4F6F9);
  static const Color colorGreyButton = Color(0xFFD8D7D7);
  static const Color colorRed = Color(0xFFFF0000);
  static const Color colorRedPrimary = Color(0xFFed1c24);
  static const Color colorGreen = Color(0xFF0BB116);
  static const Color colorPrimary = colorRedPrimary;
  static const Color colorSecondary = Color(0xFF933086);
}

class Siz {
  Siz._();
  static const double h0 = 100.0;
  static const double h1 = 40.0;
  static const double h2 = 25.0;
  static const double h3 = 20.0;
  static const double h4 = 17.0;
  static const double h5 = 14.0;
  static const double h6 = 12.0;
  static const double h7 = 10.0;
  static const double h8 = 8.0;
  static const double fieldPrefixSize = 30;
  static const double fieldRadius = 8.0;
  static const double imageRadius = 20.0;
  static const double btnRadius = 20.0;
  static const double standardPadding = 16.0;
  static const double standardMargin = 16.0;
  static const double leadingImageSize = 100;
}

class Str {
  static String error = 'Error';
  static String success = 'Succcess';
  static String noDataFound = "There is no data found.";
  static const String NA = "N/A";
  static String statusSuccess = '000';

  static var mobileVerification = 'Mobile Number Verification';

  static var mobileVerificationBody =
      'A verification will be sent your number. You can update the mobile number before this verification. ';

  static var mask500 =
      "####################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################";

  static var nameInValid = 'Valid characters \n A-Z a-z\n . , -';
  static var areaInValid = 'Valid characters are: \n A-Z a-z 0-9\n . , - #';

  static String swr(id) => 'Something went wrong \n error code $id';

  Str._();
}

class EndPoints {
  static String login = "login";
  static String me = "me";
  static String register = "register";
  static String resetPassword = "reset_password";
  static String forgetPassword = "forget_password";

  static String customers = 'customers';
  static String customersUpdate = 'customers/update';

  static String create = 'orders/create';

  static String order = 'orders';
  static String orderUpdate = 'orders/update';
  static String orderUpdateStatus = 'orders/update_status';
  static String updatePassword = 'profile/update_password';
  static String profile = 'profile';

  static String messages = 'messages';
  static String getPayments = 'orders/get_payments/';
  static String delete = "deleteAccount";

  EndPoints._();
}
