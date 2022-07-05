import 'package:ecom_fluter/controllers/popular_product_controller.dart';
import 'package:ecom_fluter/controllers/recommended_product_controller.dart';
import 'package:ecom_fluter/routes/route_helper.dart';
import 'package:ecom_fluter/utils/app_constants.dart';
import 'package:ecom_fluter/utils/colors.dart';
import 'package:ecom_fluter/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      if (page=="cartpage") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                      onTap: (){
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                            right: 0, top: 0,
                            child: AppIcon(icon: Icons.circle, size:20, iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,)):
                        Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                            right: 3, top: 3,
                            child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                                size: 12, color: Colors.white)):
                        Container()
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(child: BigText(text: product.name!, size: 26)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))
                  ),
                ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      child: ExpandableTextWidget(text: product.description!),
                    ),
                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(backgroundColor: AppColors.mainColor, icon: Icons.remove, iconSize: 24,),
                  ),
                  BigText(text: "\$ ${product.price!} X  ${controller.inCartItem} ", color: AppColors.mainBlackColor, size: 26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(backgroundColor: AppColors.mainColor, icon: Icons.add, iconSize: 24,),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              padding: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                      child: BigText(text: "\$ ${product.price!} | Add to Card", color: Colors.white,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.mainColor
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },),
    );
  }
}
