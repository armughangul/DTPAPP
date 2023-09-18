import 'package:decisive_technology_products/splash.dart';
import 'package:decisive_technology_products/translation/translation_file.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

double deviceWidth = 0;
double deviceHeight = 0;
double setHeight(double height) {
  return deviceHeight * height;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Decisive Technology Products',
      translations: Languages(),
      locale: Locale('th', 'th'),
      theme: ThemeData(
          primaryColor: Clr.colorPrimary,
          scaffoldBackgroundColor: Clr.colorGreyBackground,
          appBarTheme: AppBarTheme(backgroundColor: Clr.colorPrimary)),
      home: SplashPage(),
    );
  }
}
