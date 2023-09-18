import 'package:decisive_technology_products/main.dart';
import 'package:decisive_technology_products/pages/auth/option_page.dart';
import 'package:decisive_technology_products/s.dart';
import 'package:decisive_technology_products/utils/pref.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import 'controllers/auth/login_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(1.seconds, () {
        callInit();
      });
    });

    super.initState();
  }

  callInit() async {
    await Pref.getPref();
    String username = Pref.getPrefString(Pref.userName);
    String password = Pref.getPrefString(Pref.password);
    S.sOnLanguageChange(Pref.getPrefInt(Pref.language, defaultValue: 1));
    if (username != Str.NA || password != Str.NA) {
      final controller = Get.put(LoginController());
      controller.email.text = username;
      controller.password.text = password;
      bool result = await controller.onLoginTap();
      if (!result)
        S.sSetRout(context,
            page: () => OptionPage(), routeType: RouteType.PUSH_REPLACE);
    } else {
      S.sSetRout(context,
          page: () => OptionPage(), routeType: RouteType.PUSH_REPLACE);
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Material(
      color: Clr.colorPrimary,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Image.asset('assets/images/dtp_white.png'),
      ),
    );
  }
}
