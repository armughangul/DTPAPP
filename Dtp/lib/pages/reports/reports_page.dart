import 'package:decisive_technology_products/controllers/reports/reports.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/get_images.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/no_data.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../s.dart';

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsController>(
        init: ReportsController(),
        dispose: (val) => Get.delete<ReportsController>(),
        builder: (controller) {
          return controller.isLoading.value
              ? LoadingPro()
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10, top: 20, left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: S.sBoxDecoration(
                                filledColor: Colors.white,
                                shadowRadius: 10,
                                shadowColor: Colors.black.withOpacity(0.2),
                              ),
                              child: TxtInput(
                                hintText: 'from_date'.tr,
                                controller: controller.fromDate,
                                hasBorder: true,
                                onTap: controller.onFromDate,
                              ),
                            ),
                          ),
                          if (controller.fromDateInDate != null) ...[
                            S.sVerticalDivider(),
                            Expanded(
                              child: Container(
                                decoration: S.sBoxDecoration(
                                  filledColor: Colors.white,
                                  shadowRadius: 10,
                                  shadowColor: Colors.black.withOpacity(0.2),
                                ),
                                child: TxtInput(
                                  hintText: 'to_date'.tr,
                                  hasBorder: true,
                                  controller: controller.toDate,
                                  onTap: controller.onToDate,
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    Expanded(
                      child: LiquidPullToRefresh(
                        color: Clr.colorPrimary,
                        key: controller
                            .refreshIndicatorKey, // key if you want to add
                        onRefresh: controller.callInit,
                        height: 50,
                        child: Container(
                          child: Obx(
                            () => controller.list.isEmpty
                                ? NoDataFound(
                                    onTap: controller.onInit,
                                  )
                                : Column(
                                    children: [
                                      Expanded(
                                        child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            final item = controller.list[index];

                                            return Container(
                                              margin: EdgeInsets.fromLTRB(16,
                                                  index == 0 ? 24 : 8, 16, 16),
                                              height: 180,
                                              child: GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  decoration: S.sBoxDecoration(
                                                    filledColor: Colors.white,
                                                    shadowRadius: 10,
                                                    shadowColor: Colors.black
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Txt(
                                                                  'Amount'.tr,
                                                                  hasBold: true,
                                                                ),
                                                                Expanded(
                                                                    child: Txt(
                                                                  ': ' +
                                                                      (item.order!
                                                                              .netAmount ??
                                                                          ""),
                                                                  maxLine: 1,
                                                                  checkOverflow:
                                                                      true,
                                                                )),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Txt(
                                                                  'Paid Amount'
                                                                      .tr,
                                                                  hasBold: true,
                                                                ),
                                                                Expanded(
                                                                    child: Txt(
                                                                  ': ' +
                                                                      (item.amount ??
                                                                          ""),
                                                                  maxLine: 1,
                                                                  checkOverflow:
                                                                      true,
                                                                )),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Txt(
                                                                  'order_date:'
                                                                      .tr,
                                                                  hasBold: true,
                                                                ),
                                                                Expanded(
                                                                    child: Txt(
                                                                  '${S.sDateToString(item.order!.orderDate!)}',
                                                                  maxLine: 1,
                                                                  checkOverflow:
                                                                      true,
                                                                )),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Txt(
                                                                  'payment_date:'
                                                                      .tr,
                                                                  hasBold: true,
                                                                ),
                                                                Expanded(
                                                                    child: Txt(
                                                                  ': ${S.sDateToString(item.transactionDate!)}',
                                                                  maxLine: 1,
                                                                  checkOverflow:
                                                                      true,
                                                                )),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        12),
                                                            decoration: S
                                                                .sBoxDecoration(
                                                              filledColor: Clr
                                                                  .colorGreyBackground,
                                                              shadowRadius: 10,
                                                              shadowColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            child: Txt(
                                                              '${item.order!.orderNo}',
                                                              hasBold: true,
                                                            ),
                                                          ),
                                                          S.sDivider(height: 8),
                                                          GetImage(
                                                            imagePath:
                                                                '${HttpCalls.sStorageURL}${item.picture}',
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              Container(),
                                          itemCount: controller.list.length,
                                        ),
                                      ),
                                      Txt('total_orders: '.tr +
                                          '${controller.list.length}')
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
