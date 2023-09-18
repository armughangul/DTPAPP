import 'package:decisive_technology_products/controllers/orders/manage_order_controller.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/no_data.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../s.dart';

class ManageOrderPage extends GetView<ManageOrderController> {
  final bool forPayments;
  const ManageOrderPage(this.forPayments);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageOrderController>(
        init: ManageOrderController(),
        dispose: (val) => Get.delete<ManageOrderController>(),
        builder: (snapshot) {
          return snapshot.isLoading
              ? LoadingPro()
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10, top: 20, left: 16, right: 16),
                      decoration: S.sBoxDecoration(
                        filledColor: Colors.white,
                        shadowRadius: 10,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      child: TxtInput(
                        hintText: 'search'.tr,
                        hasBorder: true,
                        postFixIcon: Icon(
                          Icons.search,
                          color: Clr.colorPrimary,
                        ),
                        controller: controller.searchTxt,
                        onChanged: controller.onSearch,
                      ),
                    ),
                    Expanded(
                      child: LiquidPullToRefresh(
                        color: Clr.colorPrimary,
                        key: controller
                            .refreshIndicatorKey, // key if you want to add
                        onRefresh: () => controller.callInit(forPayments),
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
                                            int color = int.parse('0xFF' +
                                                item.status!.color.toString());

                                            return Container(
                                              margin: EdgeInsets.fromLTRB(16,
                                                  index == 0 ? 24 : 8, 16, 16),
                                              child: Slidable(
                                                actionPane:
                                                    SlidableDrawerActionPane(),
                                                closeOnScroll: true,
                                                controller: controller
                                                    .slideAbleController,
                                                actionExtentRatio: 0.23,
                                                secondaryActions: forPayments
                                                    ? []
                                                    : <Widget>[
                                                        IconSlideAction(
                                                          color: Clr
                                                              .colorTransparent,
                                                          iconWidget: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 8),
                                                            decoration: S
                                                                .sBoxDecoration(
                                                                    filledColor:
                                                                        Clr.colorGreen),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    'assets/svgs/edit.svg'),
                                                                S.sDivider(
                                                                    height: 12),
                                                                Txt(
                                                                  'edit'.tr,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () =>
                                                              controller
                                                                  .onEdit(item),
                                                        ),
                                                        IconSlideAction(
                                                          color: Clr
                                                              .colorTransparent,
                                                          iconWidget: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 8),
                                                            decoration: S
                                                                .sBoxDecoration(
                                                                    filledColor:
                                                                        Clr.colorRed),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    'assets/svgs/delete.svg'),
                                                                S.sDivider(
                                                                    height: 12),
                                                                Txt(
                                                                  'delete'.tr,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () =>
                                                              controller
                                                                  .onItemDelete(
                                                                      item),
                                                        ),
                                                      ],
                                                child: GestureDetector(
                                                  onTap: () => forPayments
                                                      ? controller
                                                          .onPaymentTap(item)
                                                      : controller.onTap(item),
                                                  child: Container(
                                                    padding: EdgeInsets.all(16),
                                                    decoration:
                                                        S.sBoxDecoration(
                                                      filledColor: Colors.white,
                                                      shadowRadius: 10,
                                                      shadowColor: Colors.black
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
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
                                                                shadowRadius:
                                                                    10,
                                                                shadowColor: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                              child: Txt(
                                                                  item.orderNo),
                                                            ),
                                                            Spacer(),
                                                            GestureDetector(
                                                              onTap: forPayments
                                                                  ? () => controller
                                                                      .onPaymentTap(
                                                                          item)
                                                                  : () {},
                                                              child: Container(
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
                                                                  shadowRadius:
                                                                      10,
                                                                  shadowColor: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.2),
                                                                ),
                                                                child: Txt(
                                                                  item.status!
                                                                      .name,
                                                                  textColor: color ==
                                                                          null
                                                                      ? Colors
                                                                          .black
                                                                      : Color(
                                                                          color),
                                                                  hasBold: true,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        S.sDivider(),
                                                        Row(
                                                          children: [
                                                            Txt(
                                                              'sales_person: '
                                                                  .tr,
                                                              hasBold: true,
                                                            ),
                                                            Expanded(
                                                                child: Txt(
                                                              item.seller!.name,
                                                              maxLine: 1,
                                                              checkOverflow:
                                                                  true,
                                                            )),
                                                          ],
                                                        ),
                                                        S.sDivider(),
                                                        Row(
                                                          children: [
                                                            Txt(
                                                              'customer_name: '
                                                                  .tr,
                                                              hasBold: true,
                                                            ),
                                                            Expanded(
                                                                child: Txt(
                                                              item.customer!
                                                                  .nameEnglish,
                                                              maxLine: 1,
                                                              checkOverflow:
                                                                  true,
                                                            )),
                                                          ],
                                                        ),
                                                        S.sDivider(height: 4),
                                                        Row(
                                                          children: [
                                                            Txt(
                                                              'customer_code: '
                                                                  .tr,
                                                              hasBold: true,
                                                            ),
                                                            Expanded(
                                                                child: Txt(
                                                              item.customer!
                                                                  .customerCode,
                                                              maxLine: 1,
                                                              checkOverflow:
                                                                  true,
                                                            )),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          8),
                                                              decoration: S
                                                                  .sBoxDecoration(
                                                                filledColor:
                                                                    Colors
                                                                        .white,
                                                                shadowRadius:
                                                                    10,
                                                                shadowColor: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      'assets/svgs/Calendar.svg'),
                                                                  S.sVerticalDivider(
                                                                      width: 2),
                                                                  Txt(S.sDateToString(
                                                                      item.orderDate!)),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
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
