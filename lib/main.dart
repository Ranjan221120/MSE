import 'package:flutter/material.dart';
import 'package:get_x/get.dart';

import 'assignment/routes/app_pages.dart';
import 'assignment/routes/app_routes.dart';
import 'core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.data,
      darkTheme: AppTheme.darkTheme.data,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.loginScreen,
      getPages: AppPages.routes,
    );
}
}