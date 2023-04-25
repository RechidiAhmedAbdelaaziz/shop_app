// ignore_for_file: file_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Login/LoginCubit/loginStates.dart';
import 'package:shop_app/Moldels/login_model.dart';
import 'package:shop_app/Shared/Network/Remote/diohelper.dart';
import 'package:shop_app/Shared/Network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isShown = true;
  void showPass() {
    isShown = !isShown;
    emit(LoginPassVisibilityState());
  }

  late LoginModel loginModel;
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print( 'Error is ${error.toString()}');
      emit(LoginErrorState(error.toString()));
    });
  }
}
