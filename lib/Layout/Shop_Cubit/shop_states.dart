import 'package:shop_app/Moldels/change_favModel.dart';
import 'package:shop_app/Moldels/login_model.dart';

abstract class ShopStates {}

class InitialState extends ShopStates {}

class PassVisibilityState extends ShopStates{}

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

class LoadingProfileDataState extends ShopStates {}

class SuccessProfileDataState extends ShopStates {}

class ErorrProfileDataState extends ShopStates {
  final String erorr;
  ErorrProfileDataState(this.erorr);
}

class LoadingUpdateProfileDataState extends ShopStates {}
class SuccessUpdateProfileDataState extends ShopStates {
  final LoginModel user;
  SuccessUpdateProfileDataState(this.user);
}
class ErorrUpdateProfileDataState extends ShopStates {
  final String erorr;
  ErorrUpdateProfileDataState(this.erorr);
}
