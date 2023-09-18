import 'package:decisive_technology_products/controllers/orders/order_detail_controller.dart';
import 'package:decisive_technology_products/models/order_model/order_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/get_images.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class OrderDetailPage extends GetView<OrderDetailController> {
  final Order order;
  final List<Status> statuses;
  const OrderDetailPage(this.order, this.statuses);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailController(statuses, order));
    return Scaffold(
      appBar: AppBar(
        title: Text('order_detail'.tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          S.sDivider(),
          Obx(
            () => Row(
              children: [
                S.sVerticalDivider(),
                Expanded(
                    child: Btn('summary'.tr,
                        backgroundColor: controller.filter.value.isEqual(0)
                            ? Clr.colorPrimary
                            : null,
                        textColor: controller.filter.value.isEqual(0)
                            ? Colors.white
                            : Colors.black,
                        onPressed: () => controller.onFilterChange(0),
                        textSize: 12)),
                S.sVerticalDivider(width: 8),
                Expanded(
                    child: Btn(
                  'product'.tr,
                  backgroundColor: controller.filter.value.isEqual(1)
                      ? Clr.colorPrimary
                      : null,
                  textColor: controller.filter.value.isEqual(1)
                      ? Colors.white
                      : Colors.black,
                  onPressed: () => controller.onFilterChange(1),
                )),
                S.sVerticalDivider(width: 8),
                Expanded(
                    child: Btn(
                  'update'.tr,
                  backgroundColor: controller.filter.value.isEqual(2)
                      ? Clr.colorPrimary
                      : null,
                  textColor: controller.filter.value.isEqual(2)
                      ? Colors.white
                      : Colors.black,
                  onPressed: () => controller.onFilterChange(2),
                )),
                S.sVerticalDivider(),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.filter,
              children: [
                SummaryPage(controller, order),
                ProductPage(controller, order),
                UpdatePage(controller, order),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  final OrderDetailController controller;
  final Order order;
  const SummaryPage(this.controller, this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: S.sBoxDecoration(
          filledColor: Colors.white,
          shadowColor: Colors.black.withOpacity(S.opacity),
          shadowRadius: 10),
      child: ListView(
        children: [
          createRow('order_no:'.tr, order.orderNo),
          createRow('customer:'.tr, order.customer!.nameEnglish),
          createRow('salesman:'.tr, order.seller!.name),
          createRow('net_amount:'.tr, order.netAmount),
          createRow('order_status:'.tr, order.status!.name),
          createRow('order_date:'.tr, S.sDateToString(order.orderDate!)),
          createRow('credit_days:'.tr, order.creditDays.toString()),
          createRow('is_vat_invoice?:'.tr, order.isVatInvoice.toString()),
          createRow('invoice_no:'.tr, order.invoiceNo),
          createRow(
              'invoice_due_date:'.tr, S.sDateToString(order.invoiceDueDate)),
          createRow('shipping_date:'.tr, S.sDateToString(order.shippingDate)),
          createRow('shipment_tracking_code:'.tr, order.shipmentTrackingCode),
          createRow('comments:'.tr, order.comments),
          createRow(
              'total_products'.tr + ':', order.details!.length.toString()),
        ],
      ),
    );
  }

  createRow(String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 7,
                child: Txt(
                  label,
                  hasBold: true,
                )),
            Expanded(
                flex: 3,
                child: Txt(
                  value ?? 'na'.tr,
                )),
          ],
        ),
        Divider(),
      ],
    );
  }
}

class ProductPage extends StatelessWidget {
  final OrderDetailController controller;
  final Order order;
  const ProductPage(this.controller, this.order);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: S.sBoxDecoration(
          filledColor: Colors.white,
          shadowColor: Colors.black.withOpacity(S.opacity),
          shadowRadius: 10),
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: [
                          getContainer('serial_number:'.tr,
                              (controller.currentIndex.value + 1).toString()),
                          getContainer(
                              'product:'.tr,
                              order.details![controller.currentIndex.value]
                                  .product!.productName),
                          getContainer(
                              'quantity:'.tr,
                              order.details![controller.currentIndex.value].qty
                                  .toString()),
                          getContainer(
                              'unit_price:'.tr,
                              order.details![controller.currentIndex.value]
                                  .price),
                          getContainer(
                              'sub_total:'.tr,
                              order.details![controller.currentIndex.value]
                                  .subTotal),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: GetImage(
                        imagePath: HttpCalls.sStorageURL +
                            order.details![controller.currentIndex.value]
                                .product!.image),
                  ))
                ],
              ),
            ),
            if (order.details!.length != 1)
              Row(
                children: [
                  IconButton(
                      onPressed: controller.onBackTap,
                      icon: Icon(Icons.navigate_before)),
                  Spacer(),
                  IconButton(
                      onPressed: controller.onNextTap,
                      icon: Icon(Icons.navigate_next))
                ],
              )
          ],
        ),
      ),
    );
  }

  getContainer(String label, String value) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: S.sBoxDecoration(
          filledColor: Colors.white,
          shadowColor: Colors.black.withOpacity(S.opacity),
          shadowRadius: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            label,
            hasBold: true,
          ),
          Txt(value ?? ''),
        ],
      ),
    );
  }
}

