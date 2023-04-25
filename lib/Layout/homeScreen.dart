// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_app/Modules/Login/loginScreen.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: TextButton(
            child: Text('SIGN OUT'),
            onPressed: () {
              CacheHelper.clearData(key: 'token');
              replaceWith(context: context, widget: LoginScreen());
            },
          ),
        ),
      ),
    );
  }
}
