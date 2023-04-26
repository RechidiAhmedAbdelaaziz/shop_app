// ignore_for_file: unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_cubit.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';
import 'package:shop_app/Shared/Compenents/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        
        var model = ShopCubit.get(context).user;
        nameController.text = (model.data!.name)!;
        emailController.text = (model.data!.email)!;
        phoneController.text = (model.data!.phone)!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).user != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFromFiled(
                  control: nameController,
                  lable: 'Name',
                  type: TextInputType.name,
                  prefix: const Icon(Icons.person),
                  valid: (value) {
                    if (model.message?.contains('name') == true) {
                      return model.message;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFromFiled(
                  control: emailController,
                  lable: 'Email',
                  type: TextInputType.emailAddress,
                  prefix: const Icon(Icons.email),
                  valid: (value) {
                    if (model.message?.contains('email') == true) {
                      return model.message;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFromFiled(
                  control: phoneController,
                  lable: 'Phone',
                  type: TextInputType.phone,
                  prefix: const Icon(Icons.phone),
                  valid: (value) {
                    if (model.message?.contains('phone') == true) {
                      return model.message;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                defaultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'LogOut'.toUpperCase())
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
