import 'dart:io';

import 'package:ecom_fluter/controllers/popular_product_controller.dart';
import 'package:ecom_fluter/controllers/recommended_product_controller.dart';
import 'package:ecom_fluter/pages/food/popular_food_detail.dart';
import 'package:ecom_fluter/pages/food/recommended_food_detail.dart';
import 'package:ecom_fluter/pages/home/food_page_body.dart';
import 'package:ecom_fluter/pages/home/main_food_page.dart';
import 'package:ecom_fluter/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  HttpOverrides.global = PostHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}

class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}