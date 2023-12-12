import 'package:decisive_technology_products/controllers/customer/create_customer_controller.dart';
import 'package:decisive_technology_products/models/customer/customer_model.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../s.dart';
import '../../services/HttpCalls.dart';
import '../../utils/get_images.dart';

class CreateCustomerPage extends GetView<CreateCustomerController> {
  final CustomerModel? customer;
  const CreateCustomerPage({this.customer});

  @override
  Widget build(BuildContext context) {
    return makeBody(context);
  }

  Widget makeBody(context) {
    if (customer == null) {
      return buildBody(context);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('update_customer'.tr),
          centerTitle: true,
        ),
        body: buildBody(context),
      );
    }
  }

  Widget buildBody(context) {
    return GestureDetector(
      onTap: () => S.sFocusOut(context),
      child: GetBuilder<CreateCustomerController>(
          init: CreateCustomerController(customer: customer),
          dispose: (val) => Get.delete<CreateCustomerController>(),
          builder: (snapshot) {
            return PageView(
              controller: controller.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                PageOne(controller),
                PageTwo(controller),
                PageThree(controller),
              ],
            );
          }),
    );
  }
}

class PageOne extends StatelessWidget {
  final CreateCustomerController controller;
  const PageOne(this.controller);

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
                      hintText: 'name_in_english_*'.tr,
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
                      hintText: 'name_in_thai_*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      controller: controller.thaiName,
                      focusNode: controller.thaiNameFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.registrationFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'registration_number '.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.registrationNumber,
                      focusNode: controller.registrationFocus,
                      onEditingComplete: controller.pageOneNext,
                    ),
                    S.sDivider(),
                    controller.customer != null &&
                            controller.customer!.document != null &&
                            controller.customer!.document != ""
                        ? GetImage(
                            height: 170,
                            imagePath:
                                '${HttpCalls.sStorageURL}${controller.customer!.document}',
                          )
                        : S.sDivider()
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
  final CreateCustomerController controller;
  const PageTwo(this.controller);

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
                      hintText: 'building_name_*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.buildingName,
                      focusNode: controller.buildingNameFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.streetNumber1Focus),
                    ),
                    S.sDivider(),
                    Row(
                      children: [
                        Expanded(
                          child: TxtInput(
                            hintText: 'street_number_1*'.tr,
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
                            hintText: 'street_number_2*'.tr,
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
                      hintText: 'sub_district*'.tr,
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
                      hintText: 'district_*'.tr,
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
                      hintText: 'province*'.tr,
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
                      hintText: 'postal_code*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      controller: controller.postalCode,
                      focusNode: controller.postalCodeFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.countryFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'country*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.country,
                      focusNode: controller.countryFocus,
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
  final CreateCustomerController controller;
  const PageThree(this.controller);

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
                      'contact_information'.tr,
                      hasBold: true,
                      size: Siz.h2,
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'contact_person*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      controller: controller.contactPerson,
                      focusNode: controller.contactPersonFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.faxNumberFocus),
                    ),
                    S.sDivider(),
                    Row(
                      children: [
                        Expanded(
                          child: TxtInput(
                            hintText: 'fax_number*'.tr,
                            hasBorder: true,
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                            controller: controller.faxNumber,
                            focusNode: controller.faxNumberFocus,
                            onEditingComplete: () => S.sFocusOut(context,
                                focusNode: controller.mobileNumberFocus),
                          ),
                        ),
                        S.sVerticalDivider(),
                        Expanded(
                          child: TxtInput(
                            hintText: 'mobile_number*'.tr,
                            hasBorder: true,
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                            controller: controller.mobileNumber,
                            focusNode: controller.mobileNumberFocus,
                            onEditingComplete: () => S.sFocusOut(context,
                                focusNode: controller.lineIdFocus),
                          ),
                        ),
                      ],
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'line_id*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.lineId,
                      focusNode: controller.lineIdFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.remarksFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      hintText: 'remarks*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: controller.remarks,
                      focusNode: controller.remarksFocus,
                      onEditingComplete: () => S.sFocusOut(context,
                          focusNode: controller.contactPersonFocus),
                    ),
                    S.sDivider(),
                    TxtInput(
                      paddingHorizontal: 2,
                      //TODO
                      hintText: '   attachment*'.tr,
                      hasBorder: true,
                      maxLines: 1,
                      postFixIcon: Btn('choose_file'.tr),
                      controller: controller.attachment,
                      onTap: controller.onAttachmentTap,
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
                    child: Obx(() => controller.isSaving.isTrue
                        ? LoadingPro()
                        : Btn(
                            controller.customer == null
                                ? 'save'.tr
                                : 'update'.tr,
                            onPressed: controller.pageThreeSave,
                            width: double.infinity,
                            backgroundColor: Clr.colorPrimary,
                            textColor: Colors.white,
                          ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
