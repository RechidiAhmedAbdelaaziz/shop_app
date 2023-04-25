import 'package:flutter/material.dart';

class HomeModel {
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  late List<ProductModel> Products = [];
  late List<BannerModel> banners = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners']?.forEach((element) {
      banners.add(element);
    });
    json['products']?.forEach((element) {
      Products.add(element);
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFav, inCart;
  ProductModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
    name = json?['name'];
    inFav = json?['in_favorites'];
    inCart = json?['in_cart'];
  }
}