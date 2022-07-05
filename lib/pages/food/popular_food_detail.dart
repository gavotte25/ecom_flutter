import 'package:ecom_fluter/controllers/cart_controller.dart';
import 'package:ecom_fluter/controllers/popular_product_controller.dart';
import 'package:ecom_fluter/pages/cart/cart_page.dart';
import 'package:ecom_fluter/routes/route_helper.dart';
import 'package:ecom_fluter/utils/app_constants.dart';
import 'package:ecom_fluter/utils/dimensions.dart';
import 'package:ecom_fluter/widgets/app_column.dart';
import 'package:ecom_fluter/widgets/app_icon.dart';
import 'package:ecom_fluter/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../home/main_food_page.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!
                    )
                  )
                ),

              )
          ),
          // Icon widgets
          Positioned(
              top: 45,
              left: 20,
              right: 20,
              child: Row(
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
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                        onTap: () {
                          if (controller.totalItems>=1) {
                            Get.toNamed(RouteHelper.getCartPage());
                          }
                    },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems>=1?
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
              )
          ),
          // Instruction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 330,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: 20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: 20,),
                    Expanded(child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!)))
                  ],
                ),
          ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
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
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor,)),
                    SizedBox(width: 5,),
                    BigText(text: popularProduct.inCartItem.toString()),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor,))

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                      child: BigText(text: "\$ ${product.price!} " + "| Add to Card", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor
                  ),
                ),
              )
            ],
          ),
        );
      },),
    );
  }
}
