import 'package:decisive_technology_products/controllers/orders/create_order_controller.dart';
import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/customer/customer_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/pages/customer/create_customer_page.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../s.dart';

class ManageCustomerController extends GetxController {
  final context = Get.context;
  bool isLoading = true;
  List<CustomerModel> customerModel = [];
  var list = <CustomerModel>[].obs;

  var slidableController = SlidableController();

  var refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  var searchTxt = TextEditingController();

  @override
  void onInit() {
    callInit();
    super.onInit();
  }

  Future<bool> callInit() async {
    try {
      ViewResponse response = await HttpCalls.callGetApi(EndPoints.customers);
      if (response.status) {
        customerModel = customerModelFromJson(response.data);
        list.assignAll(customerModel);
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

  onEdit(CustomerModel item) async {
    Get.delete<CreateOrderController>();
    S.sSetRout(context!, page: () => CreateCustomerPage(customer: item));
  }

  onItemDelete(CustomerModel item) async {
    bool result = await Dialogs.showActionDialog(
          context!,
          title: 'confirmation'.tr,
          message: 'Are_you_sure_to_want_to_delete_\nthis_customer_?'.tr,
          okayBtn: 'yes'.tr,
        ) ??
        false;
    if (result) {
      ViewResponse response = await HttpCalls.callDeleteApi(
          EndPoints.customers + '/' + item.id.toString(), null);
      if (response.status) {
        list.remove(item);
        S.sSnackBar(message: response.message);
      } else {
        S.sSnackBar(message: response.message, isError: true);
      }
    }
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      list.assignAll(customerModel);
    } else {
      String val = value.toLowerCase();
      var temp = customerModel.where((element) =>
          (element.nameEnglish ?? "").toLowerCase().contains(val) ||
          (element.nameThai ?? "").toLowerCase().contains(val) ||
          (element.registrationNo ?? Str.NA).toLowerCase().contains(val) ||
          (element.customerCode ?? Str.NA).toLowerCase().contains(val) ||
          (element.mobileNumber ?? Str.NA).toLowerCase().contains(val));
      list.assignAll(temp);
    }
  }
}
