import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../s.dart';

class InfoDialog extends StatefulWidget {
  final String title, message;

  InfoDialog(this.title, this.message);
  @override
  State<StatefulWidget> createState() => InfoDialogState();
}

class InfoDialogState extends State<InfoDialog>
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
                    '${widget.title.toLowerCase()}'.tr,
                    hasBold: true,
                    size: Siz.h2,
                  ),
                  S.sDivider(),
                  Txt('${widget.message}'),
                  S.sDivider(),
                  S.sVerticalDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Btn(
                        'close'.tr,
                        backgroundColor: Clr.colorPrimary,
                        textColor: Colors.white,
                        onPressed: () => Navigator.pop(context, true),
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
