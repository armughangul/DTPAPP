import 'package:flutter/material.dart';
import 'action_dialog.dart';
import 'camera_gallery_dialog.dart';
import 'info_dialog.dart';
import 'internet_dialog.dart';

class Dialogs {
  static Future<bool?> showCameraDialog(BuildContext context,
      {dismissOnTap = true}) async {
    return showDialog(
      barrierDismissible: dismissOnTap,
      context: context,
      builder: (BuildContext context) {
        return CameraGalleryDialog();
      },
    );
  }

  static showInternetDialog(BuildContext context,
      {Function? onApplyTap}) async {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return InternetDialog();
      },
    );
  }

  static showInfoDialog(BuildContext context,
      {String title = 'Info', String body = ''}) async {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return InfoDialog(title, body);
      },
    );
  }

  static Future<bool?> showActionDialog(BuildContext context,
      {title = 'Action Required',
      String message = 'Are you sure to do it',
      String okayBtn = 'Okay',
      String cancelBtn = 'Cancel',
      double height = 240,
      TextAlign? textAlign}) async {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return ActionDialog(
          title: title,
          message: message,
          okayBtn: okayBtn,
          cancelBtn: cancelBtn,
          height: height,
          textAlign: textAlign,
        );
      },
    );
  }
}
