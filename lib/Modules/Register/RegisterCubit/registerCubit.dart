// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Register/RegisterCubit/registerStates.dart';
import 'package:shop_app/Moldels/login_model.dart';
import 'package:shop_app/Shared/Network/Remote/diohelper.dart';
import 'package:shop_app/Shared/Network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isShown = true;
  void showPass() {
    isShown = !isShown;
    emit(RegisterPassVisibilityState());
  }

  late LoginModel registerModel;
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      registerModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      // ignore: avoid_print
      print('Error is ${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    });
  }
}
