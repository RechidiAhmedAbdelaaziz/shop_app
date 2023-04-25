import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/homeScreen.dart';
import 'package:shop_app/Modules/Login/loginScreen.dart';
import 'package:shop_app/Modules/onBoarding/onboarding_screen.dart';
import 'package:shop_app/Shared/Compenents/blocobserver.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:shop_app/Shared/Network/Remote/diohelper.dart';
import 'package:shop_app/Shared/Styles/Themes/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  CacheHelper.init();
  Widget widget;
  bool? onBoarding = await CacheHelper.getInf(key: 'onBoarding');
  print(onBoarding);
  String? token = CacheHelper.getData(key: 'token');
  if (onBoarding == true) {
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
