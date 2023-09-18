import 'package:decisive_technology_products/controllers/orders/create_order_controller.dart';
import 'package:decisive_technology_products/models/order_model/order_model.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class CreateOrderPage extends GetView<CreateOrderController> {
  final Order? order;
  CreateOrderPage({this.order});

  @override
  Widget build(BuildContext context) {
    return makeBody(context);
  }

  Widget makeBody(context) {
    if (order == null) {
      return buildBody(context);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('update_order'.tr),
          centerTitle: true,
        ),
        body: buildBody(context),
      );
    }
  }

  Widget buildBody(context) {
    return GestureDetector(
      onTap: () => S.sFocusOut(context),
      child: GetBuilder<CreateOrderController>(
          init: CreateOrderController(order: order),
          dispose: (val) => Get.delete<CreateOrderController>(),
          builder: (snapshot) {
            return PageOne(
              controller,
              order: order,
            );
          }),
    );
  }
}

class PageOne extends StatelessWidget {
  final CreateOrderController controller;
  final Order? order;
  const PageOne(this.controller, {this.order});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: S.sBoxDecoration(
                    filledColor: Colors.white,
                    shadowColor: Colors.black.withOpacity(0.5),
                    shadowRadius: 10),
                child: ListView(
                  children: [
                    Txt(
                      'order_details'.tr,
                      hasBold: true,
                      size: Siz.h2,
                    ),
                    S.sDivider(),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: S.sDropDownButton(
                              'customer_code'.tr,
                              '',
                              controller.listCustomer,
                              controller.selectedCustomer.value == 0
                                  ? null
                                  : controller.selectedCustomer.value,
                              (val) {
                                controller.selectedCustomer(val);
                              },
                              focusNode: controller.customerCodeFocus,
                            ),
                          ),
                          IconButton(
                              onPressed: controller.onCustomerSearchTap,
                              icon: Icon(Icons.search)),
                        ],
                      ),
                    ),
                    S.sDivider(),
                    Row(
                      children: [
                        Expanded(
                          child: TxtInput(
                            hintText: 'order_date*'.tr,
                            hasBorder: true,
                            maxLines: 1,
                            controller: controller.orderDate,
                            focusNode: controller.orderDateFocus,
                            onTap: controller.onDateTap,
                            onEditingComplete: () => S.sFocusOut(context,
                                focusNode: controller.creditDaysFocus),
                          ),
                        ),
                        S.sVerticalDivider(),
                        Expanded(
                          child: TxtInput(
                            hintText: 'credit_days'.tr,
                            hasBorder: true,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            controller: controller.creditDays,
                            focusNode: controller.creditDaysFocus,
                            onEditingComplete: () => S.sFocusOut(context),
                          ),
                        ),
                      ],
                    ),
                    S.sDivider(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => controller
                                    .isReceipt(!controller.isReceipt.value),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                        value: controller.isReceipt.value,
                                        onChanged: (val) =>
                                            controller.isReceipt(val),
                                        activeColor: Clr.colorPrimary,
                                      ),
                                    ),
                                    Txt(
                                      'is_receipt'.tr,
                                      size: Siz.h3,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    controller.isCash(!controller.isCash.value),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                        value: controller.isCash.value,
                                        onChanged: (val) =>
                                            controller.isCash(val),
                                        activeColor: Clr.colorPrimary,
                                      ),
                                    ),
                                    Txt(
                                      'is_cash'.tr,
                                      size: Siz.h3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => controller
                          .isVatInvoice(!controller.isVatInvoice.value),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: controller.isVatInvoice.value,
                                  onChanged: controller.onIsVatChange,
                                  activeColor: Clr.colorPrimary,
                                ),
                                Txt(
                                  'vat'.tr,
                                  size: Siz.h3,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: false,
                                  groupValue: controller.isVatInvoice.value,
                                  onChanged: controller.onIsVatChange,
                                  activeColor: Clr.colorPrimary,
                                ),
                                Txt(
                                  'no_vat'.tr,
                                  size: Siz.h3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    S.sDivider(),
                    Obx(() {
                      return Column(
                        children: [
                          ...controller.products.map((e) => Column(
                                children: [
                                  S.sDropDownButton(
                                      "product".tr,
                                      '',
                                      e.listProduct,
                                      e.selectedProduct.value == 0
                                          ? null
                                          : e.selectedProduct.value,
                                      (val) => e.selectedProduct(val)),
                                  S.sDivider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TxtInput(
                                          hintText: 'quantity*'.tr,
                                          hasBorder: true,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          controller: e.quantity,
                                          focusNode: e.quantityFocus,
                                          onEditingComplete: () => S.sFocusOut(
                                              context,
                                              focusNode: e.unitPriceFocus),
                                        ),
                                      ),
                                      S.sVerticalDivider(),
                                      Expanded(
                                        child: TxtInput(
                                          hintText: 'unit_price*'.tr,
                                          hasBorder: true,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          controller: e.unitPrice,
                                          focusNode: e.unitPriceFocus,
                                          onEditingComplete: () =>
                                              S.sFocusOut(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (controller.products.length > 1)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: MaterialButton(
                                        child: Txt('remove_product'.tr + ' X'),
                                        onPressed: () =>
                                            controller.removeProduct(e),
                                      ),
                                    ),
                                  S.sDivider(),
                                ],
                              ))
                        ],
                      );
                    }),
                    MaterialButton(
                      child: Txt('add_more_products'.tr),
                      onPressed: controller.addMoreProduct,
                    ),
                    S.sDivider(),
                  ],
                ),
              ),
            ),
            S.sDivider(),
            Obx(
              () => controller.isOrdering.isTrue
                  ? LoadingPro()
                  : Btn(
                      order == null ? 'create'.tr : 'update'.tr,
                      onPressed: () {
                        controller.onPageSave(order);
                      },
                      width: double.infinity,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
