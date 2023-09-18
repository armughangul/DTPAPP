import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/order_model/order_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/pages/orders/create_order_page.dart';
import 'package:decisive_technology_products/pages/orders/order_detail_page.dart';
import 'package:decisive_technology_products/pages/payment/manage_payments.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../s.dart';

class ManageOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final context = Get.context;
  bool isLoading = true;
  OrderModel orderModel = OrderModel();
  var list = <Order>[].obs;
  List<Status> statuses = [];

  var slideAbleController = SlidableController();

  var refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  var searchTxt = TextEditingController();

  Future<bool> callInit(forPayments) async {
    try {
      ViewResponse response = await HttpCalls.callGetApi(EndPoints.order);
      if (response.status) {
        orderModel = orderModelFromJson(response.data);
        statuses = orderModel.statuses!;
        print(forPayments);
        if (forPayments)
          orderModel.orders!
              .removeWhere((element) => element.orderStatusId != 4);
        list.assignAll(orderModel.orders!);
      } else {
        S.sSnackBar(message: response.message, isError: true);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      update();
    }

    return true;
  }

  onTap(Order item) async {
    S.sSetRout(context!, page: OrderDetailPage(item, statuses));
  }

  onItemDelete(Order item) async {
    bool result = await Dialogs.showActionDialog(
          context!,
          title: 'confirmation'.tr,
          message: 'are_you_sure_to_want_to_delete_\nthis_order_?'.tr,
          okayBtn: 'yes'.tr,
        ) ??
        false;
    if (result) {
      ViewResponse response = await HttpCalls.callDeleteApi(
          EndPoints.order + '/' + item.id.toString(), null);
      if (response.status) {
        list.remove(item);
        S.sSnackBar(message: response.message);
      } else {
        S.sSnackBar(message: response.message, isError: true);
      }
    }
  }

  onEdit(Order item) {
    S.sSetRout(context!,
        page: CreateOrderPage(
          order: item,
        ));
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      list.assignAll(orderModel.orders!);
    } else {
      String val = value.toLowerCase();
      var temp = orderModel.orders!.where((element) =>
          (element.seller!.name ?? Str.NA).toLowerCase().contains(val) ||
          (element.customer!.nameEnglish != ""
                  ? element.customer!.nameEnglish
                  : Str.NA)
              .toLowerCase()
              .contains(val) ||
          (element.customer!.customerCode != ""
                  ? element.customer!.customerCode
                  : Str.NA)
              .toLowerCase()
              .contains(val) ||
          (S.sDateToString(element.orderDate ?? DateTime.now()) ?? Str.NA)
              .toLowerCase()
              .contains(val) ||
          (element.orderNo != "" ? element.orderNo : Str.NA)
              .toLowerCase()
              .contains(val));
      list.assignAll(temp);
    }
  }

  onPaymentTap(Order item) {
    // if(item.orderStatusId == 4)
    S.sSetRout(context!, page: () => ManagePaymentsPage(item));
  }
}
