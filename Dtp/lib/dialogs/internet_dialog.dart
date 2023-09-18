import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../s.dart';
import 'package:get/get.dart';

class InternetDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InternetDialogState();
}

class InternetDialogState extends State<InternetDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2500));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticOut);

    controller!.forward();
  }

  @override
  void dispose() {
    if (controller != null) controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => S.sFocusOut(context),
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Center(
            child: Container(
              height: 240,
              width: deviceWidth * 0.8,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: S.sBoxDecorationWithoutShadow(radius: 20),
              child: Column(
                children: <Widget>[
                  Txt(
                    'network_problem'.tr,
                    textColor: Clr.colorPrimary,
                    hasBold: true,
                  ),
                  S.sDivider(height: 8),
                  S.sDivider(height: 2, color: Clr.colorPrimary),
                  Expanded(
                    child: Center(
                        child: Txt(
                      'seems_like_internet_problem_please_check_your_wifi_or_mobile_data'
                          .tr,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  S.sDivider(height: 2, color: Clr.colorPrimary),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 35,
                      child: Center(
                          child: Txt(
                        'okay'.tr,
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
