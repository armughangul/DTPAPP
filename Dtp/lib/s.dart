import 'dart:convert';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:decisive_technology_products/controllers/auth/login_controller.dart';
import 'package:decisive_technology_products/controllers/dashboard/dashboard_controller.dart';
import 'package:decisive_technology_products/splash.dart';
import 'package:decisive_technology_products/utils/pref.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'models/auth/auth_model.dart';
import 'main.dart';

enum ConfirmAction { CANCEL, ACCEPT }

enum URLType { CALL, SMS, WEB, EMAIL }

enum RouteType { PUSH, PUSH_REPLACE, PUSH_REMOVE_UNTIL, PUSH_REPLACE_ALL }

class S {
  static FlutterErrorDetails? sOnErrorMessage;
  static int sTimeout = 300;
  static dynamic sTappedId;
  static const int sSnackBarDurationInSec = 5;

  //Info: Time Formats
  static final String sGetTime12 = 'hh:mm:ss a';
  static final String sGetTime24 = 'HH:mm:ss';
  static final String sGetTime24WithOutSec = 'HH:mm';
  static final String sGetTime12WithOutSec = 'hh:mm a';
  static final String sGetTimeWithSec = 'hh:mm:ss a';
  static final String sGetDate = 'dd-MMM-yyyy';
  static final String sGetDay = 'dddd';
  static final String sGetDateFullMonth = 'dd-MMMM-yyyy';
  static final String sGetMonthAndDate = 'MMM dd';
  static final String sGetMonthDayAndTime = 'MMM dd, hh:mm a';
  static final String sGetMonthDayAndTimeForDifference = 'dd-MM-yyyy, hh:mm a';

  static AuthModel? sObjLogin;
  //Info: Time Formats

  static GlobalKey<ScaffoldState>? sKey;
  static double opacity = 0.3;

  static int sResendInterval = 60;

  static _clearAllData() async {
    await Pref.prefs!.clear();
  }

  static sTopPng() {
    return Column(
      children: [
        Container(
          height: 20,
        ),
        Container(
          width: deviceWidth,
          height: 150,
          child: Container(
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                width: 126,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static AppBar sGetAppbar(title, BuildContext context,
      {List<Widget>? actions,
      isLeadingShow = true,
      VoidCallback? onLeadingTap}) {
    return AppBar(
      backgroundColor: Clr.colorPrimary,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: isLeadingShow
          ? IconButton(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(
                  'assets/icons/7.png',
                  color: Colors.white,
                ),
              ),
              onPressed: onLeadingTap == null
                  ? () => Navigator.of(context).pop()
                  : onLeadingTap,
            )
          : IgnorePointer(child: Container()),
      actions: actions == null
          ? [
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              S.sVerticalDivider(),
            ]
          : actions,
    );
  }

  static DateFormat sDateFormatter() {
    return new DateFormat(S.sGetDate);
  }

  static DateFormat sDateTimeFormatter() {
    // return new DateFormat('dd-MM-yyyy HH:mm:ss');
    return new DateFormat('dd-MM-yyyy HH:mm');
  }

  static DateFormat sDateFormatterForSend() {
    return new DateFormat('yyyy-MM-dd');
  }

  static String sDateToStringForSend(DateTime dateTime) {
    if (dateTime == null) return Str.NA;
    String formatted = S.sDateFormatterForSend().format(dateTime);
//    print(formatted); // something like 2013-04-20
    return formatted;
  }

  static String sDateToString(DateTime? dateTime) {
    try {
      if (dateTime == null) return Str.NA;
      String formatted = S.sDateFormatter().format(dateTime);
      return formatted;
    } catch (e) {
      print(e.toString());
      return '00-00-0000';
    }
  }

  static String sDateTimeToString(DateTime dateTime) {
    try {
      if (dateTime == null) return Str.NA;
      String formatted = S.sDateTimeFormatter().format(dateTime);
      return formatted;
    } catch (e) {
      print(e.toString());
      return '00-00-0000';
    }
  }

  static String sGetDateTimeCustomFormat(DateTime dateTime, String format) {
    try {
      if (dateTime == null) return Str.NA;
      String formatted = DateFormat(format).format(dateTime);
      return formatted;
    } catch (e) {
      print(e.toString());
      return '00-00-0000';
    }
  }

  static DateTime? sStringToDate(String date) {
    try {
      DateTime newDateTimeObj2 = DateTime.parse(date);
      return newDateTimeObj2;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Widget sDivider(
      {Color color = Clr.colorTransparent,
      double height = 16.0,
      double marginHorizontal = 0.0}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        child: Divider(color: color, height: height));
  }

  static sVerticalDivider(
      {Color color = Clr.colorTransparent,
      double width = 16.0,
      double height = 16.0}) {
    return Container(
        width: width,
        height: height,
        child: VerticalDivider(
          color: color,
          width: width,
          thickness: width,
        ));
  }

  static BoxDecoration sBoxDecorationNew(
      {Color? filledColor,
      bool hasBorder = true,
      Color borderColor = Clr.colorPrimary,
      double radius = Siz.fieldRadius,
      BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: filledColor,
      border: hasBorder ? Border.all(color: borderColor) : null,
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
    );
  }

  static BoxDecoration sBoxDecorationWithoutShadow(
      {Color? filledColor,
      Color? borderColor,
      double radius = 0.0,
      String image = '',
      isNetworkImage = false,
      fit: BoxFit.cover}) {
    if (image == '') {
      return BoxDecoration(
        color: filledColor,
        border: borderColor != null ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );
    } else {
      return BoxDecoration(
          color: filledColor,
          border: borderColor != null ? Border.all(color: borderColor) : null,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          image: DecorationImage(
              image: isNetworkImage
                  ? NetworkImage(image) as ImageProvider<Object>
                  : AssetImage(image),
              fit: fit));
    }
  }

  static BoxDecoration sBoxDecoration(
      {Color filledColor = Colors.white,
      bool hasBorder = false,
      Color borderColor = Clr.colorPrimary,
      double radius = Siz.fieldRadius,
      String image = '',
      Color shadowColor = Colors.white,
      double shadowRadius = 0,
      isNetworkImage = true,
      shadowOffset,
      fit: BoxFit.cover}) {
    if (shadowOffset == null) {
      shadowOffset = Offset(0.0, 0.0);
    }
    if (image == '') {
      return BoxDecoration(
        color: filledColor,
        border: hasBorder ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              blurRadius: shadowRadius,
              offset: shadowOffset),
        ],
      );
    } else {
      return BoxDecoration(
          color: filledColor,
          border: hasBorder ? Border.all(color: borderColor) : null,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                blurRadius: shadowRadius,
                offset: shadowOffset),
          ],
          image: DecorationImage(
              image: isNetworkImage
                  ? NetworkImage(image) as ImageProvider<Object>
                  : AssetImage(image),
              fit: fit));
    }
  }

  S.sSnackBar(
      {String title = 'Info',
      String message = '',
      Color colorText = Clr.colorPrimary,
      Color backgroundColor = Colors.white,
      bool isError = false,
      SnackPosition snackPosition = SnackPosition.TOP}) {
    Get.snackbar(
        isError ? 'Error'.toLowerCase().tr : title.toLowerCase().tr, message,
        colorText: isError ? Colors.white : colorText,
        backgroundColor: isError ? Colors.black : backgroundColor,
        borderColor: Colors.white,
        snackPosition: snackPosition,
        borderWidth: 2.0);
  }

  static Future<bool> sCheckInternet() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none ? false : true;
  }

