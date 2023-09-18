import 'package:decisive_technology_products/controllers/payment/payment_controller.dart';
import 'package:decisive_technology_products/models/order_model/order_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/get_images.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/no_data.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class ManagePaymentsPage extends StatelessWidget {
  final Order item;
  ManagePaymentsPage(this.item);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        init: PaymentController(this.item),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('payments'.tr),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: controller.isLoading.isTrue
                  ? LoadingPro()
                  : controller.list.isEmpty
                      ? NoDataFound(
                          onTap: controller.callInit,
                        )
                      : ListView.builder(
                          itemCount: controller.list.length,
                          itemBuilder: (context, index) {
                            final item = controller.list[index];
                            return GestureDetector(
                              onTap: () => controller.onTap(item),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: S.sBoxDecoration(
                                  filledColor: Colors.white,
                                  shadowRadius: 10,
                                  shadowColor: Colors.black.withOpacity(0.2),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Txt(
                                                'Serial No.: '.tr,
                                                hasBold: true,
                                              ),
                                              Expanded(
                                                  child: Txt(
                                                (index + 1).toString(),
                                                checkOverflow: true,
                                                maxLine: 1,
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Txt(
                                                'Amount: '.tr,
                                                hasBold: true,
                                              ),
                                              Expanded(
                                                  child: Txt(
                                                '${item.amount}',
                                                checkOverflow: true,
                                                maxLine: 1,
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Txt(
                                                'Invoice Number: '.tr,
                                                hasBold: true,
                                              ),
                                              Expanded(
                                                  child: Txt(
                                                '${item.invoiceNo ?? Str.NA}',
                                                checkOverflow: true,
                                                maxLine: 1,
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Txt(
                                                'Money Transfer Date: '.tr,
                                                hasBold: true,
                                              ),
                                              Expanded(
                                                  child: Txt(
                                                '${S.sDateToString(item.transactionDate!)}',
                                                checkOverflow: true,
                                                maxLine: 1,
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                    GetImage(
                                      imagePath: item.picture == null
                                          ? 'Bilal'
                                          : '${HttpCalls.sStorageURL}${item.picture}',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Clr.colorPrimary,
              onPressed: controller.onAddPressed,
            ),
          );
        });
  }
}
