import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/order_model/order_model.dart';
import 'package:decisive_technology_products/models/payment/payment_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/pages/payment/add_payments.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../s.dart';

class PaymentController extends GetxController {
  final Order? item;

  final context = Get.context;

  var invoiceNumber = TextEditingController();
  var transferDate = TextEditingController();
  var amount = TextEditingController();
  var bankSlip = TextEditingController();

  XFile? file;

  PaymentController(this.item);

  var isLoading = true.obs;
  List<PaymentModel> listPayments = [];
  var list = <PaymentModel>[].obs;

  @override
  void onInit() {
    callInit();
    super.onInit();
  }

  void callInit() async {
    isLoading(true);
    ViewResponse response =
        await HttpCalls.callGetApi(EndPoints.getPayments + '${item!.id}');
    if (response.status) {
      listPayments = paymentModelFromJson(response.data);
      list.assignAll(listPayments);
      isLoading(false);
      update();
    } else {
      Get.back();
      S.sSnackBar(message: response.message ?? '');
    }
  }

  onTap(PaymentModel item) {}

  void onAddPressed() {
    S.sSetRout(context!,
        page: () => AddPaymentsPage(this), fullscreenDialog: true);
  }

  void onAttachmentTap() async {
    bool? result = await Dialogs.showCameraDialog(context!);
    if (result == null) return;
    if (result) {
      file = (await ImagePicker().pickImage(source: ImageSource.camera))!;
      bankSlip.text = file!.name;
    } else {
      file = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
      bankSlip.text = file!.name;
    }
  }

  onDateTap() async {
    DatePicker.showDatePicker(context!, showTitleActions: true,
        onConfirm: (date) {
      transferDate.text = S.sDateToString(date);
    }, currentTime: DateTime.now());
  }

  onSubmitPressed() async {
    S.sFocusOut(context!);
    if (invoiceNumber.text.isEmpty) {
      S.sSnackBar(message: 'Invoice required'.tr);
      return;
    }

    if (transferDate.text.isEmpty) {
      S.sSnackBar(message: 'Date required'.tr);
      return;
    }

    if (amount.text.isEmpty) {
      S.sSnackBar(message: 'Amount required'.tr);
      return;
    }

    // if(bankSlip.text.isEmpty){
    //   S.sSnackBar(message: 'Bank slip required'.tr);
    //   return;
    // }

    Map<String, String> params = {
      'amount': amount.text,
      'order_id': item!.id.toString(),
      'transaction_date': transferDate.text,
      'invoice_no': invoiceNumber.text,
    };
    Map<String, String> files = {};
    if (file != null) {
      files = {
        'picture': file!.path, //TODO
      };
    }
    isLoading(true);
    ViewResponse response =
        await HttpCalls.uploadFile('orders/add_payment', files, params: params);
    isLoading(false);
    if (response.status) {
      Get.back();
      S.sSnackBar(message: response.message);
      isLoading(true);
      callInit();
    } else {
      S.sSnackBar(message: response.message);
    }
  }
}
