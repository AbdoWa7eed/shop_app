// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/layout/shop_layout.dart';
import 'package:frist_app/modules/login/login.dart';
import 'package:frist_app/modules/on_boarding_screen/on_boarding.dart';
import 'package:frist_app/shared/bloc_observer.dart';
import 'package:frist_app/shared/components/constants.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/network/local/chache_helper.dart';
import 'package:frist_app/shared/network/remote/dio_helper.dart';
import 'package:frist_app/shared/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.get(key: "Skipped");
  token = CacheHelper.get(key: "token");
  runApp(MyApp(
    startScreen: startScreen(onBoarding, token),
  ));

  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  Widget startScreen = OnBoardingScreen();
  MyApp({Key? key, required this.startScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopCubit()..getInitialData(),
        child: MaterialApp(
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: startScreen,
        ));
  }
}

Widget startScreen(onBoarding, token) {
  Widget widget;
  if (onBoarding == null) {
    widget = OnBoardingScreen();
  } else if (onBoarding) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  return widget;
}
