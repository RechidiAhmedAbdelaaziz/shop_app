// ignore_for_file: file_names

import 'package:shop_app/Moldels/home_models.dart';

class FavoritesModel {
  late bool status;
  late Data data;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late List<ProductModel> products = [];
  Data.fromJson(Map<String, dynamic>? json) {
    json?['data'].forEach((element) {
      products.add(ProductModel.fromJson(element['product']));
    });
  }
}

