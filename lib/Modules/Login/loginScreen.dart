// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_cubit.dart';
import 'package:shop_app/Layout/homeScreen.dart';
import 'package:shop_app/Modules/Login/LoginCubit/loginCubit.dart';
import 'package:shop_app/Modules/Login/LoginCubit/loginStates.dart';
import 'package:shop_app/Modules/Register/registerScreen.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';
import 'package:shop_app/Shared/Compenents/constants.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token',
                      value: state.loginModel.data!.token.toString())
                  .then((value) {
                CacheHelper.saveData(
                    key: 'password', value: passwordController);
                userPassword = passwordController.text;
                token = state.loginModel.data!.token;
                ShopCubit.get(context).currentIndex = 0;
                replaceWith(context: context, widget: const HomeScreen());
              });
            } else {
              // Fluttertoast.showToast(
              //     msg: state.loginModel.message.toString(),
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 2,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 14.0);
            }
          }
        },
        builder: (context, state) {
          var formkey = GlobalKey<FormState>();
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFromFiled(
                          type: TextInputType.emailAddress,
                          prefix: const Icon(Icons.mail_outlined),
                          control: emailController,
                          lable: 'Email adrress',
                          valid: (value) {
                            if (value?.isEmpty == true) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFromFiled(
                          type: TextInputType.visiblePassword,
                          prefix: const Icon(Icons.key_outlined),
                          suffix: IconButton(
                              onPressed: () {
                                LoginCubit.get(context).showPass();
                              },
                              icon: LoginCubit.get(context).isShown
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          control: passwordController,
                          lable: 'Password',
                          secure: LoginCubit.get(context).isShown,
                          valid: (value) {
                            if (value!.length < 5) {
                              return 'The password is too short';
                            }
                            return null;
                          },
                          submit: (value) {
                            if (formkey.currentState?.validate() == true) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState?.validate() == true) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'LOGIN'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('If you dont have account?, '),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context: context,
                                      widget: const RegisterScreen());
                                },
                                child: const Text('Register'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
