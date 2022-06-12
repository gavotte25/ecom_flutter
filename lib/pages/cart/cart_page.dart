import 'package:ecom_fluter/controllers/cart_controller.dart';
import 'package:ecom_fluter/pages/home/main_food_page.dart';
import 'package:ecom_fluter/utils/app_constants.dart';
import 'package:ecom_fluter/widgets/app_icon.dart';
import 'package:ecom_fluter/widgets/big_text.dart';
import 'package:ecom_fluter/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              top: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                  iconSize: 24,),
                  SizedBox(width: 100,),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: 24,),
                  ),
                  AppIcon(icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 24,)
                ],
              )),
          Positioned(
              top: 100,
              left: 20,
              right: 20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                  removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController){
                  return ListView.builder(
                    itemCount: cartController.getItems.length,
                      itemBuilder: (_, index){
                    return Container(
                      height: 100,
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!
                                    )
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(child: Container(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(text: cartController.getItems[index].name!, color: Colors.black),
                                SmallText(text: "Spicy"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent,),
                                    Container(
                                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                              onTap: (){
                                                // popularProduct.setQuantity(false);
                                              },
                                              child: Icon(Icons.remove, color: AppColors.signColor,)),
                                          SizedBox(width: 5,),
                                          BigText(text: "0"),
                                          SizedBox(width: 5),
                                          GestureDetector(
                                              onTap: (){
                                                // popularProduct.setQuantity(true);
                                              },
                                              child: Icon(Icons.add, color: AppColors.signColor,))

                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  });
                },),
              ),
            ))
          ],
      ),
    );
  }
}
