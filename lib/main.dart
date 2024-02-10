import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/routes/app_pages.dart';

import 'core/utils/design_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Interactive Cares",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
      initialBinding: BindingsX.initialBindigs(),
      theme: AppTheme.lightTheme,
      unknownRoute: AppPages.unknownRoute,
    );
  }
}