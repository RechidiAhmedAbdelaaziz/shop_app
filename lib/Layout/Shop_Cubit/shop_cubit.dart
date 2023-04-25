import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Modules/Screens/Categories/categories_screen.dart';
import 'package:shop_app/Modules/Screens/Favorites/favorites_screen.dart';
import 'package:shop_app/Modules/Screens/Products/product_screen.dart';
import 'package:shop_app/Modules/Screens/Settings/settings_screen.dart';
import 'package:shop_app/Moldels/home_models.dart';
import 'package:shop_app/Shared/Compenents/constants.dart';
import 'package:shop_app/Shared/Network/Remote/diohelper.dart';
import 'package:shop_app/Shared/Network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
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

      print(homeModel?.data.banners[0].image.toString());

      emit(SuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErorrHomeDataState(error.toString()));
    });
  }
}
