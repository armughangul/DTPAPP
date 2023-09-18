import 'package:decisive_technology_products/controllers/notification/notification_controller.dart';
import 'package:decisive_technology_products/main.dart';
import 'package:decisive_technology_products/models/notification/notification_model.dart';
import 'package:decisive_technology_products/services/HttpCalls.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/get_images.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/loading.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class NtfPage extends GetView<NtfController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NtfController>(
        init: NtfController(),
        dispose: (val) => Get.delete<NtfController>(),
        builder: (snapshot) {
          return Scaffold(
            floatingActionButton: _buildFloatingButton(),
            body: snapshot.isLoading
                ? LoadingPro()
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Obx(
                          () => Row(
                            children: [
                              Expanded(
                                  child: Btn(
                                'notifications'.tr,
                                borderRadius: 0,
                                textColor: controller.filterBy.value.isEqual(0)
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor:
                                    controller.filterBy.value.isEqual(0)
                                        ? Clr.colorPrimary
                                        : null,
                                onPressed: () => controller.onFilter(0),
                              )),
                              S.sVerticalDivider(),
                              Expanded(
                                  child: Btn(
                                'messages'.tr,
                                borderRadius: 0,
                                textColor: controller.filterBy.value.isEqual(1)
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor:
                                    controller.filterBy.value.isEqual(1)
                                        ? Clr.colorPrimary
                                        : null,
                                onPressed: () => controller.onFilter(1),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => controller.filterBy.value.isEqual(0)
                          ? Container(
                              margin: EdgeInsets.only(
                                  bottom: 10, top: 0, left: 16, right: 16),
                              decoration: S.sBoxDecoration(
                                filledColor: Colors.white,
                                shadowRadius: 10,
                                shadowColor: Colors.black.withOpacity(0.2),
                              ),
                              child: TxtInput(
                                hintText: 'search'.tr,
                                hasBorder: true,
                                postFixIcon: Icon(
                                  Icons.search,
                                  color: Clr.colorPrimary,
                                ),
                                controller: controller.searchTxt,
                                onChanged: controller.onSearch,
                              ),
                            )
                          : Container()),
                      Obx(() => controller.filterBy.value.isEqual(0)
                          ? Expanded(
                              child: Obx(
                                () => ListView.separated(
                                  itemCount: controller.list.length,
                                  reverse: controller.filterBy.value.isEqual(0)
                                      ? false
                                      : true,
                                  controller: controller.scrollController,
                                  itemBuilder: (context, index) {
                                    final item = controller.list[index];
                                    bool isMine = item.senderId ==
                                        S.sObjLogin!.user!.id.toString();
                                    bool isMessage = item.isRegular == '0';
                                    return GestureDetector(
                                      onTap: item.type
                                          ? () =>
                                              controller.onMessageDetail(item)
                                          : null,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: (isMine && isMessage)
                                                ? 100
                                                : 16,
                                            right: (!isMine && isMessage)
                                                ? 100
                                                : 16,
                                            top: 8,
                                            bottom: 8),
                                        padding: EdgeInsets.all(16),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: S.sBoxDecoration(
                                            filledColor: Colors.white,
                                            shadowColor: Colors.black
                                                .withOpacity(S.opacity),
                                            shadowRadius: 10),
                                        height: item.type ? null : 200,
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Txt(
                                                  item.sender!.name,
                                                  hasBold: true,
                                                  checkOverflow: true,
                                                )),
                                                Txt(S.sGetDateTimeCustomFormat(
                                                    item.createdAt!,
                                                    'dd-MMM-yy, hh:mm a')),
                                              ],
                                            ),
                                            S.sDivider(),
                                            if (item.type)
                                              Txt((item.message ?? "").length <
                                                      140
                                                  ? item.message ?? ""
                                                  : (item.message ?? "")
                                                      .substring(0, 139)),
                                            if (!item.type) ...[
                                              if ((item.message ?? "")
                                                  .endsWith('pdf'))
                                                GetImage(
                                                  imagePath:
                                                      'assets/images/pdf.png',
                                                  isAssets: true,
                                                  height: 130,
                                                  width: deviceWidth,
                                                  fit: BoxFit.fitHeight,
                                                  onTap: () =>
                                                      controller.onImageTap(
                                                          item.message ?? ""),
                                                )
                                              else
                                                GetImage(
                                                  imagePath:
                                                      HttpCalls.sStorageURL +
                                                          (item.message ?? ""),
                                                  height: 130,
                                                  width: deviceWidth,
                                                  fit: BoxFit.cover,
                                                  onTap: () =>
                                                      controller.onImageTap(
                                                          item.message ?? ""),
                                                ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 8,
                                    );
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: controller.list2.length,
                                  itemBuilder: (context, index) {
                                    Message model = controller.list2[index];
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      padding: EdgeInsets.all(16),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: S.sBoxDecoration(
                                          filledColor: Colors.white,
                                          shadowColor: Colors.black
                                              .withOpacity(S.opacity),
                                          shadowRadius: 10),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Txt(
                                            'hi'.tr +
                                                ', ${S.sObjLogin!.user!.name}',
                                            hasBold: true,
                                            checkOverflow: true,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Txt(
                                            model.message ?? "",
                                            hasBold: false,
                                            checkOverflow: true,
                                            maxLine: 3,
                                          )
                                        ],
                                      ),
                                    );
                                  }))),
                      Obx(
                        () => controller.filterBy.value.isEqual(1)
                            ? S.sDivider(height: 0)
                            : Container(),
                      )
                    ],
                  ),
          );
        });
  }

  _buildFloatingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // AnimatedOpacity(
        //   opacity: controller.filterBy.value.toDouble(),
        //   duration: 700.milliseconds,
        //   child: Container(
        //     child: FloatingActionButton(
        //       heroTag: "btn1".tr,
        //       backgroundColor: Clr.colorPrimary,
        //       onPressed: controller.onNewTap,
        //       child: Icon(
        //         Icons.add,
        //         color: controller.filterBy.value.isEqual(0)
        //             ? Clr.colorTransparent
        //             : Colors.white,
        //       ),
        //       // label: Txt('New Message', textColor: controller.filterBy.value.isEqual(0)?Clr.colorTransparent: Colors.white,),
        //     ),
        //   ),
        // ),
        S.sVerticalDivider(width: 8),
        FloatingActionButton(
          heroTag: "btn2".tr,
          backgroundColor: Clr.colorPrimary,
          onPressed: () => controller.callInit(controller.filterBy.value),
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
