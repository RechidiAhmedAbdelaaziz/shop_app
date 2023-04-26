// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Modules/Screens/Categories/categories_screen.dart';
import 'package:shop_app/Modules/Screens/Favorites/favorites_screen.dart';
import 'package:shop_app/Modules/Screens/Products/product_screen.dart';
import 'package:shop_app/Modules/Screens/Settings/settings_screen.dart';
import 'package:shop_app/Moldels/categories_model.dart';
import 'package:shop_app/Moldels/home_models.dart';
import 'package:shop_app/Shared/Network/Remote/diohelper.dart';
import 'package:shop_app/Shared/Network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData({String? token}) {
    emit(LoadingHomeDataState());
    DioHelper.getData(
      token: token,
      url: HOME,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      emit(SuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErorrHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData({String? token}) {
    emit(LoadingCategoriesDataState());
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErorrCategoriesDataState(error.toString()));
    });
  }
}
