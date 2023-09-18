import 'package:decisive_technology_products/controllers/payment/payment_controller.dart';
import 'package:decisive_technology_products/main.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class AddPaymentsPage extends StatelessWidget {
  final PaymentController controller;
  AddPaymentsPage(this.controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: S.sFocusOut(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Payments'.tr),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          width: deviceWidth,
          decoration: S.sBoxDecoration(
            filledColor: Colors.white,
            shadowRadius: 10,
            shadowColor: Colors.black.withOpacity(0.2),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              TxtInput(
                controller: controller.invoiceNumber,
                hintText: 'Invoice Number'.tr,
                hasBorder: true,
              ),
              S.sDivider(),
              TxtInput(
                controller: controller.transferDate,
                hintText: 'Money Transfer Date'.tr,
                hasBorder: true,
                onTap: controller.onDateTap,
              ),
              S.sDivider(),
              TxtInput(
                controller: controller.amount,
                hintText: 'Amount'.tr,
                hasBorder: true,
                keyboardType: TextInputType.number,
              ),
              S.sDivider(),
              TxtInput(
                paddingHorizontal: 2,
                hintText: '   Bank Slip'.tr,
                hasBorder: true,
                maxLines: 1,
                postFixIcon: Btn('choose_file'.tr),
                controller: controller.bankSlip,
                onTap: controller.onAttachmentTap,
              ),
              S.sDivider(),
              Obx(() => controller.isLoading.value
                  ? LoadingPro()
                  : Btn('Add'.tr, onPressed: controller.onSubmitPressed)),
            ],
          ),
        ),
      ),
    );
  }
}
