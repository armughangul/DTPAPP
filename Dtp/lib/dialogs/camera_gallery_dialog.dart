import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../s.dart';

class CameraGalleryDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CameraGalleryDialogState();
}

class CameraGalleryDialogState extends State<CameraGalleryDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  void dispose() {
    if (controller != null) controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
              height: 140,
              width: deviceWidth * 0.8,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: S.sBoxDecorationWithoutShadow(
                radius: 8.0,
                filledColor: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context, true),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // SvgPicture.asset('assets/svg/camera.svg',color: Clr.colorPrimary,height: 50,),
                        Icon(
                          Icons.camera,
                          size: 45,
                          color: Clr.colorPrimary,
                        ),
                        S.sDivider(height: 8),
                        Txt(
                          'camera'.tr,
                          textColor: Colors.white,
                          backgroundColor: Clr.colorPrimary,
                          hasBorder: true,
                          paddingHorizontal: 8,
                        ),
                      ],
                    ),
                  ),
                  S.sVerticalDivider(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      S.sDivider(height: 58),
                      Txt(
                        'or'.tr,
                        size: 20,
                        textColor: Clr.colorPrimary,
                      ),
                    ],
                  ),
                  S.sVerticalDivider(width: 20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // SvgPicture.asset('assets/svg/attach.svg',color: Clr.colorPrimary,height: 50,),
                        Icon(
                          Icons.image,
                          size: 50,
                          color: Clr.colorPrimary,
                        ),
                        S.sDivider(height: 8),
                        Txt(
                          'gallery'.tr,
                          textColor: Colors.white,
                          backgroundColor: Clr.colorPrimary,
                          hasBorder: true,
                          paddingHorizontal: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
