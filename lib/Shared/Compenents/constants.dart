import 'package:shop_app/Modules/Login/loginScreen.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

void SignOut(context) {
  CacheHelper.clearData(key: 'token').then((value) {
    if (value == true) {
      replaceWith(context: context, widget: LoginScreen());
    }
  });
}

void printFullText({required String text}) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String? token = '';