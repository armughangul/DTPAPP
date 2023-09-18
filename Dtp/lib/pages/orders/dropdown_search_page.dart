import 'package:decisive_technology_products/models/order_model/order_meta_data.dart';
import 'package:decisive_technology_products/utils/input.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../controllers/dashboard/dashboard_controller.dart';
import '../../s.dart';
import '../../utils/CommonManager.dart';

class DropDownSearch extends StatefulWidget {
  final List<Customer>? list;
  const DropDownSearch(this.list);

  @override
  State<DropDownSearch> createState() => _DropDownSearchState();
}

class _DropDownSearchState extends State<DropDownSearch> {
  var searchText = TextEditingController();
  List<Customer>? customers;
  @override
  void initState() {
    print(widget.list?.length);
    customers = widget.list?.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TxtInput(
              hintText: 'search'.tr,
              hasBorder: true,
              controller: searchText,
              onChanged: onChange,
            ),
            S.sDivider(),
            Expanded(
              child: (customers != null && customers!.length > 0)
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        itemCount: customers!.length,
                        itemBuilder: (context, index) {
                          final item = customers![index];
                          return GestureDetector(
                            onTap: () => Get.back(result: item.id),
                            child: Txt(
                              '${item.nameEnglish} - ${item.customerCode ?? ''}',
                              size: 20,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              S.sDivider(),
                              Divider(
                                color: Clr.colorPrimary,
                              ),
                              S.sDivider(),
                            ],
                          );
                        },
                      ),
                    )
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          CommonManager.manager.controller?.onPageChange(0);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          decoration: BoxDecoration(
                              color: Clr.colorPrimary,
                              borderRadius: BorderRadius.circular(7)),
                          child: Txt(
                            'create_customer'.tr,
                            textColor: Colors.white,
                            hasBold: true,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void onChange(String value) {
    if (value.isEmpty) {
      setState(() {
        customers = widget.list?.toList();
      });
    } else {
      setState(() {
        if (widget.list != null) {
          customers = widget.list!
              .where((element) => (element.nameEnglish
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                  (element.customerCode ?? '')
                      .toLowerCase()
                      .contains(value.toLowerCase())))
              .toList();
        }
      });
    }
  }
}
