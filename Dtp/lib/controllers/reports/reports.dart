import 'package:decisive_technology_products/models/reports.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../s.dart';

class ReportsController extends GetxController {
  final context = Get.context;
  var isLoading = false.obs;
  var searchTxt = TextEditingController();
  var refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();
  var list = <ReportsModel>[].obs;
  DateTime? fromDateInDate;
  var fromDate = TextEditingController();
  var toDate = TextEditingController();

  Future<void> callInit() async {
    Map params = {
      'from_date': fromDate.text,
      'to_date': toDate.text,
    };

    isLoading(true);
    update();
    ViewResponse response =
        await HttpCalls.callPostApi('orders/payment_report', params);
    isLoading(false);
    if (response.status) {
      list.assignAll(reportsModelFromJson(response.data));
    } else {
      S.sSnackBar(message: response.message);
    }
    update();
    return;
  }

  onToDate() {
    DatePicker.showDatePicker(context!,
        showTitleActions: true, minTime: fromDateInDate, onConfirm: (date) {
      toDate.text = S.sDateToString(date);
      callInit();
    }, currentTime: DateTime.now());
  }

  onFromDate() {
    DatePicker.showDatePicker(context!, showTitleActions: true,
        onConfirm: (date) {
      fromDateInDate = date;
      fromDate.text = S.sDateToString(date);
      update();
    }, currentTime: DateTime.now());
  }
}
