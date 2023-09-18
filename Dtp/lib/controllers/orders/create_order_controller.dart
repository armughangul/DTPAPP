import 'package:decisive_technology_products/controllers/dashboard/dashboard_controller.dart';
import 'package:decisive_technology_products/dialogs/show_dialogs.dart';
import 'package:decisive_technology_products/models/order_model/order_meta_data.dart';
import 'package:decisive_technology_products/models/order_model/order_model.dart';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/pages/orders/dropdown_search_page.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import '../../s.dart';

class ProductModel {
  List<DropdownMenuItem<int>> listProduct;
  RxInt selectedProduct = 0.obs;
  var quantity = TextEditingController();
  var unitPrice = TextEditingController();
  var quantityFocus = FocusNode();
  var productFocus = FocusNode();
  var unitPriceFocus = FocusNode();

  ProductModel(
      {required this.listProduct,
      required this.selectedProduct,
      required this.quantity,
      required this.unitPrice});
}

class CreateOrderController extends GetxController {
  final Order? order;
  CreateOrderController({required this.order});
  final context = Get.context;
  bool isLoading = true;
  var isOrdering = false.obs;

  OrderMetaDataModel? orderMetaDataModel;
  List<DropdownMenuItem<int>> listCustomer = [];
  List<DropdownMenuItem<int>> listProduct = [];

  // Page One

  var selectedCustomer = 0.obs;
  var orderDate = TextEditingController();
  var creditDays = TextEditingController();
  var isReceipt = false.obs;
  var isCash = false.obs;
  var isVatInvoice = false.obs;
  // var selectedProduct = 0.obs;
  // var quantity = TextEditingController();
  // var unitPrice = TextEditingController();

  var customerCodeFocus = FocusNode();
  var orderDateFocus = FocusNode();
  var creditDaysFocus = FocusNode();

  List<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    callMetaData();
    super.onInit();
  }

  callMetaData() async {
    isLoading = true;
    update();
    ViewResponse response = await HttpCalls.callGetApi(EndPoints.create);
    if (response.status) {
      orderMetaDataModel = orderMetaDataModelFromJson(response.data);
      listProduct.assignAll(
          orderMetaDataModel!.products!.map((e) => DropdownMenuItem<int>(
                value: e.id,
                child: Txt(
                  '${e.productName} - ${e.productCode}',
                  size: 12,
                ),
              )));
      listCustomer.assignAll(
          orderMetaDataModel!.customers!.map((e) => DropdownMenuItem<int>(
                value: e.id,
                child: Txt(
                  '${e.nameEnglish} - ${e.customerCode ?? ''}',
                  size: 12,
                ),
              )));

      if (order != null) {
        callFillData();
      } else {
        orderDate.text = S.sDateToString(DateTime.now());
        if (listProduct.isNotEmpty) {
          final product = ProductModel(
            listProduct: listProduct,
            selectedProduct: 0.obs,
            unitPrice: TextEditingController(),
            quantity: TextEditingController(),
          );
          products.add(product);
        }
      }

      update();
      // orderMetaDataModel.products
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }
  }

  void callFillData() {
    selectedCustomer(order?.customerId);
    orderDate.text = S.sDateToString(order?.orderDate ?? DateTime.now());
    creditDays.text = (order?.creditDays ?? '').toString();
    isReceipt(order?.receipt);
    isVatInvoice(order?.isVatInvoice);
    order?.details!.forEach((element) {
      products.add(ProductModel(
        listProduct: listProduct,
        selectedProduct: int.parse(element.productId).obs,
        quantity: TextEditingController(text: element.qty),
        unitPrice: TextEditingController(text: element.price),
      ));
    });
    // selectedProduct(order.details[0].product.id);
    // quantity.text = order.details[0].qty;
    // unitPrice.text = order.details[0].price;
  }

  void onPageSave(Order? order) async {
    S.sFocusOut(context!);

    if (2 == 2) {
      if (selectedCustomer.value == 0) {
        S.sSnackBar(
            message: 'customer_must_be_selected!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        // S.sFocusOut(context, focusNode: customerCodeFocus);
        return;
      }

      if (orderDate.text.isEmpty) {
        S.sSnackBar(
            message: 'order_date_must_be_selected!'.tr,
            snackPosition: SnackPosition.BOTTOM);
        // S.sFocusOut(context, focusNode: orderDateFocus);
        return;
      }

      bool haveIssue = false;
      products.forEach((e) {
        if (e.selectedProduct.value == 0) {
          S.sSnackBar(
              message: 'product_must_be_selected!'.tr,
              snackPosition: SnackPosition.BOTTOM);
          // S.sFocusOut(context, focusNode: e.productFocus);
          haveIssue = true;
          return;
        }

        if (e.quantity.text.isEmpty) {
          S.sSnackBar(
              message: 'quantity_should_not_be_empty!'.tr,
              snackPosition: SnackPosition.BOTTOM);
          S.sFocusOut(context!, focusNode: e.quantityFocus);
          haveIssue = true;
          return;
        }

        if (e.unitPrice.text.isEmpty) {
          S.sSnackBar(
              message: 'unit_price_should_not_be_empty!'.tr,
              snackPosition: SnackPosition.BOTTOM);
          S.sFocusOut(context!, focusNode: e.unitPriceFocus);
          haveIssue = true;
          return;
        }
      });
      if (haveIssue) return;
    }

    Map params = {
      'customer_id': selectedCustomer.value,
      'order_date': orderDate.text,
      'product_id': products.map((e) => e.selectedProduct.value).toList(),
      'qty': products.map((e) => e.quantity.text).toList(),
      'unit_price': products.map((e) => e.unitPrice.text).toList(),
      'is_vat_invoice': isVatInvoice.value,
      'credit_days': creditDays.text,
      'receipt': isReceipt.value,
      'is_cash': isCash.value,
    };

    isOrdering(true);
    ViewResponse response = await HttpCalls.callPostApi(
        order == null
            ? EndPoints.order
            : EndPoints.orderUpdate + '/${order.id}',
        params);
    isOrdering(false);
    if (response.status) {
      await Dialogs.showInfoDialog(context!, body: response.message);
      Get.put(DashboardController()).onPageChange(3);
      Get.back();
    } else {
      S.sSnackBar(message: response.message, isError: true);
    }
  }

  void onDateTap() {
    DatePicker.showDatePicker(context!,
        showTitleActions: true, minTime: DateTime.now(), onConfirm: (date) {
      orderDate.text = S.sDateToString(date);
    }, currentTime: DateTime.now());
  }

  void onIsVatChange(bool? value) {
    isVatInvoice(value);
  }

  void addMoreProduct() {
    final product = ProductModel(
      listProduct: listProduct,
      selectedProduct: 0.obs,
      unitPrice: TextEditingController(),
      quantity: TextEditingController(),
    );
    products.add(product);
  }

  removeProduct(ProductModel e) {
    products.remove(e);
  }

  void onCustomerSearchTap() async {
    int? id = await S.sSetRout(context!,
        page: () => DropDownSearch(orderMetaDataModel?.customers));
    if (id != null) selectedCustomer(id);
  }
}
