import 'package:decisive_technology_products/controllers/customer/manage_customer_controller.dart';
import 'package:decisive_technology_products/utils/CommonManager.dart';
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

import '../../controllers/dashboard/dashboard_controller.dart';
import '../../s.dart';

class ManageCustomer extends GetView<ManageCustomerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageCustomerController>(
        init: ManageCustomerController(),
        dispose: (val) => Get.delete<ManageCustomerController>(),
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
                        onRefresh: controller.callInit,
                        height: 50,
                        child: Container(
                          child: Obx(
                            () => controller.list.isEmpty
                                ? Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: S.sBoxDecoration(
                                      filledColor: Colors.white,
                                      shadowRadius: 10,
                                      shadowColor:
                                          Colors.black.withOpacity(0.2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            CommonManager.manager.controller
                                                ?.onPageChange(0);
                                            // Get.put(DashboardController())
                                            //     .onPageChange(0);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 55,
                                            decoration: BoxDecoration(
                                                color: Clr.colorPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Txt(
                                              'create_customer'.tr,
                                              textColor: Colors.white,
                                              hasBold: true,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: NoDataFound(
                                            onTap: controller.callInit,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                              child: Slidable(
                                                actionPane:
                                                    SlidableDrawerActionPane(),
                                                closeOnScroll: true,
                                                controller: controller
                                                    .slidableController,
                                                actionExtentRatio: 0.23,
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  decoration: S.sBoxDecoration(
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
                                                              shadowRadius: 10,
                                                              shadowColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            child: Txt(
                                                              item.id
                                                                  .toString(),
                                                              textColor: Clr
                                                                  .colorPrimary,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          CircleAvatar(
                                                            backgroundColor: item
                                                                        .isActive ??
                                                                    false
                                                                ? Clr.colorGreen
                                                                : Clr.colorRed,
                                                            radius: 9,
                                                          )
                                                        ],
                                                      ),
                                                      S.sDivider(),
                                                      Row(
                                                        children: [
                                                          Txt(
                                                            'english_name: '.tr,
                                                            hasBold: true,
                                                          ),
                                                          Expanded(
                                                              child: Txt(
                                                            item.nameEnglish ??
                                                                "",
                                                            maxLine: 1,
                                                            checkOverflow: true,
                                                          )),
                                                        ],
                                                      ),
                                                      S.sDivider(),
                                                      Row(
                                                        children: [
                                                          Txt(
                                                            'thai_name: '.tr,
                                                            hasBold: true,
                                                          ),
                                                          Expanded(
                                                              child: Txt(
                                                            item.nameThai ?? "",
                                                            maxLine: 1,
                                                            checkOverflow: true,
                                                          )),
                                                        ],
                                                      ),
                                                      S.sDivider(height: 4),
                                                      Row(
                                                        children: [
                                                          Txt(
                                                            'reg_#: '.tr,
                                                            hasBold: true,
                                                            textColor: Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          Expanded(
                                                              child: Txt(
                                                            item.registrationNo ??
                                                                "",
                                                            maxLine: 1,
                                                            checkOverflow: true,
                                                            textColor: Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.5),
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
                                                                  Colors.white,
                                                              shadowRadius: 10,
                                                              shadowColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    'assets/svgs/call.svg'),
                                                                Txt(
                                                                  item.mobileNumber ??
                                                                      "",
                                                                  textColor: Clr
                                                                      .colorPrimary,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                secondaryActions: <Widget>[
                                                  IconSlideAction(
                                                    color: Clr.colorTransparent,
                                                    iconWidget: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 8),
                                                      decoration:
                                                          S.sBoxDecoration(
                                                              filledColor: Clr
                                                                  .colorGreen),
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
                                                                Colors.white,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () =>
                                                        controller.onEdit(item),
                                                  ),

                                                  // IconSlideAction(
                                                  //   color: Clr.colorTransparent,
                                                  //   iconWidget: Container(
                                                  //     margin: EdgeInsets.only(left: 8),
                                                  //     decoration: S.sBoxDecoration(filledColor: Clr.colorRed),
                                                  //     child: Column(
                                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                                  //       children: [
                                                  //         SvgPicture.asset('assets/svgs/delete.svg'),
                                                  //         S.sDivider(height: 12),
                                                  //         Txt('Delete', textColor: Colors.white,)
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  //   onTap: () => controller.onItemDelete(item),
                                                  // ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              Container(),
                                          itemCount: controller.list.length,
                                        ),
                                      ),
                                      Txt('total_customers: '.tr +
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
