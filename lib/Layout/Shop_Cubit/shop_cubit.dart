// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Modules/Screens/Categories/categories_screen.dart';
import 'package:shop_app/Modules/Screens/Favorites/favorites_screen.dart';
import 'package:shop_app/Modules/Screens/Products/product_screen.dart';
import 'package:shop_app/Modules/Screens/Settings/settings_screen.dart';
import 'package:shop_app/Moldels/categories_model.dart';
import 'package:shop_app/Moldels/change_favModel.dart';
import 'package:shop_app/Moldels/favoritesModel.dart';
import 'package:shop_app/Moldels/home_models.dart';
import 'package:shop_app/Moldels/login_model.dart';
import 'package:shop_app/Shared/Compenents/constants.dart';
import 'package:shop_app/Shared/Network/Remote/diohelper.dart';
import 'package:shop_app/Shared/Network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

     bool isShown = true;
  void showPass() {
    isShown = !isShown;
    emit(PassVisibilityState());
  }
  
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
  void getHomeData() {
    emit(LoadingHomeDataState());
    DioHelper.getData(
      token: token,
      url: HOME,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach(
        (element) {
          favorites.addAll({element.id: element.inFav!});
        },
      );
      getFavoritesData();
      emit(SuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErorrHomeDataState(error.toString()));
    });
  }

  Map<int, bool> favorites = {};
  late ChangeFavModel changeFavModel;
  void changeFav({
    required int id,
  }) {
    favorites[id] = !favorites[id]!;
    emit(InitialChangeFav());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      if (!changeFavModel.status) {
        favorites[id] = changeFavModel.status;
      } else {
        getFavoritesData();
      }
      emit(SuccessChangeFavState(changeFavModel));
    }).catchError((error) {
      favorites[id] = !favorites[id]!;
      print(error.toString());
      emit(ErrorChangeFavState());
    });
  }

  late FavoritesModel favoritesModel;
  void getFavoritesData() {
    emit(LoadingFavoritesDataState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(SuccessFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErorrFavoritesDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(LoadingCategoriesDataState());
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErorrCategoriesDataState(error.toString()));
    });
  }

  late LoginModel user;
  void getProfileData() {
    emit(LoadingProfileDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      user = LoginModel.fromJson(value.data);
      emit(SuccessProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErorrProfileDataState(error.toString()));
    });
  }

  void updateProfileData({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(LoadingUpdateProfileDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      user = LoginModel.fromJson(value.data);
      userPassword = password;
      emit(SuccessUpdateProfileDataState(user));
    }).catchError((error) {
      print(error.toString());
      emit(ErorrUpdateProfileDataState(error.toString()));
    });
  }
}
