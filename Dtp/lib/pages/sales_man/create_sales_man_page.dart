import 'dart:io';

import 'package:decisive_technology_products/controllers/customer/create_customer_controller.dart';
import 'package:decisive_technology_products/controllers/sales_man/sales_man_controller.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class CreateSalesManPage extends GetView<CreateSalesManController> {
  @override
  Widget build(BuildContext context) {
    return makeBody(context);
  }

  Widget makeBody(context) {
    return buildBody(context);
  }

  Widget buildBody(context) {
    return GestureDetector(
      onTap: () => S.sFocusOut(context),
      child: GetBuilder<CreateSalesManController>(
          init: CreateSalesManController(),
          dispose: (val) => Get.delete<CreateCustomerController>(),
          builder: (snapshot) {
            return S.sObjLogin!.user!.isProfileSubmitted
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txt(
                          'your_account_is_not_approved_yet._please_complete_your_profile_and_wait_for_admin_to_approve_your_account'
                              .tr,
                          textColor: Clr.colorPrimary,
                          maxLine: 3,
                          size: Siz.h4,
                          textAlign: TextAlign.center,
                        ),
                        S.sDivider(),
                        Obx(() => controller.isRefreshing.isTrue
                            ? LoadingPro()
                            : IconButton(
                                onPressed: controller.onRefreshCall,
                                icon: Icon(
                                  Icons.refresh,
                                  color: Clr.colorPrimary,
                                  size: 50,
                                ))),
                      ],
                    ),
                  )
                : PageView(
                    controller: controller.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      PageOne(controller: controller),
                      PageTwo(controller: controller),
                      PageThree(controller: controller),
                      PageFour(controller: controller),
                    ],
                  );
          }),
    );
  }
}

