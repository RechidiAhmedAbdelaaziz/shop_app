import 'package:shop_app/Moldels/change_favModel.dart';

abstract class ShopStates {}

class InitialState extends ShopStates {}

class ChangeBottomNavState extends ShopStates {}

class LoadingHomeDataState extends ShopStates {}

class SuccessHomeDataState extends ShopStates {}

class ErorrHomeDataState extends ShopStates {
  final String erorr;
  ErorrHomeDataState(this.erorr);
}

class LoadingCategoriesDataState extends ShopStates {}

class SuccessCategoriesDataState extends ShopStates {}

class ErorrCategoriesDataState extends ShopStates {
  final String erorr;
  ErorrCategoriesDataState(this.erorr);
}


class LoadingFavoritesDataState extends ShopStates {}

class SuccessFavoritesDataState extends ShopStates {}

class ErorrFavoritesDataState extends ShopStates {
  final String erorr;
  ErorrFavoritesDataState(this.erorr);
}



class InitialChangeFav extends ShopStates {}

class SuccessChangeFavState extends ShopStates {
  final ChangeFavModel changeFavModel;

  SuccessChangeFavState(this.changeFavModel);
}

class ErrorChangeFavState extends ShopStates {}
