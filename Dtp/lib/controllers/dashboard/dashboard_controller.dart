import 'package:decisive_technology_products/controllers/orders/manage_order_controller.dart';
import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/pages/change_password/change_password_page.dart';
import 'package:decisive_technology_products/pages/orders/create_order_page.dart';
import 'package:decisive_technology_products/pages/orders/manage_order_page.dart';
import 'package:decisive_technology_products/pages/customer/manage_customer.dart';
import 'package:decisive_technology_products/pages/customer/create_customer_page.dart';
import 'package:decisive_technology_products/pages/notification/notification_page.dart';
import 'package:decisive_technology_products/pages/reports/reports_page.dart';
import 'package:decisive_technology_products/pages/sales_man/create_sales_man_page.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import '../../s.dart';

class DashboardController extends GetxController {
  final advancedDrawerController = AdvancedDrawerController();
  var pageIndex = 1.obs;
  List titles = [
    'create_customer'.tr,
    'customers'.tr,
    'create_order'.tr,
    'orders'.tr,
    'payments'.tr,
    'notifications'.tr,
    'Reports'.tr,
    'change_password'.tr,
    'edit_sale_man'.tr
  ];
  var pages = [];
  var title = ''.obs;

  final context = Get.context;

  @override
  void onInit() {
    if (S.sObjLogin!.user!.isMenuLock.isTrue) {
      pageIndex(8);
    }
    title(titles[pageIndex.value]);
    pages = [
      CreateCustomerPage(),
      ManageCustomer(),
      CreateOrderPage(),
      ManageOrderPage(false),
      ManageOrderPage(true),
      NtfPage(),
      ReportsPage(),
      ChangePasswordPage(),
      CreateSalesManPage()
    ];
    super.onInit();
  }

  onPageChange(int i) {
    print(S.sObjLogin!.token);
    if (S.sObjLogin!.user!.isMenuLock.isTrue) {
      Dialogs.showInfoDialog(context!,
          title: 'info'.tr,
          body:
              'Your_account_is_not_approved_yet._Please_complete_your_Profile_and_wait_for_admin_to_approve_your_account'
                  .tr);
    } else {
      advancedDrawerController.hideDrawer();
      if (i == 3 || i == 4) {
        final controller = Get.put(ManageOrderController());
        controller.list.clear();
        controller.isLoading = true;
        update();
        controller.callInit(i == 3 ? false : true);
      }
      pageIndex(i);
      title(titles[i]);
    }
  }

  Future<bool> onWillPop() async {
    if (pageIndex.value != 1) {
      onPageChange(1);
      return Future.value(false);
    }
    bool? result = await Dialogs.showActionDialog(
      context!,
      title: 'exit_app'.tr,
      message: 'are_you_really_want_to_exit_app?'.tr,
      okayBtn: 'exit_app'.tr,
    );
    if (result == null) {
      return false;
    }
    if (result) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
