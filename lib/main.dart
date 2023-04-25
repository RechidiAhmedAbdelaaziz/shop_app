// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_cubit.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Layout/homeScreen.dart';
import 'package:shop_app/Modules/Login/loginScreen.dart';
import 'package:shop_app/Modules/onBoarding/onboarding_screen.dart';
import 'package:shop_app/Shared/Compenents/blocobserver.dart';
import 'package:shop_app/Shared/Compenents/constants.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:shop_app/Shared/Network/Remote/diohelper.dart';
import 'package:shop_app/Shared/Styles/Themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getInf(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding == true) {
    if (token != null) {
      widget = const HomeScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  
  MyApp(this.widget,{super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit()..getHomeData(token: token),
          )
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: widget,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
              );
            }));
  }
}
