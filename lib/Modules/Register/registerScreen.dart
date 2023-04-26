// ignore_for_file: file_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_cubit.dart';
import 'package:shop_app/Layout/homeScreen.dart';
import 'package:shop_app/Modules/Login/loginScreen.dart';
import 'package:shop_app/Modules/Register/RegisterCubit/registerCubit.dart';
import 'package:shop_app/Modules/Register/RegisterCubit/registerStates.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';
import 'package:shop_app/Shared/Compenents/constants.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token',
                      value: state.loginModel.data!.token.toString())
                  .then((value) {
                CacheHelper.saveData(key: 'password', value: passwordController)
                    .then((value) {
                  if (value == true) {
                    userPassword = passwordController.text;
                    token = state.loginModel.data!.token;
                  }
                });

                ShopCubit.get(context).currentIndex = 0;
                replaceWith(context: context, widget: const HomeScreen());
              });
            } else {}
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
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'SignUp now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFromFiled(
                          type: TextInputType.name,
                          prefix: const Icon(Icons.person),
                          control: nameController,
                          lable: 'Name',
                          valid: (value) {
                            if (value?.isEmpty == true) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
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
                          type: TextInputType.emailAddress,
                          prefix: const Icon(Icons.phone),
                          control: phoneController,
                          lable: 'Phone number',
                          valid: (value) {
                            if (value?.isEmpty == true) {
                              return 'Please enter your phone number';
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
                                RegisterCubit.get(context).showPass();
                              },
                              icon: RegisterCubit.get(context).isShown
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          control: passwordController,
                          lable: 'Password',
                          secure: RegisterCubit.get(context).isShown,
                          valid: (value) {
                            if (value?.isEmpty == true) {
                              return "The password can't be empty";
                            }
                            return null;
                          },
                          submit: (value) {
                            if (formkey.currentState?.validate() == true) {
                              RegisterCubit.get(context).userRegister(
                                phone: phoneController.text,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState?.validate() == true) {
                                  RegisterCubit.get(context).userRegister(
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Register'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('If you have account?, '),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context: context,
                                      widget: const LoginScreen());
                                },
                                child: const Text('Login'))
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
