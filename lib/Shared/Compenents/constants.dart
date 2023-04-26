// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app/Modules/Login/loginScreen.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

Widget myDivider() => const Padding(
      padding: EdgeInsets.all(22.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey,
      ),
    );

void signOut(context) {
  CacheHelper.clearData(key: 'token').then((value) {
    if (value == true) {
      replaceWith(context: context, widget: const LoginScreen());
    }
  });
}

void printFullText({required String text}) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String? token = '';
