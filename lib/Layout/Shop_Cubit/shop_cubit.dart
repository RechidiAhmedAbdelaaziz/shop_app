import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Modules/Screens/Categories/categories_screen.dart';
import 'package:shop_app/Modules/Screens/Favorites/favorites_screen.dart';
import 'package:shop_app/Modules/Screens/Products/product_screen.dart';
import 'package:shop_app/Modules/Screens/Settings/settings_screen.dart';

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
}
