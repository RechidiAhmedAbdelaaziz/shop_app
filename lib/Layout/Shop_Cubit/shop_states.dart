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