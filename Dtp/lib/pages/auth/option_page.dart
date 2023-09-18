import 'package:decisive_technology_products/pages/auth/login_page.dart';
import 'package:decisive_technology_products/pages/auth/signup_page.dart';
import 'package:decisive_technology_products/utils/btn.dart';
import 'package:decisive_technology_products/utils/pref.dart';
import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../s.dart';

class OptionPage extends StatefulWidget {
  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  int depositType = 0;

  @override
  void initState() {
    depositType = Pref.getPrefInt(Pref.language, defaultValue: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Clr.colorPrimary,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: deviceHeight * 0.3,
                  child: RotatedBox(
                    quarterTurns: 45,
                    child: FittedBox(
                        child: Txt(
                      'wel\nCome.'.tr,
                      textColor: Colors.white,
                      hasBold: true,
                      lineSpace: .9,
                    )),
                  ),
                ),
              ),
              S.sDivider(),
              Container(
                height: deviceHeight * 0.2,
                child: Image.asset('assets/images/dtp_white.png'),
              ),
              S.sDivider(),
              Container(
                height: deviceHeight * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Txt(
                      'english'.tr,
                      textColor: Colors.white,
                    ),
                    Radio(
                      value: 0,
                      groupValue: depositType,
                      onChanged: onLanguageChange,
                      activeColor: Colors.white,
                    ),
                    Txt(
                      'thai'.tr,
                      textColor: Colors.white,
                    ),
                    Radio(
                      value: 1,
                      groupValue: depositType,
                      onChanged: onLanguageChange,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
              ),
              S.sDivider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Btn('login'.tr,
                    backgroundColor: Clr.colorGreyButton,
                    textColor: Colors.black,
                    width: double.infinity,
                    onPressed: () =>
                        S.sSetRout(context, page: () => LoginPage())),
              ),
              S.sDivider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Btn(
                  'register_account'.tr,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  width: double.infinity,
                  onPressed: () =>
                      S.sSetRout(context, page: () => SignUpPage()),
                  borderColor: Colors.black,
                ),
              ),
              S.sDivider(),
              Container(
                  height: deviceHeight * 0.06,
                  child: Txt(
                    'all_rights_reserved_©_2021\nDecisive_technology_by_dot_designs'
                        .tr,
                    textColor: Colors.white,
                    size: Siz.h5,
                    textAlign: TextAlign.center,
                  )),
              S.sDivider(),
            ],
          ),
        ),
      ),
    );
  }

  onLanguageChange(int? value) {
    setState(() {
      depositType = value!;
      S.sOnLanguageChange(depositType);
    });
  }
}
