import 'package:ecom_fluter/controllers/cart_controller.dart';
import 'package:ecom_fluter/data/repository/popular_product_repo.dart';
import 'package:ecom_fluter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems=0;
  int get inCartItem => _inCartItems + _quantity;

  Future<void> getPopularProductList()async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode==200) {
      print("got products");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded=true;
      update();
    } else{
      print("error");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity+1);
    } else {
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems+quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more!",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
      if (_inCartItems > 0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems+quantity) > 20) {
      Get.snackbar("Item count", "You can't add more!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart=cart;
    var exist = false;
    exist = _cart.existInCart(product);
    // if exist
    // get from storage _inCartItem=3
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity=0;
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}