import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';

import '../s.dart';


class NoDataFound extends StatelessWidget {
  final onTap;
  final String message;
  NoDataFound({this.onTap, this.message = 'There is no record to show !'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
        color: Clr.colorPrimary,
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          height: 230,
          width: 230,
          child: Column(
            children: <Widget>[
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                  color: Clr.colorPrimary,
                  child: Icon(Icons.hourglass_empty, color: Colors.white,size: 80,),
                  elevation: 0,
                ),
              ),
              S.sDivider(),
              Txt(message,textColor: Colors.white,hasBold: true,),
              S.sDivider(),
              InkWell(
                onTap: onTap,
                child: Icon(Icons.refresh, color: Colors.white,size: 50,),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
