import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../s.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ActionDialog extends StatefulWidget {
  final String? title, message, okayBtn, cancelBtn;
  final double height;
  TextAlign? textAlign;
  ActionDialog(
      {this.title,
      this.message,
      this.okayBtn,
      this.cancelBtn,
      this.height = 240,
      this.textAlign});
  @override
  State<StatefulWidget> createState() => ActionDialogState();
}

class ActionDialogState extends State<ActionDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.textAlign == null) widget.textAlign = TextAlign.center;
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
              width: deviceWidth * 0.8,
              padding: EdgeInsets.all(24),
              decoration: S.sBoxDecorationWithoutShadow(
                radius: 20.0,
                filledColor: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Txt(
                    '${widget.title}',
                    hasBold: true,
                    size: Siz.h2,
                  ),
                  S.sDivider(),
                  Txt('${widget.message}'),
                  S.sDivider(),
                  Row(
                    children: [
                      Expanded(
                        child: Btn(
                          '${widget.cancelBtn!.toLowerCase()}'.tr,
                          onPressed: () => Navigator.pop(context, false),
                        ),
                      ),
                      S.sVerticalDivider(),
                      Expanded(
                        child: Btn(
                          '${widget.okayBtn}',
                          backgroundColor: Clr.colorPrimary,
                          textColor: Colors.white,
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
