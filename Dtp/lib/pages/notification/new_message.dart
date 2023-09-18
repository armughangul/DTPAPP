import 'package:decisive_technology_products/controllers/notification/notification_controller.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class NewMessagePage extends StatelessWidget {
  final NtfController controller;
  const NewMessagePage(this.controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: S.sFocusOut(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('new_message'.tr),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: S.sBoxDecoration(
              filledColor: Colors.white,
              shadowColor: Colors.black.withOpacity(S.opacity),
              shadowRadius: 10),
          child: ListView(
            children: [
              TxtInput(
                hintText: 'new_message'.tr,
                hasBorder: true,
                maxLines: 10,
                controller: controller.message,
              ),
              S.sDivider(),
              TxtInput(
                paddingHorizontal: 2,
                //TODO
                hintText: '   attachment'.tr,
                hasBorder: true,
                maxLines: 1,
                postFixIcon: Btn('choose_file'.tr),
                controller: controller.attachment,
                onTap: controller.onAttachmentTap,
              ),
              S.sDivider(),
              Obx(() => controller.isSendingNew.isTrue
                  ? LoadingPro()
                  : Btn(
                      'send'.tr,
                      onPressed: controller.onSendTap,
                      backgroundColor: Clr.colorPrimary,
                      textColor: Colors.white,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