class PageOne extends StatelessWidget {
  final CreateSalesManController controller;
  PageOne({required this.controller});
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
                      'basic_information'.tr,
                      hasBold: true,
                      size: Siz.h2,
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'name_in_english*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      controller: controller.engName,
                      focusNode: controller.engNameFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.thaiNameFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'name_in_thai*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      controller: controller.thaiName,
                      focusNode: controller.thaiNameFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.emailFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'email*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.email,
                      focusNode: controller.emailFocus,
                      enabled: false,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.phoneFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'phone*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      controller: controller.phone,
                      focusNode: controller.phoneFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.thaiIdFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'thai_id_number*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.thaiIdNumber,
                      focusNode: controller.thaiIdFocus,
                      onEditingComplete: controller.pageOneNext,
                    ),
                  ],
                ),
              ),
            ),
            S.sDivider(),
            Btn(
              'next'.tr,
              onPressed: controller.pageOneNext,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  final CreateSalesManController controller;
  PageTwo({required this.controller});

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
                      'address_information'.tr,
                      hasBold: true,
                      size: Siz.h2,
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'building_name'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      controller: controller.buildingName,
                      focusNode: controller.buildingNameFocus,
                      keyboardType: TextInputType.text,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.streetNumber1Focus),
                    ),
                    S.sDivider(),
                    Row(
                      children: [
                        Expanded(
                          child: TxtInput(
                            hintText: 'street_number_1'.tr,
                            hasBorder: true,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            controller: controller.streetNumber1,
                            focusNode: controller.streetNumber1Focus,
                            onEditingComplete: () => S.sFocusOut(context,
                                focusNode: controller.streetNumber2Focus),
                          ),
                        ),
                        S.sVerticalDivider(),
                        Expanded(
                          child: TxtInput(
                            hintText: 'street_number_2'.tr,
                            hasBorder: true,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            controller: controller.streetNumber2,
                            focusNode: controller.streetNumber2Focus,
                            onEditingComplete: () => S.sFocusOut(context,
                                focusNode: controller.subDistrictFocus),
                          ),
                        ),
                        S.sDivider(),
                      ],
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'sub_district'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.subDistrict,
                      focusNode: controller.subDistrictFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.districtFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'district'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.district,
                      focusNode: controller.districtFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.provinceFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'province'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.province,
                      focusNode: controller.provinceFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.postalCodeFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'postal_code'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      controller: controller.postalCode,
                      focusNode: controller.postalCodeFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.lineIdFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'line_id'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.lineId,
                      focusNode: controller.lineIdFocus,
                      onEditingComplete: controller.pageTwoNext,
                    ),
                  ],
                ),
              ),
            ),
            S.sDivider(),
            Row(
              children: [
                Expanded(
                    child: Btn(
                  'back'.tr,
                  onPressed: controller.pageBack,
                  width: double.infinity,
                )),
                S.sVerticalDivider(),
                Expanded(
                    child: Btn(
                  'next'.tr,
                  onPressed: controller.pageTwoNext,
                  width: double.infinity,
                  backgroundColor: Clr.colorPrimary,
                  textColor: Colors.white,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  final CreateSalesManController controller;
  PageThree({required this.controller});

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
                      'bank_information'.tr,
                      hasBold: true,
                      size: Siz.h2,
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'bank_name*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.bankName,
                      focusNode: controller.bankNameFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.bankBookFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'bank_branch*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.bankBranch,
                      focusNode: controller.bankBranchFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.bankAccountFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'bank_account*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.bankAccount,
                      focusNode: controller.bankAccountFocus,
                      onEditingComplete: () => S.sFocusOut(context),
                    ),
                    S.sDivider(),
                    GetBuilder<CreateSalesManController>(builder: (snapshot) {
                      return GestureDetector(
                        onTap: controller.onBankBookTap,
                        child: Container(
                          decoration: S.sBoxDecoration(
                              borderColor: Clr.colorPrimary, hasBorder: true),
                          clipBehavior: Clip.antiAlias,
                          height: 150,
                          width: double.infinity,
                          child: controller.bankBook == null
                              ? Column(
                                  children: [
                                    S.sDivider(height: 8),
                                    Row(
                                      children: [
                                        S.sVerticalDivider(),
                                        Txt(
                                          'bank_book*'.tr,
                                          textColor:
                                              Colors.black.withOpacity(0.6),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.camera_enhance,
                                      color: Clr.colorGreyButton,
                                    ),
                                    S.sDivider(height: 8),
                                    Txt(
                                      'upload_photo'.tr,
                                      textColor: Clr.colorGreyButton,
                                    ),
                                    Spacer(),
                                    S.sDivider(height: 8),
                                    Txt(''),
                                  ],
                                )
                              : Image.file(
                                  File(controller.bankBook!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    }),
                    S.sDivider(),
                  ],
                ),
              ),
            ),
            S.sDivider(),
            Row(
              children: [
                Expanded(
                    child: Btn(
                  'back'.tr,
                  onPressed: controller.pageBack,
                  width: double.infinity,
                )),
                S.sVerticalDivider(),
                Expanded(
                    child: Btn(
                  'next'.tr,
                  onPressed: controller.pageThreeSave,
                  width: double.infinity,
                  backgroundColor: Clr.colorPrimary,
                  textColor: Colors.white,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageFour extends StatelessWidget {
  final CreateSalesManController controller;
  PageFour({required this.controller});

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
                      'identity_verification'.tr,
                      hasBold: true,
                      size: Siz.h2,
                    ),
                    S.sDivider(),
                    GetBuilder<CreateSalesManController>(builder: (snapshot) {
                      return GestureDetector(
                        onTap: controller.onIdCardFront,
                        child: Container(
                          decoration: S.sBoxDecoration(
                              borderColor: Clr.colorPrimary, hasBorder: true),
                          clipBehavior: Clip.antiAlias,
                          height: 150,
                          width: double.infinity,
                          child: controller.idCardFront == null
                              ? Column(
                                  children: [
                                    S.sDivider(height: 8),
                                    Row(
                                      children: [
                                        S.sVerticalDivider(),
                                        Txt(
                                          'id_card_front*'.tr,
                                          textColor:
                                              Colors.black.withOpacity(0.6),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.camera_enhance,
                                      color: Clr.colorGreyButton,
                                    ),
                                    S.sDivider(height: 8),
                                    Txt(
                                      'upload_photo'.tr,
                                      textColor: Clr.colorGreyButton,
                                    ),
                                    Spacer(),
                                    S.sDivider(height: 8),
                                    Txt(''),
                                  ],
                                )
                              : Image.file(
                                  File(controller.idCardFront!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    }),
                    S.sDivider(),
                    GetBuilder<CreateSalesManController>(builder: (snapshot) {
                      return GestureDetector(
                        onTap: controller.onIdCardBack,
                        child: Container(
                          decoration: S.sBoxDecoration(
                              borderColor: Clr.colorPrimary, hasBorder: true),
                          clipBehavior: Clip.antiAlias,
                          height: 150,
                          width: double.infinity,
                          child: controller.idCardBack == null
                              ? Column(
                                  children: [
                                    S.sDivider(height: 8),
                                    Row(
                                      children: [
                                        S.sVerticalDivider(),
                                        Txt(
                                          'id_card_back*'.tr,
                                          textColor:
                                              Colors.black.withOpacity(0.6),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.camera_enhance,
                                      color: Clr.colorGreyButton,
                                    ),
                                    S.sDivider(height: 8),
                                    Txt(
                                      'upload_photo'.tr,
                                      textColor: Clr.colorGreyButton,
                                    ),
                                    Spacer(),
                                    S.sDivider(height: 8),
                                    Txt(''),
                                  ],
                                )
                              : Image.file(
                                  File(controller.idCardBack!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            S.sDivider(),
            Row(
              children: [
                Expanded(
                    child: Btn(
                  'back'.tr,
                  onPressed: controller.pageBack,
                  width: double.infinity,
                )),
                S.sVerticalDivider(),
                Expanded(
                  child: Obx(
                    () => controller.isSaving.isTrue
                        ? LoadingPro()
                        : Btn(
                            'save'.tr,
                            onPressed: controller.pageFourSave,
                            width: double.infinity,
                            backgroundColor: Clr.colorPrimary,
                            textColor: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