  static sFocusOut(BuildContext context,
      {bool isHide = true, FocusNode? focusNode}) {
    FocusScope.of(context).requestFocus(focusNode ?? FocusNode());
    if (isHide) return;

    return SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static sLogout() async {
    await _clearAllData();
    Get.delete<LoginController>();
    Get.delete<DashboardController>();
    Get.offAll(() => SplashPage());
  }

  static Future<void> sLaunchURL(String action, BuildContext context,
      {URLType urlType = URLType.WEB}) async {
    if (action == Str.NA) {
      print("Invalid Content");
    } else {
      String url = '';
      String error = '';
      switch (urlType) {
        case URLType.CALL:
          url = 'tel:$action';
          error = 'Could not dail $action';
          break;
        case URLType.SMS:
          url = 'sms:$action';
          error = 'Could not sms on $action';
          break;
        case URLType.WEB:
          url = action;
          error = 'Could not open $action';
          break;
        case URLType.EMAIL:
          url = 'mailto:$action';
          error = 'Could not send an email on $action';
          break;
      }

      await launch(url);
    }
  }

  static Widget sDropDownButton(
      String labelHint,
      String hintText,
      List<DropdownMenuItem<int>> listDropDown,
      int? selectedValue,
      Function(int val) onChange,
      {bool isExpanded = true,
      double paddingHorizontal = 16.0,
      bool enabled = true,
      FocusNode? focusNode,
      bool hasBorder = true}) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        margin: EdgeInsets.only(bottom: 0),
        decoration: S.sBoxDecorationNew(
          hasBorder: hasBorder,
          borderColor: Clr.colorPrimary,
          radius: Siz.fieldRadius,
        ),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: labelHint,
            border: null,
          ),
          focusNode: focusNode,
          isExpanded: true,
          value: selectedValue,
          items: listDropDown,
          onChanged: (v) {
            onChange(v as int);
          },
        ),
      ),
    );
  }

  static sSetRout(BuildContext context,
      {@required dynamic page,
      RouteType routeType = RouteType.PUSH,
      bool fullscreenDialog = false}) async {
    S.sFocusOut(context);
    switch (routeType) {
      case RouteType.PUSH:
        // return Navigator.push(context, MaterialPageRoute(builder: (context)=> page, fullscreenDialog: fullscreenDialog));
        return Get.to(page, fullscreenDialog: fullscreenDialog);
      case RouteType.PUSH_REPLACE:
        return Get.off(page, fullscreenDialog: fullscreenDialog);
      case RouteType.PUSH_REPLACE_ALL:
        return Get.offAll(page, fullscreenDialog: fullscreenDialog);
      // return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page, fullscreenDialog: fullscreenDialog));
      case RouteType.PUSH_REMOVE_UNTIL:
        return Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => page), (route) => false);
      // return Get.offUntil(MaterialPageRoute(builder: (context)=> page), (route) => false);
    }
  }

  static Uint8List sBase64ToImageDecode(String source) => base64.decode(source);

  static void sOnLanguageChange(int value) {
    var locale;
    if (value == 0) {
      locale = Locale('en', 'US');
    } else {
      locale = Locale('th', 'th');
    }
    Get.updateLocale(locale);
    Pref.setPrefInt(Pref.language, value);
  }
}
