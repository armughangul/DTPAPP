import 'dart:collection';
import 'dart:io';

import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/notification/notification_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/pages/notification/new_message.dart';
import 'package:decisive_technology_products/pages/notification/show_message.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/full_photo.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../models/customer/customer_model.dart';
import '../../models/order_model/order_model.dart';
import '../../s.dart';

class NtfController extends GetxController {
  var filterBy = 0.obs;
  NtfModel? ntfModel;
  List<Message> list = <Message>[].obs;
  List<Message> list2 = <Message>[].obs;
  bool isLoading = true;
  final context = Get.context;

  var isSendingNew = false.obs;

  var message = TextEditingController();

  var attachment = TextEditingController();

  File? file;

  var scrollController = ScrollController();

  var refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  var searchTxt = TextEditingController();
  OrderModel orderModel = OrderModel();
  var customerList = <CustomerModel>[];
  @override
  void onInit() {
    callInit(0);
    super.onInit();
  }

  Future<bool> callInit(int filter) async {
    isLoading = true;
    update();
    ViewResponse response = await HttpCalls.callGetApi(EndPoints.messages);
    if (response.status) {
      ntfModel = ntfModelFromJson(response.data);
      onFilter(filter);
      // scrollController.animateTo(0.0,
      //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      isLoading = false;
      update();
      orderListRequest(false);
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }

    return true;
  }

  Future<bool> orderListRequest(forPayments) async {
    try {
      ViewResponse response = await HttpCalls.callGetApi(EndPoints.order);
      if (response.status) {
        orderModel = orderModelFromJson(response.data);
        if (forPayments)
          orderModel.orders!
              .removeWhere((element) => element.orderStatusId != 4);
        customerListRequest(orderModel);
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

  Future<bool> customerListRequest(OrderModel orderModel) async {
    try {
      ViewResponse response = await HttpCalls.callGetApi(EndPoints.customers);
      if (response.status) {
        customerList = customerModelFromJson(response.data);
        HashMap<int, Order> userOrderMap = new HashMap();
        if (orderModel.orders != null) {
          for (int i = 0; i < orderModel.orders!.length; i++) {
            Order findedOrder = orderModel.orders![i];
            Order? previousOrder = userOrderMap[findedOrder.customerId];
            if (previousOrder != null) {
              final today = DateTime.now();
              int minutes1 = today.difference(findedOrder.createdAt!).inMinutes;
              print("newObj minutes");
              print(minutes1);
              int minutes2 =
                  today.difference(previousOrder.createdAt!).inMinutes;
              print("oldObj minutes");
              print(minutes2);
              if (minutes1 < minutes2) {
                userOrderMap[findedOrder.customerId] = findedOrder;
              }
            } else {
              userOrderMap[findedOrder.customerId] = findedOrder;
            }
          }
        }
        list2 = [];
        userOrderMap.entries.forEach(
          (element) {
            final today = DateTime.now();
            final secondDate = element.value.createdAt!;
            // int minutes1 = today.difference(element.value.createdAt!).inDays;
            final monthsDifference = (today.year - secondDate.year) * 12 +
                today.month -
                secondDate.month;
            print(monthsDifference);
            if (monthsDifference >= 2) {
              String name = element.value.customer?.nameEnglish ?? "";
              list2.add(new Message(
                  message: "yourCustomer".tr + ' $name ' + "didNotOrder".tr,
                  createdAt: element.value.createdAt));
            }
          },
        );
        print(userOrderMap.length);
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

  void onNewTap() async {
    if (filterBy.value == 1) {
      await S.sSetRout(context!,
          page: NewMessagePage(this), fullscreenDialog: true);
      file = null;
      attachment.clear();
      message.clear();
    }
  }

  onFilter(int i) {
    filterBy(i);
    if (i == 0) {
      list.assignAll(
          ntfModel!.messages!.where((element) => element.isRegular == '1'));
    } else {
      list.assignAll(
          ntfModel!.messages!.where((element) => element.isRegular == '0'));
    }
  }

  void onSendTap() async {
    if (message.text.isEmpty && file == null) {
      S.sSnackBar(message: 'please_enter_message_or_attach_the_file'.tr);
      return;
    }

    isSendingNew(true);
    if (message.text.isNotEmpty) {
      //TODO
      ViewResponse response = await HttpCalls.callPostApi(
          EndPoints.messages, {'type': '1', 'message': message.text});
      if (response.status) {
        message.clear();
        callInit(1);
        Get.back();
      } else {
        S.sSnackBar(message: response.message, isError: true);
      }
    }
    if (file != null) {
      ViewResponse response = await HttpCalls.uploadFile(
          EndPoints.messages, {'message': file!.path},
          params: {'type': '0'});
      if (response.status) {
        message.clear();
        file = null;
        attachment.clear();
        callInit(1);

        Get.back();
      } else {
        S.sSnackBar(message: response.message, isError: true);
      }
    }

    isSendingNew(false);
  }

  void onAttachmentTap() async {
    S.sFocusOut(context!);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
    );

    if (result != null) {
      file = File(result.files.single.path ?? "");
      attachment.text = '  ' + result.files.single.name;
    } else {
      // User canceled the picker
    }
  }

  void onImageTap(String image) {
    if (image.endsWith('pdf')) {
      S.sLaunchURL(HttpCalls.sStorageURL + image, context!,
          urlType: URLType.WEB);
    } else {
      S.sSetRout(context!, page: FullPhoto(HttpCalls.sStorageURL + image));
    }
  }

  onMessageDetail(Message item) {
    S.sSetRout(context!, page: ShowMessagePage(item));
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      onFilter(0);
    } else {
      String val = value.toLowerCase();
      var temp = ntfModel!.messages!.where((element) =>
          ((S.sGetDateTimeCustomFormat(element.createdAt ?? DateTime.now(),
                          'dd-MMM-yy, hh:mm a') ??
                      Str.NA)
                  .toLowerCase()
                  .contains(val) ||
              (element.message ?? Str.NA).toLowerCase().contains(val)) &&
          element.isRegular == '1');
      list.assignAll(temp);
    }
  }
}
