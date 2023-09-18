import 'package:decisive_technology_products/models/notification/notification_model.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../s.dart';

class ShowMessagePage extends StatelessWidget {
  final Message message;
  const ShowMessagePage(this.message);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: S.sFocusOut(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(message.sender!.name),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: S.sBoxDecoration(
              filledColor: Colors.white,
              shadowColor: Colors.black.withOpacity(S.opacity),
              shadowRadius: 10),
          child: ListView(
            children: [
              Txt(
                'message_from '.tr + message.sender!.name,
                hasBold: true,
              ),
              S.sDivider(),
              Txt(message.message ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
