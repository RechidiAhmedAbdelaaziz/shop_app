// ignore_for_file: file_names

import 'package:shop_app/Moldels/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginPassVisibilityState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginSuccessState extends LoginStates {
  LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
