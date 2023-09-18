import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/order_model/order_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../s.dart';

class OrderDetailController extends GetxController {
  final List<Status> statuses;
  final Order order;

  final context = Get.context;

  XFile? file;

  var currentIndex = 0.obs;

  OrderDetailController(this.statuses, this.order);
  List<DropdownMenuItem<int>> listStatuses = [];
  List<DropdownMenuItem<int>> listMoneyReceived = [
    DropdownMenuItem<int>(
      value: 0,
      child: Text('no'.tr),
    ),
    DropdownMenuItem<int>(
      value: 1,
      child: Text('yes'.tr),
    ),
  ];
  var selectedStatus = 0.obs;
  var selectedMoneyReceivedStatus = 0.obs;

  var isSaving = false.obs;

  var filter = 0.obs;

  var pageController = PageController();

  var invoiceNo = TextEditingController();
  var shippingDate = TextEditingController();
  var invoiceDueDate = TextEditingController();
  var shipmentTrackingCode = TextEditingController();
  var attachment = TextEditingController();
  var comments = TextEditingController();

  var invoiceNoFocus = FocusNode();
  var shippingDateFocus = FocusNode();
  var invoiceDueDateFocus = FocusNode();
  var shipmentTrackingCodeFocus = FocusNode();
  var commentsFocus = FocusNode();

  onFilterChange(int i) {
    filter(i);
    pageController.animateToPage(i, duration: 1.seconds, curve: Curves.ease);
  }

  @override
  void onInit() {
    listStatuses.assignAll(statuses.map((e) => DropdownMenuItem<int>(
          value: e.id,
          child: Text(e.name),
        )));
    fillFata();
    super.onInit();
  }

  fillFata() {
    selectedStatus(order.status!.id);
    selectedMoneyReceivedStatus(order.moneyReceived == '0' ? 0 : 1);
    invoiceNo.text = order.invoiceNo;
    shippingDate.text = S.sDateToString(order.shippingDate);
    invoiceDueDate.text = S.sDateToString(order.invoiceDueDate);
    shipmentTrackingCode.text = order.shipmentTrackingCode;
    comments.text = order.comments;
  }

  void onShippingDate() {
    DatePicker.showDatePicker(
      context!,
      showTitleActions: true,
      minTime: DateTime(2018, 1, 1),
      onConfirm: (date) {
        shippingDate.text = S.sDateToString(date);
        S.sFocusOut(context!);
      },
      currentTime: DateTime.now(),
    );
  }

  void onInvoiceDate() {
    DatePicker.showDatePicker(
      context!,
      showTitleActions: true,
      minTime: DateTime(2018, 1, 1),
      onConfirm: (date) {
        invoiceDueDate.text = S.sDateToString(date);
        S.sFocusOut(context!);
      },
      currentTime: DateTime.now(),
    );
  }

  void onAttachmentTap() async {
    bool? result = await Dialogs.showCameraDialog(context!);
    if (result == null) return;
    if (result) {
      file = await ImagePicker().pickImage(source: ImageSource.camera);
      attachment.text = file!.name;
    } else {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      attachment.text = file!.name;
    }
  }

  void onSaveTap() async {
    if (selectedStatus.value == 0) {
      S.sSnackBar(
          message: 'status_must_be_selected!'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Map<String, String> params = {
      'order_status_id': selectedStatus.value.toString(),
      'invoice_no': invoiceNo.text,
      'invoice_due_date': invoiceDueDate.text,
      'shipping_date': shippingDate.text,
      'shipment_tracking_code': shipmentTrackingCode.text,
      'comments': comments.text,
      'money_received': selectedMoneyReceivedStatus.value.toString(),
    };

    Map<String, String> files = {};
    if (attachment.text.isNotEmpty) {
      files['invoice_picture'] = file!.path; //TODO
    }
    isSaving(true);
    ViewResponse response = await HttpCalls.uploadFile(
        EndPoints.orderUpdateStatus + '/${order.id}', files,
        params: params);
    if (response.status) {
      S.sSnackBar(message: response.message);
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }
    isSaving(false);
  }

  void onNextTap() {
    print(order.details!.length - 1);
    print(currentIndex.value);

    if ((currentIndex.value < order.details!.length - 1)) {
      currentIndex.value++;
      print(order.details!.length);
      print(currentIndex.value);
    }
  }

  void onBackTap() {
    print(order.details!.length - 1);
    print(currentIndex.value);
    if (currentIndex.value >= (order.details!.length - 1)) {
      currentIndex.value--;
      print(order.details!.length);
      print(currentIndex.value);
    }
  }
}
