import 'package:decisive_technology_products/controllers/dashboard/dashboard_controller.dart';
import 'package:decisive_technology_products/utils/CommonManager.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../s.dart';

class DashboardPage extends GetView<DashboardController> {
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    CommonManager.manager.controller = controller;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: AdvancedDrawer(
        backdropColor: Colors.white,
        controller: controller.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.0,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: GestureDetector(
          onTap: () => S.sFocusOut(context),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () =>
                    controller.advancedDrawerController.showDrawer(),
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: controller.advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: 300.milliseconds,
                      child: value.visible
                          ? Icon(Icons.clear,
                              key: ValueKey<bool>(value.visible))
                          : SvgPicture.asset(
                              'assets/svgs/Icon feather-menu.svg',
                              key: ValueKey<bool>(value.visible),
                            ),
                    );
                  },
                ),
              ),
            ),
            body: Obx(
              () => Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    decoration: S.sBoxDecorationNew(
                        hasBorder: true,
                        borderColor: Clr.colorPrimary,
                        filledColor: Clr.colorPrimary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    height: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Txt(
                          controller.title.value,
                          textColor: Colors.white,
                          size: Siz.h2,
                          hasBold: true,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: controller.pages[controller.pageIndex.value]),
                ],
              ),
            ),
          ),
        ),
        drawer: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                S.sDivider(),
                Txt(
                  'hi'.tr + ', ${S.sObjLogin!.user!.name}',
                  hasBold: true,
                  size: Siz.h1,
                ),
                S.sDivider(),
                Txt(
                  'create_customer'.tr,
                  hasBold: true,
                  size: Siz.h2,
                  onTap: () => controller.onPageChange(0),
                ),
                S.sDivider(),
                Txt('customers'.tr,
                    hasBold: true,
                    size: Siz.h2,
                    onTap: () => controller.onPageChange(1)),
                S.sDivider(),
                Txt('create_order'.tr,
                    hasBold: true,
                    size: Siz.h2,
                    onTap: () => controller.onPageChange(2)),
                S.sDivider(),
                Txt('orders'.tr,
                    hasBold: true,
                    size: Siz.h2,
                    onTap: () => controller.onPageChange(3)),
                S.sDivider(),
                Txt('payments'.tr,
                    hasBold: true,
                    size: Siz.h2,
                    onTap: () => controller.onPageChange(4)),
                S.sDivider(),
                Txt('notifications'.tr,
                    hasBold: true,
                    size: Siz.h2,
                    onTap: () => controller.onPageChange(5)),
                S.sDivider(),
                Txt('Reports'.tr,
                    hasBold: true,
                    size: Siz.h2,
                    onTap: () => controller.onPageChange(6)),
                S.sDivider(),
                Txt('change_password'.tr,
                    hasBold: true,
                    size: Siz.h2,
                    onTap: () => controller.onPageChange(7)),
                // S.sDivider(),
                // Txt('Sales Man', hasBold: true,size: Siz.h2,onTap: ()=> controller.onPageChange(8)),

                Spacer(),
                GestureDetector(
                  onTap: S.sLogout,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: S.sBoxDecoration(
                        radius: 10, filledColor: Clr.colorPrimary),
                    child: Column(
                      children: [
                        RotatedBox(
                          quarterTurns: 90,
                          child: Icon(
                            Icons.exit_to_app_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        Txt(
                          'logout'.tr,
                          hasBold: true,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