class UpdatePage extends StatelessWidget {
  final OrderDetailController controller;
  final Order order;
  const UpdatePage(this.controller, this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: S.sBoxDecoration(
          filledColor: Colors.white,
          shadowColor: Colors.black.withOpacity(S.opacity),
          shadowRadius: 10),
      child: ListView(
        children: [
          Obx(
            () => S.sDropDownButton(
              'status*'.tr,
              '',
              controller.listStatuses,
              controller.selectedStatus.value == 0
                  ? null
                  : controller.selectedStatus.value,
              (val) {
                controller.selectedStatus(val);
              },
            ),
          ),
          S.sDivider(),
          Row(
            children: [
              Obx(
                () => Expanded(
                  child: S.sDropDownButton(
                    'money_received*'.tr,
                    '',
                    controller.listMoneyReceived,
                    controller.selectedMoneyReceivedStatus.value,
                    (val) {
                      controller.selectedMoneyReceivedStatus(val);
                    },
                  ),
                ),
              ),
              S.sVerticalDivider(),
              Expanded(
                child: TxtInput(
                  hintText: 'invoice_no.*'.tr,
                  hasBorder: true,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: controller.invoiceNo,
                  focusNode: controller.invoiceNoFocus,
                  onEditingComplete: () => S.sFocusOut(context,
                      focusNode: controller.shippingDateFocus),
                ),
              )
            ],
          ),
          S.sDivider(),
          Row(
            children: [
              Expanded(
                child: TxtInput(
                  hintText: 'shipping_date*'.tr,
                  hasBorder: true,
                  maxLines: 1,
                  controller: controller.shippingDate,
                  focusNode: controller.shippingDateFocus,
                  onTap: controller.onShippingDate,
                  onEditingComplete: () => S.sFocusOut(context,
                      focusNode: controller.invoiceDueDateFocus),
                ),
              ),
              S.sVerticalDivider(),
              Expanded(
                child: TxtInput(
                  hintText: 'invoice_due_date*'.tr,
                  hasBorder: true,
                  maxLines: 1,
                  controller: controller.invoiceDueDate,
                  focusNode: controller.invoiceDueDateFocus,
                  onTap: controller.onInvoiceDate,
                  onEditingComplete: () => S.sFocusOut(context,
                      focusNode: controller.shipmentTrackingCodeFocus),
                ),
              ),
            ],
          ),
          S.sDivider(),
          TxtInput(
            hintText: 'shipment_tracking_code*'.tr,
            hasBorder: true,
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: controller.shipmentTrackingCode,
            focusNode: controller.shipmentTrackingCodeFocus,
            onEditingComplete: () => S.sFocusOut(context),
          ),
          S.sDivider(),
          TxtInput(
            paddingHorizontal: 2,
            hintText: '   attachment'.tr,
            hasBorder: true,
            maxLines: 1,
            postFixIcon: Btn('choose_file'.tr),
            controller: controller.attachment,
            onTap: controller.onAttachmentTap,
          ),
          if (controller.order.invoicePicture != "") ...[
            S.sDivider(),
            GetImage(
              imagePath:
                  '${HttpCalls.sStorageURL}${controller.order.invoicePicture}',
            ),
          ],
          S.sDivider(),
          TxtInput(
            hintText: 'comments'.tr,
            hasBorder: true,
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: controller.comments,
            focusNode: controller.commentsFocus,
            onEditingComplete: () => S.sFocusOut(context),
          ),
          S.sDivider(),
          Row(
            children: [
              Expanded(child: Btn('cancel'.tr)),
              S.sVerticalDivider(),
              Expanded(
                  child: Obx(() => controller.isSaving.isTrue
                      ? LoadingPro()
                      : Btn(
                          'save'.tr,
                          backgroundColor: Clr.colorPrimary,
                          textColor: Colors.white,
                          onPressed: controller.onSaveTap,
                        ))),
            ],
          )
        ],
      ),
    );
  }
}
